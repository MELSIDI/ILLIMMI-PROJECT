#!/usr/bin/env python3
"""
drive_corpus_sync.py - Incremental Google Drive Cloud Sync for ILLIMMI.

Automatically runs at the end of each batch (e.g. under /corpus-illimmi or /goal):
1. Exports refreshed Gemma SFT training JSONLs.
2. Packages ONLY new or re-certified courses into compressed .zip archives
   in a single flat local cache (corpus_exports/courses_archives/).
3. Resolves the canonical flat folder structure on Google Drive (without releases/):
     ILLIMMI_CORPUS_STORE / (courses_archives, training_data, catalog, corpus_manifest.json)
4. Uploads ONLY new archives (or updates re-certified ones in-place via mutate update),
   never re-packaging or re-uploading courses already present on Google Drive.
5. Updates catalog/, training_data/, and corpus_manifest.json in-place on Drive,
   recording dated sync metadata (last_sync_date, sync_batches, gdrive_synced_at).
6. Commits and pushes the lightweight corpus_manifest.json to GitHub (origin/dsl_dev).
"""

import argparse
import hashlib
import io
import json
import os
import shutil
import subprocess
import sys
import tarfile
import zipfile
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

if sys.platform == "win32":
    if isinstance(sys.stdout, io.TextIOWrapper):
        sys.stdout.reconfigure(encoding="utf-8")
    if isinstance(sys.stderr, io.TextIOWrapper):
        sys.stderr.reconfigure(encoding="utf-8")

PROJECT_ROOT = Path(__file__).resolve().parents[4]
CORPUS_DIR = PROJECT_ROOT / "corpus_illimmi_1000"
COURSES_DIR = CORPUS_DIR / "courses"
CATALOG_DIR = CORPUS_DIR / "catalog"
TRAINING_DIR = CORPUS_DIR / "training_data"
MANIFEST_PATH = CORPUS_DIR / "corpus_manifest.json"
DEFAULT_EXPORT_DIR = PROJECT_ROOT / "corpus_exports"
LOCAL_ARCHIVES_CACHE = DEFAULT_EXPORT_DIR / "courses_archives"


def find_gdrive_bin() -> str:
    """Finds the installed gdrive CLI binary executable."""
    home = Path(os.environ.get("USERPROFILE") or os.environ.get("HOME") or "")
    plugin_bin_dir = home / ".gemini" / "antigravity" / "plugin_data" / "gdrive" / "bin"
    if plugin_bin_dir.exists():
        for exe in plugin_bin_dir.glob("gdrive*.exe"):
            return str(exe)

    sh_path = shutil.which("gdrive")
    if sh_path:
        return sh_path

    raise FileNotFoundError("Could not find gdrive executable in plugin_data or PATH.")


def compute_sha256(file_path: Path) -> str:
    """Computes SHA-256 hexadecimal digest for a file."""
    h = hashlib.sha256()
    with open(file_path, "rb") as f:
        while chunk := f.read(65536):
            h.update(chunk)
    return h.hexdigest()


def run_gdrive_cmd(cmd_args: List[str]) -> Tuple[int, str, str]:
    """Runs a gdrive command and returns (returncode, stdout, stderr)."""
    gdrive_bin = find_gdrive_bin()
    full_cmd = [gdrive_bin] + cmd_args
    proc = subprocess.run(full_cmd, capture_output=True, text=True)
    return proc.returncode, proc.stdout.strip(), proc.stderr.strip()


def list_drive_folder_items(folder_id: Optional[str] = None) -> List[Dict[str, Any]]:
    """Lists all non-trashed items in a Drive folder (--max 0 = unlimited)."""
    args = ["readonly", "ls"]
    if folder_id:
        args.append(folder_id)
    args.extend(["--max", "0", "--json"])

    rc, out, err = run_gdrive_cmd(args)
    if rc != 0 or not out:
        return []

    try:
        items = json.loads(out)
        return items if isinstance(items, list) else []
    except Exception:
        return []


def list_drive_folder(folder_id: Optional[str] = None) -> Dict[str, str]:
    """Lists items in a Drive folder and returns mapping: {name: id}."""
    items = list_drive_folder_items(folder_id)
    # Keep newest item first if duplicates ever appear (list is sorted or ordered)
    mapping: Dict[str, str] = {}
    for item in items:
        name = item.get("name")
        fid = item.get("id")
        if name and fid and name not in mapping:
            mapping[name] = fid
    return mapping


def find_or_create_drive_folder(
    name: str,
    parent_id: Optional[str] = None,
    preferred_id: Optional[str] = None,
) -> str:
    """Finds an existing folder (by preferred_id, search, or ls --max 0) or creates it."""
    existing = list_drive_folder(parent_id)
    if preferred_id and preferred_id in existing.values():
        return preferred_id
    if name in existing:
        return existing[name]

    # When searching at Drive root, also verify via exact search in case ls order varies
    if parent_id is None:
        rc, out, _ = run_gdrive_cmd(
            ["readonly", "search", "--name-exact", name, "--type", "folder", "--max", "50", "--json"]
        )
        if rc == 0 and out:
            try:
                matches = json.loads(out)
                if isinstance(matches, list) and matches:
                    if preferred_id:
                        for m in matches:
                            if m.get("id") == preferred_id:
                                return preferred_id
                    return matches[0]["id"]
            except Exception:
                pass

    args = ["mutate", "mkdir", name]
    if parent_id:
        args.extend(["--parent", parent_id])

    rc, out, err = run_gdrive_cmd(args)
    if rc != 0:
        raise RuntimeError(f"Failed to create Google Drive folder '{name}': {err or out}")

    if "(ID: " in out:
        return out.split("(ID: ")[1].rstrip(")")

    existing = list_drive_folder(parent_id)
    if name in existing:
        return existing[name]

    raise RuntimeError(f"Could not retrieve folder ID for '{name}'. Output: {out}")


def load_existing_manifest() -> Dict[str, Any]:
    """Loads existing corpus_manifest.json if present."""
    if MANIFEST_PATH.exists():
        try:
            data = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
            if isinstance(data, dict):
                return data
        except Exception:
            pass
    return {}


def package_course(course_id: str, output_dir: Path, archive_format: str = "zip") -> Dict[str, Any]:
    """Packages heavy binary assets for a course (renders, raw audio, transcripts)."""
    cdir = COURSES_DIR / course_id
    if not cdir.exists():
        raise FileNotFoundError(f"Course directory not found: {cdir}")

    output_dir.mkdir(parents=True, exist_ok=True)
    archive_name = f"{course_id}.{archive_format}"
    archive_path = output_dir / archive_name

    meta_file = cdir / "metadata.json"
    course_version = "1.0"
    if meta_file.exists():
        try:
            mdata = json.loads(meta_file.read_text(encoding="utf-8"))
            course_version = mdata.get("version", "1.0")
        except Exception:
            pass

    files_to_pack = [item for item in cdir.rglob("*") if item.is_file()]

    if archive_format == "zip":
        with zipfile.ZipFile(archive_path, "w", zipfile.ZIP_DEFLATED) as zf:
            for f in sorted(files_to_pack):
                arcname = f.relative_to(cdir)
                zf.write(f, arcname=str(arcname))
    elif archive_format in ("tar.gz", "tgz"):
        with tarfile.open(archive_path, "w:gz") as tf:
            for f in sorted(files_to_pack):
                arcname = f.relative_to(cdir)
                tf.add(f, arcname=str(arcname))

    sha = compute_sha256(archive_path)
    size_bytes = archive_path.stat().st_size

    return {
        "course_id": course_id,
        "version": course_version,
        "archive_file": archive_name,
        "archive_path": str(archive_path),
        "sha256": sha,
        "size_bytes": size_bytes,
        "size_mb": round(size_bytes / (1024 * 1024), 2),
    }


def upload_to_drive(gdrive_bin: str, file_path: Path, parent_id: str) -> str:
    """Uploads a new file to Google Drive under parent_id and returns file ID."""
    cmd = [gdrive_bin, "mutate", "upload", str(file_path), "--parent", parent_id]
    proc = subprocess.run(cmd, capture_output=True, text=True, check=True)
    out = proc.stdout.strip()
    fid = ""
    if "(ID: " in out:
        fid = out.split("(ID: ")[1].rstrip(")")
    return fid


def upsert_to_drive(
    gdrive_bin: str,
    file_path: Path,
    parent_id: str,
    existing_remote: Dict[str, str],
) -> Tuple[str, str]:
    """Updates an existing Drive file in-place or uploads a new one."""
    if file_path.name in existing_remote:
        fid = existing_remote[file_path.name]
        cmd = [gdrive_bin, "mutate", "update", fid, str(file_path)]
        subprocess.run(cmd, capture_output=True, text=True, check=True)
        return fid, "updated"

    fid = upload_to_drive(gdrive_bin, file_path, parent_id)
    existing_remote[file_path.name] = fid
    return fid, "uploaded"


def generate_manifest(
    release_tag: Optional[str] = None,
    archive_dir: Optional[Path] = None,
    gdrive_ids: Optional[Dict[str, str]] = None,
    gdrive_meta: Optional[Dict[str, Any]] = None,
    course_sync_meta: Optional[Dict[str, Dict[str, str]]] = None,
    courses_added: Optional[List[str]] = None,
    courses_updated: Optional[List[str]] = None,
    existing_manifest: Optional[Dict[str, Any]] = None,
    sync_timestamp: Optional[str] = None,
) -> Dict[str, Any]:
    """Builds the lightweight corpus_manifest.json with dated sync metadata."""
    progress_file = CATALOG_DIR / "progress.json"
    if not progress_file.exists():
        raise FileNotFoundError(f"Progress file not found: {progress_file}")

    progress = json.loads(progress_file.read_text(encoding="utf-8"))
    completed = progress.get("completed_courses", {})

    if existing_manifest is None:
        existing_manifest = load_existing_manifest()
    existing_courses = existing_manifest.get("courses", {}) if isinstance(existing_manifest.get("courses"), dict) else {}

    now_iso = sync_timestamp or datetime.now(timezone.utc).isoformat()
    sync_date = now_iso[:10]
    effective_tag = release_tag or f"sync-{sync_date}"

    courses_manifest: Dict[str, Any] = {}
    total_duration = 0.0
    total_words = 0
    total_scenes = 0

    for cid, info in sorted(completed.items()):
        dur = float(info.get("duration_seconds", 0.0))
        wcnt = int(info.get("word_count", 0))
        scenes = int(info.get("rendered_scenes", 0))

        total_duration += dur
        total_words += wcnt
        total_scenes += scenes

        prev_entry = existing_courses.get(cid, {})
        sync_info = (course_sync_meta or {}).get(cid, {})

        c_entry: Dict[str, Any] = {
            "title": info.get("title", ""),
            "duration_seconds": dur,
            "word_count": wcnt,
            "rendered_scenes": scenes,
            "world_model_score": info.get("world_model_score", 10.0),
            "video_id": info.get("video_id", ""),
            "certified_at": info.get("certified_at", ""),
            "gdrive_archive": f"{cid}.zip",
        }

        # Reuse archive hash/size if local zip isn't present or wasn't re-packaged
        afile = (archive_dir / f"{cid}.zip") if archive_dir else (LOCAL_ARCHIVES_CACHE / f"{cid}.zip")
        if afile.exists() and not prev_entry.get("archive_sha256"):
            c_entry["archive_sha256"] = compute_sha256(afile)
            c_entry["archive_size_mb"] = round(afile.stat().st_size / (1024 * 1024), 2)
        elif afile.exists() and (cid in (courses_added or []) or cid in (courses_updated or [])):
            c_entry["archive_sha256"] = compute_sha256(afile)
            c_entry["archive_size_mb"] = round(afile.stat().st_size / (1024 * 1024), 2)
        else:
            if "archive_sha256" in prev_entry:
                c_entry["archive_sha256"] = prev_entry["archive_sha256"]
            elif afile.exists():
                c_entry["archive_sha256"] = compute_sha256(afile)
            if "archive_size_mb" in prev_entry:
                c_entry["archive_size_mb"] = prev_entry["archive_size_mb"]
            elif afile.exists():
                c_entry["archive_size_mb"] = round(afile.stat().st_size / (1024 * 1024), 2)

        fid = (gdrive_ids or {}).get(cid) or prev_entry.get("gdrive_file_id")
        if fid:
            c_entry["gdrive_file_id"] = fid
            c_entry["gdrive_download_url"] = f"https://drive.google.com/uc?id={fid}&export=download"

        synced_at = sync_info.get("gdrive_synced_at") or prev_entry.get("gdrive_synced_at")
        batch_date = sync_info.get("sync_batch_date") or prev_entry.get("sync_batch_date")
        if synced_at:
            c_entry["gdrive_synced_at"] = synced_at
        if batch_date:
            c_entry["sync_batch_date"] = batch_date

        courses_manifest[cid] = c_entry

    sync_batches: List[Dict[str, Any]] = list(existing_manifest.get("sync_batches", []))
    added_list = sorted(courses_added or [])
    updated_list = sorted(courses_updated or [])
    if added_list or updated_list or not sync_batches:
        sync_batches.append({
            "date": sync_date,
            "synced_at": now_iso,
            "tag": effective_tag,
            "courses_added": added_list,
            "courses_updated": updated_list,
            "total_courses": len(courses_manifest),
        })

    manifest_data = {
        "release_tag": effective_tag,
        "last_sync_date": sync_date,
        "updated_at": now_iso,
        "total_courses": len(courses_manifest),
        "total_duration_hours": round(total_duration / 3600.0, 3),
        "total_words": total_words,
        "total_scenes": total_scenes,
        "sync_batches": sync_batches,
        "courses": courses_manifest,
        "gdrive_store": gdrive_meta or existing_manifest.get("gdrive_store") or {
            "root_folder_name": "ILLIMMI_CORPUS_STORE",
            "layout": "flat",
        },
    }

    with open(MANIFEST_PATH, "w", encoding="utf-8") as f:
        json.dump(manifest_data, f, indent=2, ensure_ascii=False)

    return manifest_data


def package_missing_local(force: bool = False) -> Path:
    """Packages only missing (or all if force=True) certified courses into LOCAL_ARCHIVES_CACHE."""
    progress_file = CATALOG_DIR / "progress.json"
    if not progress_file.exists():
        raise FileNotFoundError(f"Missing {progress_file}")

    progress = json.loads(progress_file.read_text(encoding="utf-8"))
    completed_ids = sorted(progress.get("completed_courses", {}).keys())
    LOCAL_ARCHIVES_CACHE.mkdir(parents=True, exist_ok=True)

    for cid in completed_ids:
        target_zip = LOCAL_ARCHIVES_CACHE / f"{cid}.zip"
        if force or not target_zip.exists():
            res = package_course(cid, LOCAL_ARCHIVES_CACHE, archive_format="zip")
            print(f"  -> Packaged {cid}: {res['archive_file']} ({res['size_mb']} MB)")

    return LOCAL_ARCHIVES_CACHE


def auto_sync_to_gdrive(
    release_tag: Optional[str] = None,
    push_git: bool = True,
    force: bool = False,
) -> Dict[str, Any]:
    """
    Incremental automated entry point called when subagents finish a batch of courses.
    1. Refreshes training JSONL exports.
    2. Resolves canonical flat Google Drive store: ILLIMMI_CORPUS_STORE / (courses_archives, training_data, catalog).
    3. Inspects existing Drive archives (--max 0) and skips any already present (unless re-certified or --force).
    4. Packages and uploads ONLY new courses (or updates re-certified ones in-place).
    5. Updates catalog/, training_data/, and corpus_manifest.json in-place on Drive with dated metadata.
    6. Optionally commits and pushes corpus_manifest.json to Git.
    """
    progress_file = CATALOG_DIR / "progress.json"
    if not progress_file.exists():
        raise FileNotFoundError(f"Missing {progress_file}")

    progress = json.loads(progress_file.read_text(encoding="utf-8"))
    completed_map = progress.get("completed_courses", {})
    completed_ids = sorted(completed_map.keys())
    total_completed = len(completed_ids)

    existing_manifest = load_existing_manifest()
    existing_courses = existing_manifest.get("courses", {}) if isinstance(existing_manifest.get("courses"), dict) else {}
    prev_store = existing_manifest.get("gdrive_store", {}) if isinstance(existing_manifest.get("gdrive_store"), dict) else {}

    now_iso = datetime.now(timezone.utc).isoformat()
    sync_date = now_iso[:10]
    effective_tag = release_tag or f"sync-{sync_date}"

    print("\n=======================================================")
    print(f"☁️ INCREMENTAL GOOGLE DRIVE SYNC ({effective_tag})")
    print("=======================================================")
    print(f"Total certified courses: {total_completed}")

    # 1. Refresh training JSONL export
    export_script = PROJECT_ROOT / ".agents" / "skills" / "corpus-illimmi" / "scripts" / "export_certified_jsonl.py"
    if export_script.exists():
        print("🔄 Refreshing Gemma SFT training JSONL exports...")
        subprocess.run([sys.executable, str(export_script)], check=True)

    # 2. Locate canonical flat folder structure on Google Drive (no releases/ duplication)
    gdrive_bin = find_gdrive_bin()
    print("\n🔍 Resolving canonical Google Drive store (flat layout)...")
    root_id = find_or_create_drive_folder(
        "ILLIMMI_CORPUS_STORE",
        parent_id=None,
        preferred_id=prev_store.get("root_folder_id"),
    )
    courses_archives_id = find_or_create_drive_folder(
        "courses_archives",
        parent_id=root_id,
        preferred_id=prev_store.get("courses_archives_id"),
    )
    training_data_id = find_or_create_drive_folder(
        "training_data",
        parent_id=root_id,
        preferred_id=prev_store.get("training_data_id"),
    )
    catalog_id = find_or_create_drive_folder(
        "catalog",
        parent_id=root_id,
        preferred_id=prev_store.get("catalog_id"),
    )

    # 3. Incremental check against remote archives (--max 0 lists ALL files!)
    existing_remote_archives = list_drive_folder(courses_archives_id)
    LOCAL_ARCHIVES_CACHE.mkdir(parents=True, exist_ok=True)

    gdrive_file_ids: Dict[str, str] = {}
    course_sync_meta: Dict[str, Dict[str, str]] = {}
    courses_added: List[str] = []
    courses_updated: List[str] = []
    skipped_count = 0

    print(f"\n☁️ Checking {total_completed} certified courses against {len(existing_remote_archives)} remote Drive archives...")
    for idx, cid in enumerate(completed_ids, 1):
        arch_name = f"{cid}.zip"
        remote_fid = existing_remote_archives.get(arch_name)
        prev_entry = existing_courses.get(cid, {})
        certified_at = str(completed_map[cid].get("certified_at", ""))
        prev_synced_at = str(prev_entry.get("gdrive_synced_at", ""))

        is_recertified = bool(remote_fid and prev_synced_at and certified_at and certified_at > prev_synced_at)

        if remote_fid and not force and not is_recertified:
            skipped_count += 1
            gdrive_file_ids[cid] = remote_fid
            course_sync_meta[cid] = {
                "gdrive_synced_at": prev_synced_at or now_iso,
                "sync_batch_date": prev_entry.get("sync_batch_date") or (certified_at[:10] if certified_at else sync_date),
            }
            print(f"  [{idx}/{total_completed}] {arch_name} -> déjà sur Drive (ID: {remote_fid}) [ignoré]")
            continue

        # Package ONLY this new or updated course
        pkg = package_course(cid, LOCAL_ARCHIVES_CACHE, archive_format="zip")
        arch_path = Path(pkg["archive_path"])

        if remote_fid:
            print(f"  [{idx}/{total_completed}] Updating {arch_name} in-place ({pkg['size_mb']} MB)...")
            fid, _ = upsert_to_drive(gdrive_bin, arch_path, courses_archives_id, existing_remote_archives)
            courses_updated.append(cid)
        else:
            print(f"  [{idx}/{total_completed}] Uploading NEW {arch_name} ({pkg['size_mb']} MB)...")
            fid = upload_to_drive(gdrive_bin, arch_path, courses_archives_id)
            existing_remote_archives[arch_name] = fid
            courses_added.append(cid)

        print(f"    ☁️ OK -> GDrive ID: {fid}")
        gdrive_file_ids[cid] = fid
        course_sync_meta[cid] = {
            "gdrive_synced_at": now_iso,
            "sync_batch_date": sync_date,
        }

    print(
        f"\n📊 Delta summary: {len(courses_added)} uploaded, {len(courses_updated)} updated, "
        f"{skipped_count} skipped (already on Drive)."
    )

    # 4. Update catalog files in-place on Drive
    print("\n☁️ Updating catalog snapshot in-place on Google Drive...")
    existing_remote_catalog = list_drive_folder(catalog_id)
    for cat_f in sorted(CATALOG_DIR.glob("*")):
        if cat_f.is_file() and not cat_f.name.startswith("."):
            fid, action = upsert_to_drive(gdrive_bin, cat_f, catalog_id, existing_remote_catalog)
            print(f"  [{action}] catalog/{cat_f.name} -> {fid}")

    # 5. Update training datasets in-place on Drive
    if TRAINING_DIR.exists():
        print("\n☁️ Updating training datasets in-place on Google Drive...")
        existing_remote_training = list_drive_folder(training_data_id)
        for tr_f in sorted(TRAINING_DIR.glob("*.jsonl")):
            fid, action = upsert_to_drive(gdrive_bin, tr_f, training_data_id, existing_remote_training)
            print(f"  [{action}] training_data/{tr_f.name} -> {fid}")

    # 6. Build and upsert corpus_manifest.json in-place at store root
    existing_root_files = list_drive_folder(root_id)
    manifest_file_id = prev_store.get("manifest_file_id") or existing_root_files.get("corpus_manifest.json", "")

    gdrive_meta = {
        "root_folder_name": "ILLIMMI_CORPUS_STORE",
        "layout": "flat",
        "root_folder_id": root_id,
        "courses_archives_id": courses_archives_id,
        "training_data_id": training_data_id,
        "catalog_id": catalog_id,
        "manifest_file_id": manifest_file_id,
        "store_url": f"https://drive.google.com/drive/folders/{root_id}",
    }

    manifest = generate_manifest(
        release_tag=effective_tag,
        archive_dir=LOCAL_ARCHIVES_CACHE,
        gdrive_ids=gdrive_file_ids,
        gdrive_meta=gdrive_meta,
        course_sync_meta=course_sync_meta,
        courses_added=courses_added,
        courses_updated=courses_updated,
        existing_manifest=existing_manifest,
        sync_timestamp=now_iso,
    )

    manifest_fid, manifest_action = upsert_to_drive(gdrive_bin, MANIFEST_PATH, root_id, existing_root_files)
    if manifest_fid != manifest["gdrive_store"].get("manifest_file_id"):
        manifest["gdrive_store"]["manifest_file_id"] = manifest_fid
        with open(MANIFEST_PATH, "w", encoding="utf-8") as f:
            json.dump(manifest, f, indent=2, ensure_ascii=False)
        upsert_to_drive(gdrive_bin, MANIFEST_PATH, root_id, existing_root_files)
    print(f"\n  [{manifest_action}] corpus_manifest.json -> {manifest_fid}")

    # 7. Git sync (lightweight manifest commit only)
    if push_git:
        print("\n🔄 Committing and pushing lightweight manifest to Git/GitHub...")
        subprocess.run(["git", "add", str(MANIFEST_PATH)], cwd=PROJECT_ROOT, check=True)
        diff_proc = subprocess.run(["git", "diff", "--cached", "--quiet"], cwd=PROJECT_ROOT)
        if diff_proc.returncode != 0:
            commit_msg = (
                f"chore(corpus): sync corpus_manifest.json ({effective_tag}: "
                f"+{len(courses_added)} new, {len(courses_updated)} updated, {total_completed} total)"
            )
            subprocess.run(["git", "commit", "-m", commit_msg], cwd=PROJECT_ROOT, check=True)
            subprocess.run(["git", "push", "origin", "dsl_dev"], cwd=PROJECT_ROOT, check=True)
        else:
            print("  No manifest changes to commit.")

    print("\n=======================================================")
    print("🎉 INCREMENTAL GOOGLE DRIVE SYNC FINISHED SUCCESSFULLY!")
    print(f"   Sync Tag/Date: {effective_tag} ({total_completed} courses)")
    print(f"   Delta: +{len(courses_added)} new | ~{len(courses_updated)} updated | ={skipped_count} skipped")
    print(f"   Drive Store URL: https://drive.google.com/drive/folders/{root_id}")
    print("=======================================================\n")
    return manifest


def main():
    parser = argparse.ArgumentParser(description="ILLIMMI Corpus Incremental Google Drive Sync")
    subparsers = parser.add_subparsers(dest="action", required=True)

    # auto-sync (Primary orchestrator command)
    p_auto = subparsers.add_parser("auto-sync", help="Incremental package, Drive upload/update, and manifest git push")
    p_auto.add_argument("--tag", default=None, help="Optional sync tag metadata (defaults to sync-YYYY-MM-DD)")
    p_auto.add_argument("--no-git", action="store_true", help="Skip git commit/push")
    p_auto.add_argument("--force", action="store_true", help="Force re-package and re-upload all certified courses")

    # package-course
    p_course = subparsers.add_parser("package-course", help="Package a single course into a zip archive")
    p_course.add_argument("--course-id", required=True, help="Course ID (e.g. MATH_001)")
    p_course.add_argument("--output-dir", default=str(LOCAL_ARCHIVES_CACHE), help="Output directory")

    # package-cache (replaces legacy duplicate package-release)
    p_cache = subparsers.add_parser("package-cache", help="Package only missing certified courses into local flat cache")
    p_cache.add_argument("--force", action="store_true", help="Re-package all courses")

    # manifest
    p_man = subparsers.add_parser("manifest", help="Regenerate corpus_manifest.json locally")
    p_man.add_argument("--tag", default=None, help="Optional sync tag metadata")

    args = parser.parse_args()

    if args.action == "auto-sync":
        auto_sync_to_gdrive(release_tag=args.tag, push_git=not args.no_git, force=args.force)
    elif args.action == "package-course":
        res = package_course(args.course_id, Path(args.output_dir))
        print(json.dumps(res, indent=2))
    elif args.action == "package-cache":
        package_missing_local(force=args.force)
    elif args.action == "manifest":
        man = generate_manifest(release_tag=args.tag)
        print(json.dumps(man, indent=2))


if __name__ == "__main__":
    main()
