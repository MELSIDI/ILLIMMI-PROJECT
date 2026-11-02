#!/usr/bin/env python3
"""
drive_corpus_sync.py - Autonomous Google Drive Cloud Sync & Semantic Versioning Tool for ILLIMMI.

Automatically runs at the end of each batch (e.g. 15, 20 courses under /goal):
1. Exports refreshed Gemma SFT training JSONLs.
2. Packages new/modified certified courses into compressed .zip archives with SHA-256 signatures.
3. Finds or creates the folder structure on Google Drive:
     ILLIMMI_CORPUS_STORE / releases / <tag> / (courses_archives, training_data, catalog)
4. Uploads missing/updated archives to Google Drive.
5. Injects Google Drive file IDs and web links into corpus_manifest.json.
6. Automatically commits and pushes the updated corpus_manifest.json to GitHub (keeping Git <30MB).
"""

import argparse
import hashlib
import io
import json
import os
import re
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


def list_drive_folder(folder_id: Optional[str] = None) -> Dict[str, str]:
    """Lists items in a Drive folder and returns mapping: {name: id}."""
    args = ["readonly", "ls", "--json"]
    if folder_id:
        args = ["readonly", "ls", folder_id, "--json"]

    rc, out, err = run_gdrive_cmd(args)
    if rc != 0 or not out:
        return {}

    try:
        items = json.loads(out)
        return {item["name"]: item["id"] for item in items if "name" in item and "id" in item}
    except Exception:
        return {}


def get_or_create_drive_folder(name: str, parent_id: Optional[str] = None) -> str:
    """Finds an existing folder by name or creates it if it doesn't exist."""
    existing = list_drive_folder(parent_id)
    if name in existing:
        return existing[name]

    args = ["mutate", "mkdir", name]
    if parent_id:
        args.extend(["--parent", parent_id])

    rc, out, err = run_gdrive_cmd(args)
    if rc != 0:
        raise RuntimeError(f"Failed to create Google Drive folder '{name}': {err or out}")

    # Expected output: "Created folder: <name> (ID: <id>)"
    if "(ID: " in out:
        fid = out.split("(ID: ")[1].rstrip(")")
        return fid

    # Fallback re-list
    existing = list_drive_folder(parent_id)
    if name in existing:
        return existing[name]

    raise RuntimeError(f"Could not retrieve folder ID for '{name}'. Output: {out}")


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


def generate_manifest(
    release_tag: str = "v0.1.0",
    archive_dir: Optional[Path] = None,
    gdrive_ids: Optional[Dict[str, str]] = None,
    gdrive_meta: Optional[Dict[str, Any]] = None,
) -> Dict[str, Any]:
    """Builds the lightweight corpus_manifest.json that stays in Git."""
    progress_file = CATALOG_DIR / "progress.json"
    if not progress_file.exists():
        raise FileNotFoundError(f"Progress file not found: {progress_file}")

    progress = json.loads(progress_file.read_text(encoding="utf-8"))
    completed = progress.get("completed_courses", {})

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

        if archive_dir:
            afile = archive_dir / f"{cid}.zip"
            if afile.exists():
                c_entry["archive_sha256"] = compute_sha256(afile)
                c_entry["archive_size_mb"] = round(afile.stat().st_size / (1024 * 1024), 2)

        if gdrive_ids and cid in gdrive_ids:
            c_entry["gdrive_file_id"] = gdrive_ids[cid]
            c_entry["gdrive_download_url"] = f"https://drive.google.com/uc?id={gdrive_ids[cid]}&export=download"

        courses_manifest[cid] = c_entry

    manifest_data = {
        "release_tag": release_tag,
        "updated_at": datetime.now(timezone.utc).isoformat(),
        "total_courses": len(courses_manifest),
        "total_duration_hours": round(total_duration / 3600.0, 3),
        "total_words": total_words,
        "total_scenes": total_scenes,
        "courses": courses_manifest,
        "gdrive_store": gdrive_meta or {
            "root_folder_name": "ILLIMMI_CORPUS_STORE",
            "release_path": f"releases/{release_tag}",
            "documentation": "docs/gdrive_corpus_architecture.md",
        },
    }

    with open(MANIFEST_PATH, "w", encoding="utf-8") as f:
        json.dump(manifest_data, f, indent=2, ensure_ascii=False)

    return manifest_data


def package_release(release_tag: str, output_base: Path) -> Path:
    """Packages all certified courses and training data into a structured release directory."""
    release_dir = output_base / release_tag
    courses_archive_dir = release_dir / "courses_archives"
    training_archive_dir = release_dir / "training_data"
    catalog_archive_dir = release_dir / "catalog"

    courses_archive_dir.mkdir(parents=True, exist_ok=True)
    training_archive_dir.mkdir(parents=True, exist_ok=True)
    catalog_archive_dir.mkdir(parents=True, exist_ok=True)

    progress_file = CATALOG_DIR / "progress.json"
    if not progress_file.exists():
        raise FileNotFoundError(f"Missing {progress_file}")

    progress = json.loads(progress_file.read_text(encoding="utf-8"))
    completed_ids = sorted(progress.get("completed_courses", {}).keys())

    print(f"📦 Packaging {len(completed_ids)} certified courses into {release_dir}...")
    for cid in completed_ids:
        res = package_course(cid, courses_archive_dir, archive_format="zip")
        print(f"  -> {cid}: {res['archive_file']} ({res['size_mb']} MB, SHA-256: {res['sha256'][:10]}...)")

    # Copy catalog snapshot
    for cat_f in CATALOG_DIR.glob("*"):
        if cat_f.is_file() and not cat_f.name.startswith("."):
            shutil.copy2(cat_f, catalog_archive_dir / cat_f.name)

    # Copy and archive training data
    if TRAINING_DIR.exists():
        for tf in TRAINING_DIR.glob("*.jsonl"):
            shutil.copy2(tf, training_archive_dir / tf.name)

    # Generate manifest with hashes
    manifest = generate_manifest(release_tag=release_tag, archive_dir=courses_archive_dir)
    shutil.copy2(MANIFEST_PATH, release_dir / "corpus_manifest.json")

    print(f"\n✅ Release package '{release_tag}' created successfully at: {release_dir}")
    print(f"   Total courses: {manifest['total_courses']}")
    print(f"   Total hours: {manifest['total_duration_hours']} h")
    print(f"   Total scenes: {manifest['total_scenes']}")
    return release_dir


def upload_to_drive(gdrive_bin: str, file_path: Path, parent_id: str) -> str:
    """Uploads a file to Google Drive under parent_id and returns file ID."""
    cmd = [gdrive_bin, "mutate", "upload", str(file_path), "--parent", parent_id]
    proc = subprocess.run(cmd, capture_output=True, text=True, check=True)
    out = proc.stdout.strip()
    fid = ""
    if "(ID: " in out:
        fid = out.split("(ID: ")[1].rstrip(")")
    return fid


def auto_sync_to_gdrive(release_tag: Optional[str] = None, push_git: bool = True) -> Dict[str, Any]:
    """
    Main automated entry point called when subagents finish a batch of courses.
    1. Checks certified courses count.
    2. Refreshes training JSONL exports.
    3. Packages archives into corpus_exports/<tag>.
    4. Connects to Google Drive, ensures directory hierarchy exists.
    5. Uploads new course archives and catalog.
    6. Updates and uploads corpus_manifest.json.
    7. Optionally commits and pushes manifest to Git.
    """
    progress_file = CATALOG_DIR / "progress.json"
    if not progress_file.exists():
        raise FileNotFoundError(f"Missing {progress_file}")

    progress = json.loads(progress_file.read_text(encoding="utf-8"))
    completed_ids = sorted(progress.get("completed_courses", {}).keys())
    total_completed = len(completed_ids)

    if not release_tag:
        release_tag = f"v0.{total_completed // 10}.0"
        if total_completed == 0:
            release_tag = "v0.0.1"

    print(f"\n=======================================================")
    print(f"☁️ AUTOMATED GOOGLE DRIVE SYNCHRONIZATION ({release_tag})")
    print(f"=======================================================")
    print(f"Total certified courses: {total_completed}")

    # 1. Refresh training JSONL export
    export_script = PROJECT_ROOT / ".agents" / "skills" / "corpus-illimmi" / "scripts" / "export_certified_jsonl.py"
    if export_script.exists():
        print("🔄 Refreshing Gemma SFT training JSONL exports...")
        subprocess.run([sys.executable, str(export_script)], check=True)

    # 2. Package release locally
    release_dir = package_release(release_tag, DEFAULT_EXPORT_DIR)
    courses_archive_dir = release_dir / "courses_archives"

    # 3. Locate or create folder structure on Google Drive
    gdrive_bin = find_gdrive_bin()
    print("\n🔍 Resolving Google Drive target hierarchy...")
    root_id = get_or_create_drive_folder("ILLIMMI_CORPUS_STORE")
    releases_id = get_or_create_drive_folder("releases", parent_id=root_id)
    current_release_id = get_or_create_drive_folder(release_tag, parent_id=releases_id)

    courses_archives_id = get_or_create_drive_folder("courses_archives", parent_id=current_release_id)
    training_data_id = get_or_create_drive_folder("training_data", parent_id=current_release_id)
    catalog_id = get_or_create_drive_folder("catalog", parent_id=current_release_id)

    # 4. Upload course archives (skipping already uploaded files)
    existing_remote_archives = list_drive_folder(courses_archives_id)
    local_archives = sorted(courses_archive_dir.glob("*.zip"))
    gdrive_file_ids: Dict[str, str] = {}

    print(f"\n☁️ Uploading {len(local_archives)} course archives to Google Drive...")
    for idx, arch in enumerate(local_archives, 1):
        cid = arch.stem
        if arch.name in existing_remote_archives:
            fid = existing_remote_archives[arch.name]
            print(f"  [{idx}/{len(local_archives)}] {arch.name} -> déjà présent (ID: {fid})")
            gdrive_file_ids[cid] = fid
        else:
            print(f"  [{idx}/{len(local_archives)}] Uploading {arch.name} ({round(arch.stat().st_size / (1024*1024), 2)} MB)...")
            fid = upload_to_drive(gdrive_bin, arch, courses_archives_id)
            print(f"    ☁️ OK -> GDrive ID: {fid}")
            gdrive_file_ids[cid] = fid

    # 5. Upload catalog files
    print("\n☁️ Synchronizing catalog snapshot to Google Drive...")
    for cat_f in CATALOG_DIR.glob("*"):
        if cat_f.is_file() and not cat_f.name.startswith("."):
            fid = upload_to_drive(gdrive_bin, cat_f, catalog_id)
            print(f"  Uploaded catalog: {cat_f.name} -> {fid}")

    # 6. Upload training datasets
    if TRAINING_DIR.exists():
        print("\n☁️ Synchronizing training datasets to Google Drive...")
        for tr_f in TRAINING_DIR.glob("*.jsonl"):
            fid = upload_to_drive(gdrive_bin, tr_f, training_data_id)
            print(f"  Uploaded dataset: {tr_f.name} -> {fid}")

    # 7. Update manifest with Drive IDs & URL
    gdrive_meta = {
        "root_folder_name": "ILLIMMI_CORPUS_STORE",
        "root_folder_id": root_id,
        "releases_folder_id": releases_id,
        "current_release_id": current_release_id,
        "release_url": f"https://drive.google.com/drive/folders/{current_release_id}",
        "release_path": f"releases/{release_tag}",
        "documentation": "docs/gdrive_corpus_architecture.md",
    }
    manifest = generate_manifest(
        release_tag=release_tag,
        archive_dir=courses_archive_dir,
        gdrive_ids=gdrive_file_ids,
        gdrive_meta=gdrive_meta,
    )
    shutil.copy2(MANIFEST_PATH, release_dir / "corpus_manifest.json")

    # Upload final manifest to release root on Drive
    upload_to_drive(gdrive_bin, MANIFEST_PATH, current_release_id)

    # 8. Git sync (lightweight manifest commit only)
    if push_git:
        print("\n🔄 Committing and pushing lightweight manifest to Git/GitHub...")
        subprocess.run(f"git add {MANIFEST_PATH}", shell=True, cwd=PROJECT_ROOT, check=True)
        commit_msg = f"chore(corpus): update corpus_manifest.json after auto-sync {release_tag} ({total_completed} courses)"
        subprocess.run(f'git commit -m "{commit_msg}"', shell=True, cwd=PROJECT_ROOT)
        subprocess.run("git push origin dsl_dev", shell=True, cwd=PROJECT_ROOT)

    print(f"\n=======================================================")
    print(f"🎉 GOOGLE DRIVE AUTO-SYNC FINISHED SUCCESSFULLY!")
    print(f"   Release: {release_tag} ({total_completed} courses)")
    print(f"   Drive Folder URL: https://drive.google.com/drive/folders/{current_release_id}")
    print(f"=======================================================\n")
    return manifest


def main():
    parser = argparse.ArgumentParser(description="ILLIMMI Corpus Google Drive Cloud Sync & Versioning")
    subparsers = parser.add_subparsers(dest="action", required=True)

    # auto-sync (Primary orchestrator command)
    p_auto = subparsers.add_parser("auto-sync", help="End-of-batch automated package, upload to Drive, and manifest git push")
    p_auto.add_argument("--tag", default=None, help="Optional release tag (e.g. v0.2.0). Auto-computed if omitted.")
    p_auto.add_argument("--no-git", action="store_true", help="Skip git commit/push")

    # package-course
    p_course = subparsers.add_parser("package-course", help="Package a single course into a zip archive")
    p_course.add_argument("--course-id", required=True, help="Course ID (e.g. MATH_001)")
    p_course.add_argument("--output-dir", default=str(DEFAULT_EXPORT_DIR / "single"), help="Output directory")

    # package-release
    p_rel = subparsers.add_parser("package-release", help="Package all certified courses into a versioned release")
    p_rel.add_argument("--tag", default="v0.1.0", help="Release tag (e.g. v0.1.0)")
    p_rel.add_argument("--output-dir", default=str(DEFAULT_EXPORT_DIR), help="Base output directory")

    # manifest
    p_man = subparsers.add_parser("manifest", help="Generate corpus_manifest.json")
    p_man.add_argument("--tag", default="v0.1.0", help="Release tag")

    args = parser.parse_args()

    if args.action == "auto-sync":
        auto_sync_to_gdrive(release_tag=args.tag, push_git=not args.no_git)
    elif args.action == "package-course":
        res = package_course(args.course_id, Path(args.output_dir))
        print(json.dumps(res, indent=2))
    elif args.action == "package-release":
        package_release(args.tag, Path(args.output_dir))
    elif args.action == "manifest":
        man = generate_manifest(args.tag)
        print(json.dumps(man, indent=2))


if __name__ == "__main__":
    main()
