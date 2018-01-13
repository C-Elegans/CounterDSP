#ifndef _PERIPH_H_
#define _PERIPH_H_
#include <adc.h>
#include <dma.h>
#include <uart.h>
#include <pps.h>
#include <dsp.h>
#define FCY 7372800LL/2

void configure_adc(void);
void configure_dma0(void);
void configure_uart(void);

extern fractional dmabuf1[512] __attribute((space(dma)));
extern fractional dmabuf2[512] __attribute((space(dma)));

#endif
