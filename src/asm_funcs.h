#ifndef __ASM_FUNCS_H__
#define __ASM_FUNCS_H__
#include <dsp.h>
/*
 * Convolve: convolves the kernel with the input signal and writes the result to input. 
 * parameters:
 *      signal: This needs to have length(actual signal)+2*length(kernel)-1 elements
 *              and needs to have zero padding of length(kernel)-1 at the beginning
 *              and zero padding of length(kernel) at the end. It also must lie in the 
 *              Xdata portion of memory
 *      signal_len: The number of elements in the actual signal + length(kernel)-1
 *      kernel: The data to convolve with signal. This data needs to lie in the Ydata
 *              portion of memory. kernel is not reversed in this function, so will 
 *              likely need to be reversed before calling the function
 *      klen:   The length of the kernel
 * Example: I want to convolve {1,2,3,4} with {5,6,7,8}.
 * fractional x[11] = {0,0,0,1,2,3,4,0,0,0,0};
 * fractional y[4]  = {8,7,6,5};
 * convolve(x,11,y,4);
 */
void convolve(fractional* signal, uint16_t signal_len, short* kernel, uint16_t klen);


void vmul(fractional* dst, short* src, uint16_t buflen);
uint16_t count_spikes(fractional* data, uint16_t len, fractional threshold);

#endif
