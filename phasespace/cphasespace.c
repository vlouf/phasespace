#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>


void phase_space_avg(
    double* xin, double* yin, double* arr, double* xout, double* yout, int ndim0, int nx, int ny, double* phase
) {
    // Pre-compute constants
    const double dx = fabs(xout[1] - xout[0]) * 0.5;
    const double dy = fabs(yout[1] - yout[0]) * 0.5;

    // Initialize output array to zero
    memset(phase, 0, nx * ny * sizeof(double));

    // Create temporary arrays for counts
    int* counts = calloc(nx * ny, sizeof(int));
    if (!counts) return;

    // Single pass through input data (data-oriented approach)
    for (int k = 0; k < ndim0; k++) {
        const double x = xin[k];
        const double y = yin[k];
        const double val = arr[k];

        // Find x bin range using binary search approach
        int i_start = 0, i_end = nx;
        for (int i = 0; i < nx; i++) {
            const double x_center = xout[i];
            if (x >= x_center - dx && x < x_center + dx) {
                // Find y bin range
                for (int j = 0; j < ny; j++) {
                    const double y_center = yout[j];
                    if (y >= y_center - dy && y < y_center + dy) {
                        const int idx = j * nx + i;
                        phase[idx] += val;
                        counts[idx]++;
                    }
                }
            }
        }
    }

    // Compute averages
    for (int idx = 0; idx < nx * ny; idx++) {
        if (counts[idx] > 0) {
            phase[idx] /= counts[idx];
        }
    }

    free(counts);
}


void phase_space_count(double* xin, double* yin, double* xout, double* yout, int ndim0, int nx, int ny, double* phase) {
    // Count the number of elements in the phase-space
    int i, j, cnt;
    double dx, dy, total;

    dx = fabs(xout[1] - xout[0]) / 2.0;
    dy = fabs(yout[1] - yout[0]) / 2.0;

    for (j = 0; j < ny; j++) {
        for (i = 0; i < nx; i++) {
            cnt = 0;
            total = 0.0;

            for (int k = 0; k < ndim0; k++) {
                if (xin[k] >= xout[i] - dx && xin[k] < xout[i] + dx && yin[k] >= yout[j] - dy && yin[k] < yout[j] + dy) {
                    cnt++;
                }
            }

            if (cnt == 0) {
                continue;
            }

            phase[j * nx + i] = cnt;
        }
    }
}