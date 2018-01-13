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
#include "spislave.h"
#include "asm_funcs.h"
#include "periph.h"

fractional dmabuf1[512] __attribute__((space(dma)));
fractional dmabuf2[512] __attribute__((space(dma)));
void setup_clock(void){
  CLKDIVbits.PLLPRE = 1;
  PLLFBD = 63;
  CLKDIVbits.PLLPOST = 0;
  while(!OSCCONbits.LOCK);
}
char hexlut[] ="0123456789ABCDEF";
int main(void) {
  int i;
  
  /* Zero the DMA buffer */
  for(i=0;i<sizeof(dmabuf1)/sizeof(dmabuf1[0]);i++)
    dmabuf1[i] = 0;
  /* Set RA4 as output and set the pin high */
  TRISAbits.TRISA4 = 0;
  LATAbits.LATA4 = 1;
  setup_clock();
  /* Open the uart */
  configure_uart();
  //configure_spi();
  configure_dma0();
  configure_adc();
  unsigned char inc = 0;
  unsigned char ctr = 0;
  while(1){
    while(IFS0bits.DMA0IF == 0) {}
    IFS0bits.DMA0IF = 0;
    /* putcUART1(ADCBUF0>>8 & 0xff); */
    /* putcUART1(ADCBUF0&0xff); */
    LATAbits.LATA4 ^= 1;
    char str[] = "  \r\n";
    str[0] = hexlut[dmabuf1[0] >> 12 & 0xf];
    str[1] = hexlut[dmabuf1[0] >> 8 & 0xf];
    putsUART1(str);
    //send_byte(ctr);
    if(inc == 10){
      ctr++;
      inc = 0;
    }
    inc++;
    DMA0CONbits.CHEN = 1;
  }

  
  /* Halt for the debugger */
  while(1){}
  return 0;
}
