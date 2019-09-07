"""
Histogram (density, averaging and variance) in a phase-space diagram.

@author: Valentin Louf
@corporation: Monash University
@date: 07/09/2019
@email: <valentin.louf@monash.edu>
"""
import numpy as np
import phasespace


def phasespace(x, y, z=None, *, bins=10, range=None, kind='mean'):
    """
    Compute a phase-space diagram. In the case where NaN values are present in
    the (x, y) arrays, then the range must be provided; otherwise the range
    is automatically computed as being the min/max of (x, y).

    Parameters:
    ===========
    x: array <N>
        x-axis variable
    y: array <N>
        y-axis variable
    z: optionnal array <N>
        Third value. In the case z is NOT provided then the function return a
        density (count) plot of (x, y)
    bins: int
        Number of bins.
    range: List[[xmin, xmax], [ymin, ymax]]
        Range for which the diagram is computed.
    kind: str ('mean', 'var')
        To return the average or variance of 'z' in the (x, y) phasespace.

    Returns:
    ========
    phase: array <bins, bins>
        Phase-space diagram.
    """
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
        phase = phasespace.phase_space_count(x, y, xout, yout)
    else:
        if kind == 'mean':
            phase = phasespace.phase_space_avg(x, y, z, xout, yout)
        elif kind == 'var':
            phase = np.ma.masked_equal(phasespace.phase_space_var(x, y, z, xout, yout), -9999)
    return  phase
