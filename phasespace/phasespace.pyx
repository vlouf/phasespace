import numpy as np
cimport numpy as np
cimport cython

cdef extern from "phasespace.h":
    void phase_space_avg(double* xin, double* yin, double* arr, double* xout, double* yout, int ndim0, int nx, int ny, double* phase)

@cython.boundscheck(False)
def compute_phase_space_avg(np.ndarray[np.double_t, ndim=1] xin,
                            np.ndarray[np.double_t, ndim=1] yin,
                            np.ndarray[np.double_t, ndim=1] arr,
                            np.ndarray[np.double_t, ndim=1] xout,
                            np.ndarray[np.double_t, ndim=1] yout):
    cdef int ndim0 = xin.shape[0]
    cdef int nx = xout.shape[0]
    cdef int ny = yout.shape[0]
    cdef np.ndarray[np.double_t, ndim=2] phase = np.zeros((ny, nx), dtype=np.double)

    phase_space_avg(&xin[0], &yin[0], &arr[0], &xout[0], &yout[0], ndim0, nx, ny, &phase[0, 0])

    return phase
