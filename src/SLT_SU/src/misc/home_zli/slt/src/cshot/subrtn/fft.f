* Copyright (c) Colorado School of Mines, 1990.
* All rights reserved.

      subroutine four1(data,nn,isign)
c     FFT taken from: Numerical Recipes in Fortran, Press et. al.,
c     Cambridge Univ. Press, P.394.

      real*8  wr,  wi,  wpr,  wpi,  wtemp,  theta
      dimension  data(2*nn)

      n = 2*nn
      j = 1
      do 11 i = 1, n, 2
         if(j.gt.i) then
            tempr = data(j)
            tempi = data(j+1)
            data(j) = data(i)
            data(j+1) = data(i+1)
            data(i) = tempr
            data(i+1) = tempi
         end if
         m = n / 2
1        if((m.ge.2).and.(j.gt.m)) then
            j = j - m
            m = m / 2
            go to 1
         end if
         j = j + m
11       continue
      mmax = 2
2     if(n.gt.mmax) then
         istep = 2 * mmax
         theta = 6.28318530717959D0 / (isign*mmax)
         wpr = -2.D0 * DSIN(0.5D0*theta)**2
         wpi = DSIN(theta)
         wr = 1.D0
         wi = 0.D0
         do 13 m = 1,  mmax, 2
            do 12 I = m, n, istep
               j = i + mmax
               tempr = SNGL(wr) * data(j) - SNGL(wi) * data(j+1)
               tempi = SNGL(wr) * data(j+1) + SNGL(wi) * data(j)
               data(j) = data(i) - tempr
               data(j+1) = data(i+1) - tempi
               data(i) = data(i) + tempr
               data(i+1) = data(i+1) + tempi
12             continue
            wtemp = wr
            wr = wr * wpr - wi * wpi + wr
            wi = wi * wpr + wtemp * wpi + wi
13          continue
         mmax = istep
         go to 2
      end if

      return 
      end

c-----------------------------------------------------------------

        SUBROUTINE FACT2(N,IPOW2)
c       Finds the first power of two greater or equal to N.

        INTEGER   IPOW2,   N

cc      local    variables
c       NCHECK   value of N after repeated division by two
c       NDIFF    difference between N and nearest (lower) power
c                of two

        INTEGER   NCHECK,    NDIFF

        NCHECK = N
        IPOW2  = 0

10      IF(NCHECK.GT.1) THEN
           NCHECK = NCHECK / 2
           IPOW2  = IPOW2  + 1
           GO TO 10
        END IF

        NDIFF = N - 2**IPOW2
        IF(NDIFF.GT.0) THEN
           IPOW2 = IPOW2 + 1
        END IF

        RETURN
        END
c----------------------------------------------------------------
