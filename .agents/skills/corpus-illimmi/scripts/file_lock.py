"""
Cross-platform inter-process file lock and atomic writing for ILLIMMI multi-subagent concurrency.
Supports Windows (msvcrt) and Unix (fcntl) with automatic retry and unique temporary filenames.
"""

import json
import os
import random
import sys
import time
from pathlib import Path

if sys.platform == "win32":
    import msvcrt
else:
    import fcntl


class InterprocessLock:
    """Exclusive inter-process lock ensuring atomic read-modify-write across parallel subagents."""

    def __init__(self, lock_path: Path, timeout_sec: float = 120.0):
        self.lock_path = Path(lock_path)
        self.timeout_sec = timeout_sec
        self.fd = None

    def __enter__(self):
        self.lock_path.parent.mkdir(parents=True, exist_ok=True)
        start_time = time.time()
        while True:
            try:
                self.fd = os.open(str(self.lock_path), os.O_CREAT | os.O_RDWR)
                if sys.platform == "win32":
                    msvcrt.locking(self.fd, msvcrt.LK_NBLCK, 1)
                else:
                    fcntl.flock(self.fd, fcntl.LOCK_EX | fcntl.LOCK_NB)
                return self
            except (OSError, IOError, BlockingIOError):
                if self.fd is not None:
                    try:
                        os.close(self.fd)
                    except Exception:
                        pass
                    self.fd = None
                if time.time() - start_time > self.timeout_sec:
                    raise TimeoutError(f"Could not acquire lock on {self.lock_path} after {self.timeout_sec}s")
                time.sleep(0.08 + random.uniform(0.04, 0.16))

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.fd is not None:
            try:
                if sys.platform == "win32":
                    os.lseek(self.fd, 0, os.SEEK_SET)
                    msvcrt.locking(self.fd, msvcrt.LK_UNLCK, 1)
                else:
                    fcntl.flock(self.fd, fcntl.LOCK_UN)
            except Exception:
                pass
            try:
                os.close(self.fd)
            except Exception:
                pass
            self.fd = None


def atomic_write_json(path: Path, data: object):
    """Safely and atomically write a JSON file using a unique temp file with Windows retry loop."""
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp_path = path.with_name(f"{path.stem}_{os.getpid()}_{time.time_ns()}.tmp")
    with open(tmp_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

    for attempt in range(12):
        try:
            os.replace(tmp_path, path)
            return
        except OSError:
            if attempt == 11:
                try:
                    if path.exists():
                        path.unlink()
                    os.replace(tmp_path, path)
                    return
                except Exception:
                    raise
            time.sleep(0.05 * (attempt + 1) + random.uniform(0.02, 0.05))


def atomic_write_text(path: Path, text: str):
    """Safely and atomically write a text file using a unique temp file with Windows retry loop."""
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp_path = path.with_name(f"{path.stem}_{os.getpid()}_{time.time_ns()}.tmp")
    with open(tmp_path, "w", encoding="utf-8") as f:
        f.write(text)

    for attempt in range(12):
        try:
            os.replace(tmp_path, path)
            return
        except OSError:
            if attempt == 11:
                try:
                    if path.exists():
                        path.unlink()
                    os.replace(tmp_path, path)
                    return
                except Exception:
                    raise
            time.sleep(0.05 * (attempt + 1) + random.uniform(0.02, 0.05))
