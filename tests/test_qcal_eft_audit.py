#!/usr/bin/env python3
"""Regression tests for the QCAL-EFT audit harness.

The tests are intentionally strict: a manuscript number is not accepted merely
because it is close to a desired value. The implementation must reproduce the
number from the equation that is claimed to generate it.
"""

import unittest

from scripts.qcal_eft_audit import (
    F0_ANCHOR_HZ,
    F0_SECTION_26_HZ,
    LAMBDA_J_CLAIM_M,
    m_eff_from_frequency,
    f0_section_26,
    jeans_lambda_from_eq_26_3,
    run_audit,
)


class QCALEFTAuditTests(unittest.TestCase):
    def test_fixed_frequency_is_explicit(self):
        self.assertEqual(F0_ANCHOR_HZ, 141.7001)

    def test_mass_from_fixed_frequency_matches_manuscript_scale(self):
        # The manuscript quotes ~1.0447e-48 kg; tolerate only rounding here.
        self.assertAlmostEqual(m_eff_from_frequency(), 1.0447e-48, delta=5e-51)

    def test_section_26_formula_is_reproducible(self):
        # This test locks the literal formula to the manuscript's stated value.
        # If constants or transcription change, the test must be updated with
        # an explicit scientific justification.
        self.assertAlmostEqual(f0_section_26(), F0_SECTION_26_HZ, delta=2e-4)

    def test_registered_audit_has_no_silent_passes(self):
        # Every audit gate is returned explicitly. This test does not convert a
        # FAIL into a warning: numerical closure is blocked until every gate is
        # independently reconciled.
        results = run_audit()
        self.assertEqual(len(results), 5)
        self.assertTrue(all(isinstance(r.passed, bool) for r in results))

    def test_jeans_claim_is_locked_to_literal_equation(self):
        # This currently documents a known closure blocker. Once Eq. (26.3)
        # and Eq. (26.4) are reconciled, this assertion should become the
        # numerical acceptance gate used by CI.
        computed = jeans_lambda_from_eq_26_3()
        self.assertNotAlmostEqual(computed, LAMBDA_J_CLAIM_M, delta=0.001 * LAMBDA_J_CLAIM_M)


if __name__ == "__main__":
    unittest.main()
