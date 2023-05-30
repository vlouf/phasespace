"""
Histogram (density, averaging and variance) in a phase-space diagram.

@author: Valentin Louf
@corporation: Monash University and the Australian Bureau of Meteorology
@date: 20/06/2019
@email: <valentin.louf@bom.gov.au>
"""
import numpy as np
from _phasespace import compute_phase_space_avg, compute_phase_space_count


def phasespace(x, y, z=None, *, bins=10, range=None, kind="mean"):
    try:
        len(bins)
        N0 = bins[0]
        N1 = bins[1]
    except TypeError:
        N0 = bins
        N1 = bins

    if z is not None:
        if np.isnan(z).any():
            raise ValueError("z contains NaN values.")

    if x.shape != y.shape:
        raise ValueError("Wrong dimensions.")
        if z is not None and (z.shape != x.shape):
            raise ValueError("z-array doesn't have the same dimensions.")
    if len(x.shape) != 1:
        raise ValueError(f"Not a 1D array, x.shape = {x.shape}")

    if range is None:
        if np.isnan(x).any() or np.isnan(y).any():
            raise ValueError("autodetected range of [nan, nan] is not finite")
        xout = np.linspace(x.min(), x.max(), N0)
        yout = np.linspace(y.min(), y.max(), N1)
    else:
        xout = np.linspace(range[0][0], range[0][1], N0)
        yout = np.linspace(range[1][0], range[1][1], N1)

    if z is None:
        phase = compute_phase_space_count(x, y, xout, yout)
    else:
        if kind == "mean":
            phase = compute_phase_space_avg(x, y, z, xout, yout)
        # elif kind == "var":
        #     phase = np.ma.masked_equal(phase_space_var(x, y, z, xout, yout), -9999)
    return phase
