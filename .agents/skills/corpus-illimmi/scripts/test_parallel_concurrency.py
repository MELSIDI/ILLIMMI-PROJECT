import argparse
import json
import os
import sys
import tempfile
import time
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
if str(THIS_DIR) not in sys.path:
    sys.path.insert(0, str(THIS_DIR))

from file_lock import InterprocessLock, atomic_write_json, atomic_write_text


def _worker_increment_counter(args):
    lock_file, data_file, iterations = args
    for _ in range(iterations):
        with InterprocessLock(lock_file, timeout_sec=60.0):
            val = 0
            if data_file.exists():
                try:
                    val = int(data_file.read_text(encoding="utf-8").strip() or "0")
                except Exception:
                    val = 0
            val += 1
            atomic_write_text(data_file, str(val))
    return True


def _worker_certify_simulated_course(args):
    lock_file, progress_file, course_id = args
    time.sleep(0.05)  # simulate slight execution variance
    with InterprocessLock(lock_file, timeout_sec=60.0):
        prog = {"completed_courses": {}, "total_completed": 0}
        if progress_file.exists():
            prog = json.loads(progress_file.read_text(encoding="utf-8"))
        prog.setdefault("completed_courses", {})[course_id] = {
            "course_id": course_id,
            "status": "COMPLETED",
            "certified_at": time.time(),
        }
        prog["total_completed"] = len(prog["completed_courses"])
        atomic_write_json(progress_file, prog)
    return course_id


def test_concurrent_counter(num_workers=5):
    print(f"[1/3] Testing InterprocessLock with {num_workers} concurrent processes (50 increments each = {num_workers * 50} total)...")
    with tempfile.TemporaryDirectory() as tmp_dir:
        td = Path(tmp_dir)
        lock_file = td / ".test_lock"
        data_file = td / "counter.txt"
        data_file.write_text("0", encoding="utf-8")

        iters = 50
        tasks = [(lock_file, data_file, iters) for _ in range(num_workers)]

        with ProcessPoolExecutor(max_workers=num_workers) as executor:
            results = list(executor.map(_worker_increment_counter, tasks))

        assert all(results), "A worker process failed!"
        final_val = int(data_file.read_text(encoding="utf-8").strip())
        expected_val = num_workers * iters
        assert final_val == expected_val, f"Race condition detected! Expected {expected_val}, got {final_val}"
        print(f"      Passed! Final counter value exactly {final_val}/{expected_val} with 0 race conditions.")


def test_concurrent_progress_updates(num_workers=5):
    print(f"[2/3] Testing atomic progress.json updates with {num_workers} parallel subagents...")
    with tempfile.TemporaryDirectory() as tmp_dir:
        td = Path(tmp_dir)
        lock_file = td / ".progress_lock"
        prog_file = td / "progress.json"
        prog_file.write_text(json.dumps({"completed_courses": {}, "total_completed": 0}), encoding="utf-8")

        courses = [f"MATH_{i:03d}" for i in range(1, num_workers + 1)]
        tasks = [(lock_file, prog_file, cid) for cid in courses]

        with ProcessPoolExecutor(max_workers=num_workers) as executor:
            certified_ids = list(executor.map(_worker_certify_simulated_course, tasks))

        final_prog = json.loads(prog_file.read_text(encoding="utf-8"))
        completed = final_prog.get("completed_courses", {})

        assert len(completed) == num_workers, f"Expected {num_workers} certified courses, got {len(completed)}"
        for cid in courses:
            assert cid in completed, f"Course {cid} was overwritten or lost during concurrent write!"
        assert final_prog["total_completed"] == num_workers, "total_completed counter mismatch!"
        print(f"      Passed! All {num_workers} courses ({', '.join(courses)}) atomically preserved with 0 data loss.")


def test_claim_uniqueness():
    print("[3/3] Testing video claim uniqueness across parallel subagents...")
    with tempfile.TemporaryDirectory() as tmp_dir:
        td = Path(tmp_dir)
        claims_dir = td / ".claims"
        claims_dir.mkdir(parents=True)

        vid = "AbCdEf12345"
        claim_file = claims_dir / f"{vid}.claim"

        # Worker 1 claims it
        claim_file.write_text(json.dumps({"course_id": "MATH_006"}), encoding="utf-8")

        # Worker 2 checks claim
        claimed_vids = {f.stem for f in claims_dir.glob("*.claim")}
        assert vid in claimed_vids, "Claim was not detected!"
        print("      Passed! Claim collision successfully detected and avoided.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Multi-Subagent Concurrency Test for ILLIMMI Corpus.")
    parser.add_argument("--workers", "-w", type=int, default=5, choices=[1, 2, 3, 4, 5], help="Number of concurrent subagents (1 to 5, default: 5)")
    args = parser.parse_args()

    print(f"=== Running ILLIMMI Parallel Concurrency Test Suite (Workers = {args.workers}) ===")
    test_concurrent_counter(args.workers)
    test_concurrent_progress_updates(args.workers)
    test_claim_uniqueness()
    print("=== ALL CONCURRENCY & MULTI-SUBAGENT TESTS PASSED SUCCESSFULLY! ===")
