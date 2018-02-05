/*
 * File:   main.c
 * Author: mnolan
 *
 * Created on December 27, 2017, 4:14 PM
 */


#include "config.h"
#include <libpic30.h>
#include <pps.h>
#include <stdio.h>
#include <string.h>
#include <dma.h>
#include "spislave.h"
#include "asm_funcs.h"
#include "periph.h"
#define ARRAY_LEN(x) (sizeof(x)/sizeof(x[0]))
fractional dmabuf1[256] __attribute__((space(dma)));
fractional dmabuf2[256] __attribute__((space(dma)));
fractional tmpbuf[256] __attribute__((space(ymemory)));
fractional convolvebuf[512] __attribute__((space(ymemory)));
fractional convolvedest[1024] __attribute__((space(ymemory)));

extern int siglen;
extern fractional sig[] __attribute__((space(xmemory)));

int total = 0;


void convbufcopy(fractional* source, fractional* dest){
  memcpy(dest, tmpbuf, sizeof(tmpbuf));
  memcpy(dest+ARRAY_LEN(tmpbuf), source, 256*sizeof(fractional));

  memcpy(tmpbuf, source, sizeof(tmpbuf));
}

void __attribute__((interrupt, no_auto_psv)) _DMA0Interrupt(void){
    LATAbits.LATA4 ^= 1;
    fractional* buf = NULL;
    if(PingPongStatusDMA0()){
      buf = dmabuf1;
    } else {
      buf = dmabuf2;
    }
    convbufcopy(buf,convolvebuf);
    VectorConvolve(sizeof(convolvebuf)/sizeof(fractional),
    		   siglen,
    		   convolvedest,
    		   convolvebuf,
    		   sig);
    vshl(convolvedest, 512, 1);
    vsquare(convolvedest, 512);
    vshl(convolvedest, 512, 1);
    total += count_spikes(convolvedest+siglen, 256, Q15(0.2));
    char str[] = "\xaa\x55";
    putsUART1((unsigned int*)str);
    writeBufUART1(&total, sizeof(total));
    writeBufUART1(convolvedest+siglen,256*sizeof(fractional));

    IFS0bits.DMA0IF = 0;
}


int main(void) {
  /* Set RA4 as output and set the pin high */
  TRISAbits.TRISA4 = 0;
  LATAbits.LATA4 = 0;

  setup_clock();
  configure_uart();
  configure_dma0();
  IFS0bits.DMA0IF = 0;
  IEC0bits.DMA0IE = 1;
  configure_adc();
  setupTimer3();
  while(1){
  }
  return 0;
}
