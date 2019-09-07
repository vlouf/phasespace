subroutine phase_space_avg(xin, yin, arr, xout, yout, ndim0, nx, ny, phase)
    ! Compute the mean of the phase-space
    implicit none
    ! Input vars
    integer(kind=4), intent(in) :: ndim0, nx, ny  ! Arrays dimension
    real(kind=8), intent(in), dimension(ndim0) :: xin
    real(kind=8), intent(in), dimension(ndim0) :: yin
    real(kind=8), intent(in), dimension(ndim0) :: arr
    real(kind=8), intent(in), dimension(nx) :: xout
    real(kind=8), intent(in), dimension(ny) :: yout

    ! Output vars
    real(kind=8), intent(out), dimension(ny, nx) :: phase

    ! Parameters
    integer(kind=4) :: i, j, cnt
    real(kind=8) :: dx, dy, total

    dx = ABS(xout(2) - xout(1)) / 2.0
    dy = ABS(yout(2) - yout(1)) / 2.0

    do j = 1, ny
        do i = 1, nx
             cnt = COUNT(((xin >= xout(i) - dx).AND. &
                        (xin < xout(i) + dx).AND. &
                        (yin >= yout(j) - dy).AND. &
                        (yin < yout(j) + dy)))

            if (cnt.EQ.0) then
                continue
            endif

            total = SUM(arr, MASK=((xin >= xout(i) - dx).AND. &
                            (xin < xout(i) + dx).AND. &
                            (yin >= yout(j) - dy).AND. &
                            (yin < yout(j) + dy)))

            phase(j, i) = total / cnt
       enddo
    enddo
    return
end subroutine phase_space_avg


subroutine phase_space_var(xin, yin, arr, xout, yout, ndim0, nx, ny, phase)
    ! Compute the Variance of the phase-space
    implicit none
    ! Input vars
    integer(kind=4), intent(in) :: ndim0, nx, ny  ! Arrays dimension
    real(kind=8), intent(in), dimension(ndim0) :: xin
    real(kind=8), intent(in), dimension(ndim0) :: yin
    real(kind=8), intent(in), dimension(ndim0) :: arr
    real(kind=8), intent(in), dimension(nx) :: xout
    real(kind=8), intent(in), dimension(ny) :: yout

    ! Output vars
    real(kind=8), intent(out), dimension(ny, nx) :: phase

    ! Parameters
    integer(kind=4) :: i, j, cnt
    real(kind=8) :: dx, dy, total, mean

    dx = ABS(xout(2) - xout(1)) / 2.0
    dy = ABS(yout(2) - yout(1)) / 2.0

    do j = 1, ny
        do i = 1, nx
             cnt = COUNT(((xin >= xout(i) - dx).AND. &
                        (xin < xout(i) + dx).AND. &
                        (yin >= yout(j) - dy).AND. &
                        (yin < yout(j) + dy)))

            if (cnt.EQ.0) then
                continue
            endif

            total = SUM(arr, MASK=((xin >= xout(i) - dx).AND. &
                            (xin < xout(i) + dx).AND. &
                            (yin >= yout(j) - dy).AND. &
                            (yin < yout(j) + dy)))

            mean = total / cnt
            total = SUM(arr ** 2 - mean ** 2, MASK=((xin >= xout(i) - dx).AND. &
                                                    (xin < xout(i) + dx).AND. &
                                                    (yin >= yout(j) - dy).AND. &
                                                    (yin < yout(j) + dy)))
            if (total <= 0) then
                phase(j, i) = -9999
            else
                phase(j, i) = total / (cnt - 1)
            endif
       enddo
    enddo
    return
end subroutine phase_space_var


subroutine phase_space_count(xin, yin, xout, yout, ndim0, nx, ny, phase)
    ! Count the number of elements in the phase-space
    implicit none
    ! Input vars
    integer(kind=4), intent(in) :: ndim0, nx, ny  ! Arrays dimension
    real(kind=8), intent(in), dimension(ndim0) :: xin
    real(kind=8), intent(in), dimension(ndim0) :: yin
    real(kind=8), intent(in), dimension(nx) :: xout
    real(kind=8), intent(in), dimension(ny) :: yout

    ! Output vars
    integer(kind=4), intent(out), dimension(ny, nx) :: phase

    ! Parameters
    integer(kind=4) :: i, j, cnt
    real(kind=8) :: dx, dy

    dx = ABS(xout(2) - xout(1)) / 2.0
    dy = ABS(yout(2) - yout(1)) / 2.0

    do j = 1, ny
        do i = 1, nx
            cnt = 0

            cnt = COUNT(((xin >= xout(i) - dx).AND. &
                        (xin < xout(i) + dx).AND. &
                        (yin >= yout(j) - dy).AND. &
                        (yin < yout(j) + dy)))

            phase(j, i) = cnt
       enddo
    enddo
    return
end subroutine phase_space_count


!subroutine compute_phasespace(x, y, z, phase, bins, nx)
!    ! Count the number of elements in the phase-space
!    implicit none
!    ! Input vars
!    real(kind=8), intent(in), dimension(nx) :: x, y, z
!    integer(kind=4), intent(in) :: nx
!    integer(kind=4), optional :: bins
!
!    ! Output vars
!    integer(kind=4) :: ndim0, i
!    real(kind=8), intent(out), allocatable :: phase(:, :)
!    real(kind=8), allocatable :: xout(:), yout(:)
!    real(kind=8) :: xmax, xmin, ymax, ymin, dx, dy
!
!    if(present(bins)) then
!        ndim0 = bins
!    else
!        ndim0 = 10
!    endif
!
!    ALLOCATE(xout(ndim0), yout(ndim0))
!    ALLOCATE(phase(ndim0, ndim0))
!
!    xmax = MAXVAL(x)
!    xmin = MINVAL(x)
!    ymax = MAXVAL(y)
!    ymin = MINVAL(y)
!    dx = (xmax - xmin) / ndim0
!    dy = (ymax - ymin) / ndim0
!
!    do i = 1, ndim0
!        xout(i) = i * dx + xmin
!        yout(i) = i * dy + ymin
!    enddo
!
!    call phase_space_avg(x, y, z, xout, yout, ndim0, nx, nx, phase)
!    return
!end subroutine compute_phasespace
