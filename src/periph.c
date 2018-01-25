#include "periph.h"
#include <adc.h>
#include <dma.h>
#include <pps.h>
void configure_adc(void){


  // Enables ADC, enables continue on idle, sets it to 12 bit mode
  // Sets the format to fraction, sets the sample clock to software control   
  AD1CON1 = ADC_MODULE_OFF & ADC_IDLE_CONTINUE & ADC_AD12B_12BIT

    & ADC_FORMAT_SIGN_FRACT & ADC_CLK_AUTO & ADC_AUTO_SAMPLING_ON;
  AD1CON1bits.SSRC = 0b010;	/* Select Timer3 interrupt for compare */

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
  IFS0bits.AD1IF = 0;
  IEC0bits.AD1IE = 0;
  AD1CON1bits.ADON = 1;
}
void configure_dma0(void){
  /* Set dma to do a word transfer, from a peripheral, and interrupt
     when the block is finished */
  DMA0CON = DMA0_SIZE_WORD & PERIPHERAL_TO_DMA0 & DMA0_INTERRUPT_BLOCK & 
    /* Don't write to the peripheral, increment the write register each time */
    DMA0_NORMAL & DMA0_REGISTER_POST_INCREMENT &
    /* Swap buffers continuously, set the module to OFF for now */
    DMA0_CONTINUOUS_PING_PONG & DMA0_MODULE_OFF;
  /* Set the DMA trigger to the ADC conversion complete interrupt */
  DMA0REQ = DMA0_AUTOMATIC & 0b1101; 
  /* Set the first ping pong buffer to dmabuf1 */
  DMA0STA = __builtin_dmaoffset(&dmabuf1);
  /* Set the second ping pong buffer to dmabuf2 */
  DMA0STB = __builtin_dmaoffset(&dmabuf2);
  /* Sets the peripheral address to read from */
  DMA0PAD = (int) &ADCBUF0;
  /* Number of words to transfer */
  DMA0CNT = 256;
  /* Enable the DMA controller */
  DMA0CONbits.CHEN = 1;
}
void configure_uart(void){
  PPSUnLock;
  PPSOutput(OUT_FN_PPS_U1TX, OUT_PIN_PPS_RP11);
  PPSLock;
  OpenUART1(UART_EN & UART_NO_PAR_8BIT & UART_IDLE_CON &
          UART_IrDA_DISABLE & UART_MODE_SIMPLEX & UART_UEN_00 &
          UART_DIS_WAKE & UART_DIS_LOOPBACK & UART_DIS_ABAUD &
          UART_BRGH_FOUR & UART_1STOPBIT,
          UART_TX_ENABLE & UART_IrDA_POL_INV_ZERO,
	    FCY/(500000*4));
}

void setupTimer3(void){
  /* Setup for 10kHz sample rate */
  T3CON = 0;
  T3CONbits.TCKPS = 0b00;	/* Divide by 1 */
  TMR3 = 0;
  PR3 = FCY/5000LL;		/* Set for 10KHz */
  IFS0bits.T3IF = 0;
  T3CONbits.TON = 1;
}
