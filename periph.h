#ifndef _PERIPH_H_
#define _PERIPH_H_
#include <uart.h>
#include <dsp.h>
#define FCY 79841000LL/2

void configure_adc(void);
void configure_dma0(void);
void configure_uart(void);
void ConvertADC1();

extern fractional dmabuf1[512] __attribute((space(dma)));
extern fractional dmabuf2[512] __attribute((space(dma)));

#endif
