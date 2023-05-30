import numpy as np
from phasespace import phasespace


def test_phasespace():
    # Test case 1: Test with simple input arrays
    x = np.array([1, 2, 3], dtype=np.float64)
    y = np.array([1, 2, 3], dtype=np.float64)

    result = phasespace(x, y, bins=3)
    expected = np.array([[1, 0, 0], [0, 1, 0], [0, 0, 1]], dtype=np.float64)
    assert np.array_equal(result, expected)