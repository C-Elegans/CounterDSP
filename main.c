/*
 * File:   main.c
 * Author: mnolan
 *
 * Created on December 27, 2017, 4:14 PM
 */


#include "config.h"
#include <libpic30.h>
#include <dsp.h>
#include <uart.h>
#include <adc.h>
#include <pps.h>
#include <dma.h>
#include <stdio.h>
#include "asm_funcs.h"
#define FCY 7372800LL/2

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
  /* Set dma to do a word transfer, from a peripheral, and interrupt
     when the block is finished */
  DMA0CON = DMA0_SIZE_WORD & PERIPHERAL_TO_DMA0 & DMA0_INTERRUPT_BLOCK & 
    /* Don't write to the peripheral, increment the write register each time */
    DMA0_NORMAL & DMA0_REGISTER_POST_INCREMENT &
    /* Swap buffers continuously, set the module to OFF for now */
    DMA0_ONE_SHOT & DMA0_MODULE_OFF;
  /* Set the DMA trigger to the ADC conversion complete interrupt */
  DMA0REQ = DMA0_AUTOMATIC & 0b1101; 
  /* Set the first ping pong buffer to dmabuf1 */
  DMA0STA = __builtin_dmaoffset(dmabuf1);
  /* Set the second ping pong buffer to dmabuf2 */
  DMA0STB = __builtin_dmaoffset(dmabuf2);
  /* Sets the peripheral address to read from */
  DMA0PAD = (int) &ADCBUF0;
  /* Number of words to transfer */
  DMA0CNT = sizeof(dmabuf1)/sizeof(dmabuf1[0]);
  /* Enable the DMA controller */
  
}
void configure_uart(void){
  PPSUnLock;
  PPSOutput(OUT_FN_PPS_U1TX, OUT_PIN_PPS_RP11);
  PPSLock;
  OpenUART1(UART_EN & UART_NO_PAR_8BIT & UART_IDLE_CON &
          UART_IrDA_DISABLE & UART_MODE_SIMPLEX & UART_UEN_00 &
          UART_DIS_WAKE & UART_DIS_LOOPBACK & UART_DIS_ABAUD &
          UART_BRGH_SIXTEEN & UART_1STOPBIT,
          UART_TX_ENABLE & UART_IrDA_POL_INV_ZERO,
          (FCY/115200)/16 - 1);
}
void trig(void){}

int main(void) {
  int i;
  /* Zero the DMA buffer */
  for(i=0;i<sizeof(dmabuf1)/sizeof(dmabuf1[0]);i++)
    dmabuf1[i] = 0;
  /* Set RA4 as output and set the pin high */
  TRISAbits.TRISA4 = 0;
  LATAbits.LATA4 = 1;
  /* Open the uart */
  configure_uart();
  configure_dma0();
  configure_adc();
  /* Begin a conversion */
  
  while(1){
    //DMA0CONbits.CHEN = 1;
    ConvertADC1();
    //while(DMA0CONbits.CHEN){}
    putcUART1(ADCBUF0>>8 & 0xff);
    putcUART1(ADCBUF0&0xff);
  __delay32(1000000);
  }

  
  /* Halt for the debugger */
  while(1){}
  return 0;
}
