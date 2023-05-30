#include <stdio.h>
#include <math.h>

void phase_space_avg(double* xin, double* yin, double* arr, double* xout, double* yout, int ndim0, int nx, int ny, double* phase) {
    // Compute the mean of the phase-space
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
                    total += arr[k];
                }
            }

            if (cnt == 0) {
                continue;
            }

            phase[j * nx + i] = total / cnt;
        }
    }
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