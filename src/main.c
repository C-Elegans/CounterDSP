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

/* Ping pong buffers for DMA */
fractional dmabuf1[256] __attribute__((space(dma)));
fractional dmabuf2[256] __attribute__((space(dma)));
/* Buffer to hold the previous 256 samples */
fractional tmpbuf[256] __attribute__((space(ymemory)));
/* Holds the concatenated old and new samples */
fractional convolvebuf[512] __attribute__((space(ymemory)));
/* TODO: reduce the memory here */
fractional convolvedest[1024] __attribute__((space(ymemory)));

extern int siglen;
/* Holds the signal to convolve with */
extern fractional sig[] __attribute__((space(xmemory)));

int total = 0;


void convbufcopy(fractional* source, fractional* dest){
  /* Concatenate the old signal and new signal */
  memcpy(dest, tmpbuf, sizeof(tmpbuf));
  memcpy(dest+ARRAY_LEN(tmpbuf), source, 256*sizeof(fractional));
  /* Copy the new signal to tmpbuf so it can be used in the next block */
  memcpy(tmpbuf, source, sizeof(tmpbuf));
}

void __attribute__((interrupt, no_auto_psv)) _DMA0Interrupt(void){
    IFS0bits.DMA0IF = 0;
    fractional* buf = NULL;
    /* The DMA engine fills up one buffer while another one is
       processed. This figures out which buffer has already been
       filled by the DMA and needs processing */
    if(PingPongStatusDMA0()){
      buf = dmabuf1;
    } else {
      buf = dmabuf2;
    }

    /* Concatenate the new samples from the buffer above with the
       previous samples and place them into convolvebuf. This is so
       the convolution isn't starting fresh by the time it gets to the
       new samples */
    convbufcopy(buf,convolvebuf);
    VectorConvolve(sizeof(convolvebuf)/sizeof(fractional),
    		   siglen,
    		   convolvedest,
    		   convolvebuf,
    		   sig);
    /* Multiply the buffer by 2 so the squaring doesn't lose *too* much
       precision */
    vshl(convolvedest, 512, 1);
    vsquare(convolvedest, 512);
    /* Again multiply the buffer by 2, so the reduction in amplitude
       by the square is corrected */
    vshl(convolvedest, 512, 1);
    /* Count the number of times the signal crosses the threshold on a
       rising edge */
    total += count_spikes(convolvedest+siglen, 256, Q15(0.2));

    /* Transmit the signal to my waveform viewer. The 0xaa 0x55 is to
       synchronize the display with the start of a buffer, as 0xaa55
       is not a valid bit of data (not sure if still invalid,
       previously the data was 12 bits, so the lower 4 bits were
       always 0, however the scaling may mess this up */
    char str[] = "\xaa\x55";
    putsUART1((unsigned int*)str);
    writeBufUART1(&total, sizeof(total));
    writeBufUART1(convolvedest+siglen,256*sizeof(fractional));
}


int main(void) {
  /* Set up an LED as a status indicator */
  TRISAbits.TRISA4 = 0;
  LATAbits.LATA4 = 0;

  /* Set the clock to 79.9MHz */
  setup_clock();
  configure_uart();
  configure_dma0();

  /* Enable the DMA interrupt */
  IFS0bits.DMA0IF = 0;
  IEC0bits.DMA0IE = 1;

  /* Configure ADC to trigger on timer 3 overflow, and set up timer
     3 */
  configure_adc();
  setupTimer3();
  while(1){
  }
  return 0;
}
