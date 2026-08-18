#!/usr/bin/env python3
import json, sys
from pathlib import Path

ORDER = {"FALSIFIED": 0, "OPEN": 1, "PREDICTED": 2, "VERIFIED": 3, "FORMALIZED": 4, "PROVEN": 5}
ALLOWED = set(ORDER)


def main(path: str) -> int:
    data = json.loads(Path(path).read_text(encoding="utf-8"))
    entries = {e["id"]: e for e in data["entries"]}
    errors = []
    for e in data["entries"]:
        status = e["status"]
        if status not in ALLOWED:
            errors.append(f"{e['id']}: invalid status {status}")
        for dep in e.get("deps", []):
            if dep not in entries:
                errors.append(f"{e['id']}: missing dependency {dep}")
                continue
            if ORDER[status] > ORDER[entries[dep]["status"]]:
                errors.append(
                    f"{e['id']}: {status} exceeds dependency {dep}={entries[dep]['status']}"
                )
    # A mathematical/empirical claim may not be called PROVEN merely because
    # a prose note says so; the ledger itself must remain dependency-consistent.
    if errors:
        print("QCAL Ω AUDIT: FAIL")
        print("\n".join(f"- {x}" for x in errors))
        return 1
    counts = {s: 0 for s in ORDER}
    for e in data["entries"]:
        counts[e["status"]] += 1
    print("QCAL Ω AUDIT: PASS")
    print(json.dumps(counts, ensure_ascii=False, sort_keys=True))
    return 0

if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1] if len(sys.argv) > 1 else "ledger/omega.json"))
