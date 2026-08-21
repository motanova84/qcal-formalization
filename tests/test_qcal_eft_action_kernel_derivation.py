import subprocess
import sys
from pathlib import Path


def test_action_kernel_script_runs():
    script = Path(__file__).parents[1] / 'scripts' / 'qcal_eft_action_kernel_derivation.py'
    result = subprocess.run([sys.executable, str(script)], capture_output=True, text=True)
    assert result.returncode == 0, result.stderr
    assert 'QCAL-EFT ACTION -> QUADRATIC KERNEL' in result.stdout
    assert 'Eq. 8.4 relation' in result.stdout
    assert 'Quantum-pressure coefficient' in result.stdout
