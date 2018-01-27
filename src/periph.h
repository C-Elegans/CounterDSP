#ifndef _PERIPH_H_
#define _PERIPH_H_
#include <uart.h>
#include <dsp.h>
#define FCY 79841000LL/2

void setup_clock(void);
void configure_adc(void);
void configure_dma0(void);
void configure_uart(void);
void ConvertADC1();
void writeBufUART1(void* data, size_t size);
void setupTimer3(void);

extern fractional dmabuf1[256] __attribute((space(dma)));
extern fractional dmabuf2[256] __attribute((space(dma)));

#endif
