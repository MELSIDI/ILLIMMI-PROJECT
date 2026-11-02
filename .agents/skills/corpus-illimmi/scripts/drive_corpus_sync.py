#!/usr/bin/env python3
"""
drive_corpus_sync.py - ILLIMMI Corpus Cloud Storage & Semantic Versioning Tool.

Manages packaging, hashing (SHA-256), and synchronization of large corpus assets
(PNG renders, audio WAV, SFT training datasets) between local disk and Google Drive,
keeping the Git repository lightweight (<30MB) and tracking data via corpus_manifest.json.
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
from typing import Any, Dict, List, Optional

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
    # Check Antigravity plugin data directory first
    home = Path(os.environ.get("USERPROFILE") or os.environ.get("HOME") or "")
    plugin_bin_dir = home / ".gemini" / "antigravity" / "plugin_data" / "gdrive" / "bin"
    if plugin_bin_dir.exists():
        for exe in plugin_bin_dir.glob("gdrive*.exe"):
            return str(exe)

    # Check PATH
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

    files_to_pack = []
    for item in cdir.rglob("*"):
        if item.is_file():
            files_to_pack.append(item)

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


def generate_manifest(release_tag: str = "v0.1.0", archive_dir: Optional[Path] = None, gdrive_ids: Optional[Dict[str, str]] = None) -> Dict[str, Any]:
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

        courses_manifest[cid] = c_entry

    manifest_data = {
        "release_tag": release_tag,
        "updated_at": datetime.now(timezone.utc).isoformat(),
        "total_courses": len(courses_manifest),
        "total_duration_hours": round(total_duration / 3600.0, 3),
        "total_words": total_words,
        "total_scenes": total_scenes,
        "courses": courses_manifest,
        "gdrive_store": {
            "root_folder_name": "ILLIMMI_CORPUS_STORE",
            "root_folder_id": "1z8MJTy-UnKKs_t24xnqiGNEEMnM06tTM",
            "releases_folder_id": "1g7HxYXpt0oY6jr6Lq1G0exKT3a5N57KD",
            "current_release_id": "13_O04HKBPWCW7C9B8PgXp2mP2BpxgM2b",
            "release_url": "https://drive.google.com/drive/folders/13_O04HKBPWCW7C9B8PgXp2mP2BpxgM2b",
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


def upload_course_archive(gdrive_bin: str, archive_path: Path, parent_id: str) -> str:
    """Uploads a single archive to Google Drive using gdrive CLI and returns file ID."""
    cmd = [gdrive_bin, "mutate", "upload", str(archive_path), "--parent", parent_id]
    res = subprocess.run(cmd, capture_output=True, text=True, check=True)
    out = res.stdout.strip()
    # Expected: "Uploaded: MATH_001.zip (ID: 1abc...)"
    fid = ""
    if "(ID: " in out:
        fid = out.split("(ID: ")[1].rstrip(")")
    print(f"  ☁️ {archive_path.name} -> GDrive ID: {fid}")
    return fid


def sync_cloud(release_tag: str, release_base: Path):
    """Synchronizes packaged release files to Google Drive using the authenticated CLI."""
    gdrive_bin = find_gdrive_bin()
    release_dir = release_base / release_tag
    if not release_dir.exists():
        raise FileNotFoundError(f"Release dir does not exist: {release_dir}. Run package-release first.")

    courses_archive_dir = release_dir / "courses_archives"
    # Pre-created target folder IDs on Google Drive:
    courses_archives_parent_id = "1C39f9_4YN0HqTviNQ67vC38NaI63Xowa"
    release_folder_id = "13_O04HKBPWCW7C9B8PgXp2mP2BpxgM2b"

    print(f"🚀 Starting cloud synchronization for {release_tag} to Google Drive...")
    gdrive_file_ids: Dict[str, str] = {}

    archives = sorted(courses_archive_dir.glob("*.zip"))
    total = len(archives)
    for idx, arch in enumerate(archives, 1):
        cid = arch.stem
        print(f"[{idx}/{total}] Uploading {arch.name} ({round(arch.stat().st_size / (1024*1024), 2)} MB)...")
        fid = upload_course_archive(gdrive_bin, arch, courses_archives_parent_id)
        if fid:
            gdrive_file_ids[cid] = fid

    # Re-generate local manifest with the Google Drive File IDs
    manifest = generate_manifest(release_tag=release_tag, archive_dir=courses_archive_dir, gdrive_ids=gdrive_file_ids)
    shutil.copy2(MANIFEST_PATH, release_dir / "corpus_manifest.json")

    # Upload updated manifest to release root on Drive
    print("☁️ Uploading final corpus_manifest.json to Google Drive...")
    upload_course_archive(gdrive_bin, MANIFEST_PATH, release_folder_id)

    print(f"\n🎉 Cloud synchronization of {release_tag} successfully completed!")
    print(f"   Drive URL: https://drive.google.com/drive/folders/{release_folder_id}")


def sync_to_gdrive_desktop(source_release_dir: Path, drive_path: Path):
    """Copies the release package to Google Drive Desktop mounted folder."""
    if not drive_path.exists():
        raise FileNotFoundError(f"Google Drive path does not exist: {drive_path}")

    target_dir = drive_path / "ILLIMMI_CORPUS_STORE" / "releases" / source_release_dir.name
    target_dir.mkdir(parents=True, exist_ok=True)

    print(f"☁️ Synchronizing {source_release_dir} -> {target_dir}...")
    for item in source_release_dir.rglob("*"):
        if item.is_file():
            rel = item.relative_to(source_release_dir)
            dest = target_dir / rel
            dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(item, dest)
            print(f"  Uploaded: {rel}")
    print("✅ Google Drive Desktop synchronization complete.")


def clean_git_cache():
    """Removes heavy PNG renders and training data from Git tracking while preserving local disk files."""
    patterns = [
        "corpus_illimmi_1000/courses/*/renders/*.png",
        "corpus_illimmi_1000/training_data/*.jsonl",
        "corpus_illimmi_1000/transcripts/raw/*.txt",
        "corpus_illimmi_1000/transcripts/processed/*.txt",
    ]
    print("🧹 Removing heavy binary assets from Git tracking (keeping local disk files)...")
    for pat in patterns:
        subprocess.run(f"git rm --cached -r {pat}", shell=True, cwd=PROJECT_ROOT, capture_output=True)
    print("✅ Git cache cleaned.")


def main():
    parser = argparse.ArgumentParser(description="ILLIMMI Corpus Google Drive Cloud Sync & Versioning")
    subparsers = parser.add_subparsers(dest="action", required=True)

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

    # sync-cloud
    p_cloud = subparsers.add_parser("sync-cloud", help="Upload packaged release to Google Drive via CLI")
    p_cloud.add_argument("--tag", default="v0.1.0", help="Release tag (e.g. v0.1.0)")
    p_cloud.add_argument("--output-dir", default=str(DEFAULT_EXPORT_DIR), help="Base output directory")

    # sync-desktop
    p_sync = subparsers.add_parser("sync-desktop", help="Sync release to Google Drive Desktop folder")
    p_sync.add_argument("--release-dir", required=True, help="Path to packaged release dir")
    p_sync.add_argument("--drive-path", required=True, help="Path to Google Drive root or target folder")

    # clean-git
    subparsers.add_parser("clean-git", help="Un-track heavy PNG renders and training data from Git")

    args = parser.parse_args()

    if args.action == "package-course":
        res = package_course(args.course_id, Path(args.output_dir))
        print(json.dumps(res, indent=2))
    elif args.action == "package-release":
        package_release(args.tag, Path(args.output_dir))
    elif args.action == "manifest":
        man = generate_manifest(args.tag)
        print(json.dumps(man, indent=2))
    elif args.action == "sync-cloud":
        sync_cloud(args.tag, Path(args.output_dir))
    elif args.action == "sync-desktop":
        sync_to_gdrive_desktop(Path(args.release_dir), Path(args.drive_path))
    elif args.action == "clean-git":
        clean_git_cache()


if __name__ == "__main__":
    main()
