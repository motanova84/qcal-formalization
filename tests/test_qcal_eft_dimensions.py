import unittest

from scripts.qcal_eft_dimensional_audit import (
    C,
    G,
    HBAR,
    K,
    M_EFF,
    OMEGA,
    RHO_MASS,
    CS2,
    audit,
)


class QCALEFTDimensionTests(unittest.TestCase):
    def test_mass_definition_is_dimensionally_valid(self):
        self.assertEqual(HBAR * OMEGA / (C**2), M_EFF)

    def test_sound_term_is_frequency_squared(self):
        self.assertEqual(CS2 * K**2, OMEGA**2)

    def test_gravity_term_is_frequency_squared(self):
        self.assertEqual(G * RHO_MASS, OMEGA**2)

    def test_literal_quantum_term_is_detected_as_incomplete(self):
        values = audit()
        self.assertNotEqual(values["quantum_term_literal"], OMEGA**2)


if __name__ == "__main__":
    unittest.main()
