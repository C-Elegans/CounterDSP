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
#define REAL_LOGN 10
#define FFT_BLOCK_SIZE (1<<REAL_LOGN)
fractional dmabuf1[256] __attribute__((space(dma)));
fractional dmabuf2[256] __attribute__((space(dma)));
fractional tmpbuf[256] __attribute__((space(ymemory)));
fractional convolvebuf[512] __attribute__((space(ymemory)));
fractional convolvedest[1024] __attribute__((space(ymemory)));
fractional sig[64] __attribute__((space(xmemory)));

void setup_clock(void){
  CLKDIVbits.PLLPRE = 1;
  PLLFBD = 63;
  CLKDIVbits.PLLPOST = 0;
  while(!OSCCONbits.LOCK);
}

void writeBufUART1(void* data, size_t size){
  char* tmp_ptr = (char*) data;
  size_t i;
  for(i=0;i<size;i++){
    while(U1STAbits.UTXBF);  /* wait if the buffer is full */
    U1TXREG = *tmp_ptr++;   /* transfer data byte to TX reg */
  }
}
void convbufcopy(fractional* source, fractional* dest){
  memcpy(dest, tmpbuf, sizeof(tmpbuf));
  memcpy(dest+sizeof(tmpbuf), source, 256*sizeof(fractional));

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
		   sizeof(sig)/sizeof(fractional),
		   convolvedest,
		   convolvebuf,
		   sig);
    char str[] = "\xaa\x55";
    putsUART1(str);
    writeBufUART1(convolvedest-1+sizeof(sig)/sizeof(fractional),512);
    IFS0bits.DMA0IF = 0;
}


int main(void) {
  int i;
  /* Zero the DMA buffer */
  for(i=0;i<sizeof(dmabuf1)/sizeof(dmabuf1[0]);i++)
    dmabuf1[i] = 0;
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
