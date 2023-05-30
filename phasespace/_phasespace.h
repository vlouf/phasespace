#ifndef PHASE_SPACE_AVG_H
#define PHASE_SPACE_AVG_H

void phase_space_avg(double* xin, double* yin, double* arr, double* xout, double* yout, int ndim0, int nx, int ny, double* phase);
void phase_space_count(double* xin, double* yin, double* xout, double* yout, int ndim0, int nx, int ny, double* phase);

#endif  // PHASE_SPACE_AVG_H
