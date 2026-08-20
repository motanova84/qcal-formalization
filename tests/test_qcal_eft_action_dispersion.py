import unittest

from scripts.qcal_eft_action_dispersion_audit import (
    audit_frequency_definition,
    audit_mass_definition,
    audit_quantum_pressure,
)


class QCALEFTActionDispersionTests(unittest.TestCase):
    def test_frequency_definition(self):
        self.assertTrue(audit_frequency_definition().passed)

    def test_effective_mass_definition(self):
        self.assertTrue(audit_mass_definition().passed)

    def test_quantum_pressure_reduction(self):
        self.assertTrue(audit_quantum_pressure().passed)


if __name__ == "__main__":
    unittest.main()
