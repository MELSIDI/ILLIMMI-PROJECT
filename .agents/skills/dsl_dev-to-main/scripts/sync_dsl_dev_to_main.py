#!/usr/bin/env python3
"""
sync_dsl_dev_to_main.py - Autonomous Git Synchronization from dsl_dev to main.

Workflow:
1. Verifies/commits pending changes on dsl_dev and pushes to origin/dsl_dev.
2. Checks out main (no remote pull, uses local main directly).
3. Merges local dsl_dev changes into main.
4. Pushes main to origin/main.
5. Switches back to dsl_dev (active feature development branch).
6. Outputs full status conforming to ILLIMMI Git notification directives.
"""

import argparse
import io
import subprocess
import sys
from pathlib import Path

if sys.platform == "win32":
    if isinstance(sys.stdout, io.TextIOWrapper):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    if isinstance(sys.stderr, io.TextIOWrapper):
        sys.stderr.reconfigure(encoding="utf-8", errors="replace")

PROJECT_ROOT = Path(__file__).resolve().parents[4]


def run_cmd(cmd: str, check: bool = True, cwd: Path = PROJECT_ROOT) -> subprocess.CompletedProcess:
    """Executes a git shell command and prints clean debug info."""
    print(f"🔧 $ {cmd}")
    proc = subprocess.run(
        cmd,
        shell=True,
        cwd=cwd,
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace"
    )
    if proc.stdout.strip():
        print(proc.stdout.strip())
    if proc.stderr.strip() and proc.returncode != 0:
        print(f"⚠️ stderr: {proc.stderr.strip()}", file=sys.stderr)
    if check and proc.returncode != 0:
        raise RuntimeError(f"Command failed (code {proc.returncode}): {cmd}\n{proc.stderr}")
    return proc


def get_current_branch() -> str:
    res = run_cmd("git rev-parse --abbrev-ref HEAD")
    return res.stdout.strip()


def get_head_commit(branch: str = "HEAD") -> str:
    res = run_cmd(f"git rev-parse --short {branch}")
    return res.stdout.strip()


def sync(commit_msg: str = "chore(dsl_dev): commit pending changes before sync to main") -> dict:
    original_branch = get_current_branch()
    print(f"🚀 Starting dsl_dev -> main sync (Current branch: {original_branch})")

    try:
        # Step 1: Ensure we are on dsl_dev
        if original_branch != "dsl_dev":
            print("Switching to dsl_dev...")
            run_cmd("git checkout dsl_dev")

        # Step 2: Check for uncommitted changes on dsl_dev
        run_cmd("git add -A")
        diff_cached = run_cmd("git diff --cached --quiet", check=False)
        has_staged = (diff_cached.returncode != 0)

        if has_staged:
            print(f"📝 Staged changes detected on dsl_dev. Committing...")
            run_cmd(f'git commit -m "{commit_msg}"')
            dsl_dev_commit = get_head_commit()
            print(f"✅ Committed on dsl_dev: {dsl_dev_commit}")
        else:
            dsl_dev_commit = get_head_commit()
            print(f"ℹ️ dsl_dev working tree clean at commit: {dsl_dev_commit}")

        # Step 3: Push dsl_dev to origin/dsl_dev
        print("☁️ Pushing dsl_dev to origin/dsl_dev...")
        run_cmd("git push origin dsl_dev")

        # Step 4: Checkout main directly (no git pull origin main)
        print("🔀 Switching directly to main...")
        run_cmd("git checkout main")

        # Step 5: Merge local dsl_dev into main
        print("⚡ Merging local dsl_dev into main...")
        merge_msg = f"merge: sync dsl_dev into main ({dsl_dev_commit})"
        merge_res = run_cmd(f'git merge dsl_dev -m "{merge_msg}"', check=False)

        if merge_res.returncode != 0:
            print("❌ Merge conflict or error encountered! Aborting merge to protect main...")
            run_cmd("git merge --abort", check=False)
            raise RuntimeError(f"Git merge dsl_dev into main failed: {merge_res.stderr}")

        main_commit = get_head_commit("main")
        print(f"✅ Merged successfully into main: {main_commit}")

        # Step 6: Push main to origin/main
        print("☁️ Pushing main to origin/main...")
        run_cmd("git push origin main")

        return {
            "status": "success",
            "dsl_dev_commit": dsl_dev_commit,
            "main_commit": main_commit,
            "pushed_dsl_dev": True,
            "pushed_main": True,
        }

    finally:
        # Step 7: ALWAYS return to dsl_dev (the active development branch)
        print("🔁 Returning to dsl_dev (active feature development branch)...")
        run_cmd("git checkout dsl_dev", check=False)
        current = get_current_branch()
        print(f"🎯 Currently on branch: {current}")


def main():
    parser = argparse.ArgumentParser(description="Synchronize dsl_dev into main and push both to GitHub without pulling main")
    parser.add_argument("--message", "-m", default="chore(dsl_dev): commit pending changes before sync to main",
                        help="Commit message for uncommitted changes on dsl_dev")
    args = parser.parse_args()

    try:
        res = sync(commit_msg=args.message)
        print("\n=======================================================")
        print("🎉 SYNC DSL_DEV -> MAIN COMPLETED SUCCESSFULLY!")
        print(f"   dsl_dev commit : {res['dsl_dev_commit']} (Pushed to origin/dsl_dev)")
        print(f"   main commit    : {res['main_commit']} (Pushed to origin/main)")
        print("   Active branch  : dsl_dev (ready for new feature development)")
        print("=======================================================\n")
    except Exception as e:
        print(f"\n❌ ERROR during synchronization: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
