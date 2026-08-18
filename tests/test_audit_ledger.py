import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LEDGER = ROOT / "AUDIT" / "qcal_omega_audit_ledger_v1.1.json"


def load():
    return json.loads(LEDGER.read_text(encoding="utf-8"))


def test_counts_and_layers():
    d = load()
    e = d["entries"]
    assert len(e) == 22
    assert sum(x["layer"] == "M" for x in e) == 12
    assert sum(x["layer"] == "C" for x in e) == 3
    assert sum(x["layer"] == "E" for x in e) == 7
    assert sum(x["status"] == "PROVEN" for x in e) == 13
    assert sum(x["status"] == "VERIFIED" for x in e) == 9
    assert d["counts"] == {"total": 22, "PROVEN": 13, "VERIFIED": 9,
                             "FORMALIZED": 0, "PREDICTED": 0, "OPEN": 0,
                             "FALSIFIED": 0}


def test_reference_constants():
    d = load()
    assert d["f0_hz"] == 141.7001
    assert d["psi"] == 0.999999


def test_dependencies_exist_or_are_constitutional_axioms():
    d = load()
    ids = {x["id"] for x in d["entries"]}
    for x in d["entries"]:
        for dep in x["deps"]:
            assert dep in ids or dep.startswith("AXIOM_")


def test_graph_is_acyclic():
    d = load()
    graph = {x["id"]: [y for y in x["deps"] if y in {z["id"] for z in d["entries"]}]
             for x in d["entries"]}
    visiting, visited = set(), set()

    def visit(node):
        if node in visiting:
            raise AssertionError(f"cycle detected at {node}")
        if node in visited:
            return
        visiting.add(node)
        for dep in graph[node]:
            visit(dep)
        visiting.remove(node)
        visited.add(node)

    for node in graph:
        visit(node)


def test_inheritance_rule():
    d = load()
    rank = d["status_order"]
    by_id = {x["id"]: x for x in d["entries"]}
    for x in d["entries"]:
        ranks = [rank[by_id[dep]["status"]] for dep in x["deps"] if dep in by_id]
        if ranks:
            assert rank[x["status"]] <= min(ranks), x["id"]


def test_no_open_or_falsified_nodes():
    d = load()
    forbidden = {"OPEN", "CONDITIONAL", "FALSIFIED"}
    assert not [x["id"] for x in d["entries"] if x["status"] in forbidden]
