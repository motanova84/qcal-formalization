#!/usr/bin/env python3
"""Validate QCAL Ω Audit Ledger v1.

The inheritance rule is evaluated on claim-to-claim dependencies.
AXIOM_* identifiers are roots/boundary assumptions and are intentionally
excluded from the evidence lattice; they are never upgraded to PROVEN by CI.
"""
from __future__ import annotations
import argparse, json, sys
from pathlib import Path

ORDER = {"FALSIFIED": 0, "OPEN": 1, "PREDICTED": 2, "VERIFIED": 3, "FORMALIZED": 4, "PROVEN": 5}
REQUIRED = {"id","claim","type","deps","proof","code","dataset","hash","result","status"}


def fail(msg: str) -> None:
    print(f"ERROR: {msg}", file=sys.stderr)
    raise SystemExit(1)


def validate(path: Path) -> dict:
    data = json.loads(path.read_text(encoding="utf-8"))
    if data.get("ledger") != "QCAL Ω Audit Ledger": fail("invalid ledger name")
    if data.get("version") != "1.0.1": fail("expected schema version 1.0.1")
    entries = data.get("entries")
    if not isinstance(entries, list) or not entries: fail("entries must be a non-empty list")

    by_id = {}
    for e in entries:
        missing = REQUIRED - e.keys()
        if missing: fail(f"{e.get('id','<unknown>')}: missing {sorted(missing)}")
        if e["id"] in by_id: fail(f"duplicate id: {e['id']}")
        if e["status"] not in ORDER: fail(f"{e['id']}: invalid status {e['status']}")
        if not isinstance(e["deps"], list): fail(f"{e['id']}: deps must be a list")
        by_id[e["id"]] = e

    for e in entries:
        for dep in e["deps"]:
            if dep.startswith("AXIOM_"):
                continue
            if dep not in by_id: fail(f"{e['id']}: unknown dependency {dep}")
            if ORDER[e["status"]] > ORDER[by_id[dep]["status"]]:
                fail(f"{e['id']}: inheritance violation: {e['status']} > {dep}:{by_id[dep]['status']}")

    # Cycle detection over claim nodes.
    graph = {e["id"]: [d for d in e["deps"] if not d.startswith("AXIOM_")] for e in entries}
    visiting, visited = set(), set()
    def dfs(node: str) -> None:
        if node in visiting: fail(f"dependency cycle detected at {node}")
        if node in visited: return
        visiting.add(node)
        for dep in graph[node]: dfs(dep)
        visiting.remove(node); visited.add(node)
    for node in graph: dfs(node)

    return data


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("ledger", nargs="?", default="ledger/omega.json")
    args = ap.parse_args()
    data = validate(Path(args.ledger))
    counts = {s: 0 for s in ORDER}
    for e in data["entries"]: counts[e["status"]] += 1
    print("QCAL Ω Audit Ledger: PASS")
    print(json.dumps({"version": data["version"], "entries": len(data["entries"]), "counts": counts}, ensure_ascii=False, indent=2))
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
