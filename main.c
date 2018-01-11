/*
 * File:   main.c
 * Author: mnolan
 *
 * Created on December 27, 2017, 4:14 PM
 */


#include "config.h"
#include <dsp.h>
#include <uart.h>
#include <adc.h>
#include <dma.h>
#include <stdio.h>
#include "asm_funcs.h"
#define FCY 7372800LL

fractional dmabuf1[512] __attribute__((space(dma)));
fractional dmabuf2[512] __attribute__((space(dma)));
void configure_adc(void){


  // Enables ADC, enables continue on idle, sets it to 12 bit mode
  // Sets the format to fraction, sets the sample clock to software control   
  AD1CON1 = ADC_MODULE_ON & ADC_IDLE_CONTINUE & ADC_AD12B_12BIT

    & ADC_FORMAT_SIGN_FRACT & ADC_CLK_AUTO & ADC_AUTO_SAMPLING_ON;

  //config2
  // Uses GND and VCC for the voltage reference
  AD1CON2bits.VCFG = 0b000;
    

  //config3
  // Use system clock for adc
  AD1CON3 = ADC_SAMPLE_TIME_15 & ADC_CONV_CLK_SYSTEM & ADC_CONV_CLK_60Tcy;
	    
  //config4
  //Unused as I'm not using DMA
  AD1CON4 = 0;
       
  // Use AN9 for CH0 analog input
  AD1CHS0 = 9;
  AD1CSSL = 1<<9;
    
  // Sets AN9 as an analog pin
  AD1PCFGL = ~(1<<9);
}
void configure_dma0(void){
  DMA0CON = DMA0_SIZE_WORD & PERIPHERAL_TO_DMA0 & DMA0_INTERRUPT_BLOCK & 
    DMA0_NORMAL & DMA0_REGISTER_POST_INCREMENT &
    DMA0_CONTINUOUS_PING_PONG & DMA0_MODULE_OFF;
  DMA0REQ = DMA0_AUTOMATIC & 0b1101; // ADC interrupt
  DMA0STA = __builtin_dmaoffset(dmabuf1);
  DMA0STB = __builtin_dmaoffset(dmabuf2);
  DMA0PAD = (int) &ADCBUF0;
  DMA0CNT = sizeof(dmabuf1)/sizeof(dmabuf1[0]);
  //DMA0CNT = 10;
  DMA0CONbits.CHEN = 1;
}
void trig(void){}

int main(void) {
  int i;
  for(i=0;i<sizeof(dmabuf1)/sizeof(dmabuf1[0]);i++)
    dmabuf1[i] = 0;
  TRISAbits.TRISA4 = 0;
  LATAbits.LATA4 = 1;
  OpenUART1(UART_EN & UART_NO_PAR_8BIT, UART_TX_ENABLE, (FCY/115200)/16 - 1);
  configure_dma0();
  configure_adc();
  ConvertADC1();

  return 0;
}
