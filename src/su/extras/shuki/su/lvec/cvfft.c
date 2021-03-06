/* Four fft subroutines based on the algorithm used in fork (FGDP, p. 12) 
 * and modeled after Clayton's and Ottolini's subroutines
 *********************************************************************
 *								     *
 *	        lx-1					     *
 *	x(k) =  sum  [x(j)*exp(isign*2*pi*sqrt(-1)*j*k/lx]    *
 *	        j=0					     *
 *								     *
 *********************************************************************
 *
 *		refft (x,lx,isign,mode)
 *		cefft (x,lx,isign)
 *		rvfft (x,lx,nx,isign,mode)
 *		cvfft (x,lx,nx,isign)
 *
 * See each subroutine below for a description of the arguments.
 */
#ifdef HP
#define _ROWCC_ rowcc
#else
#define _ROWCC_ rowcc_
#endif
typedef struct {float re,im;} complex;

/* 	cvfft	nx complex vectors to nx complex vectors in core
 *
 *	x	input/output array
 *	lx	length of complex vectors
 *	nx	number of vectors; must be a power of 2
 *	isign	sign of sqrt(-1)
*/
cvfft (x,lx,nx,isign)
complex *x;
int lx,nx,isign;
   {
    float rscale, sign2;

    rscale = 1.0;
    sign2 = (float) isign;

    _ROWCC_(&lx,&nx,x,&sign2,&rscale);

   }
