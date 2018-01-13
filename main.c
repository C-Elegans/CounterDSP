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
#include "spislave.h"
#include "asm_funcs.h"
#include "periph.h"

fractional dmabuf1[512] __attribute__((space(dma)));
fractional dmabuf2[512] __attribute__((space(dma)));

int main(void) {
  int i;
  /* Zero the DMA buffer */
  for(i=0;i<sizeof(dmabuf1)/sizeof(dmabuf1[0]);i++)
    dmabuf1[i] = 0;
  /* Set RA4 as output and set the pin high */
  TRISAbits.TRISA4 = 0;
  LATAbits.LATA4 = 1;
  /* Open the uart */
  configure_spi();
  configure_dma0();
  configure_adc();
  /* Begin a conversion */
  unsigned char inc = 0;
  unsigned char ctr = 0;
  while(1){
    //DMA0CONbits.CHEN = 1;
    ConvertADC1();
    //while(DMA0CONbits.CHEN){}
    /* putcUART1(ADCBUF0>>8 & 0xff); */
    /* putcUART1(ADCBUF0&0xff); */
    LATAbits.LATA4 ^= 1;
    send_byte(ctr);
    if(inc == 10){
      ctr++;
      inc = 0;
    }
    inc++;
  __delay32(100000);
  }

  
  /* Halt for the debugger */
  while(1){}
  return 0;
}
