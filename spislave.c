#include "spislave.h"
#include <spi.h>
#include <pps.h>

void configure_spi(void){
  PPSUnLock;
  /* Setup output */
  PPSOutput(OUT_FN_PPS_SDO1, OUT_PIN_PPS_RP11);
  PPSInput(IN_FN_PPS_SCK1, IN_PIN_PPS_RP12);
  PPSInput(IN_FN_PPS_SDI1, IN_PIN_PPS_RP12);
  PPSInput(IN_FN_PPS_SS1, IN_PIN_PPS_RP12);
  PPSLock;
  /* Clear output buffer */
  SPI1BUF = 0;

  /* Allow the clock and data pins to be used by the spi module */
  SPI1CON1bits.DISSCK = 0;
  SPI1CON1bits.DISSDO = 0;
  /* 8 bit operation (for now) */
  SPI1CON1bits.MODE16 = 0;
  /* Something only for master mode*/
  SPI1CON1bits.SMP = 0;
  /* Set SPI for polarity mode 0 */
  SPI1CON1bits.CKE = 0;
  SPI1CON1bits.CKP = 0;
  /* SPI SSEL_N enabled */
  SPI1CON1bits.SSEN = 0;
  /* Set to slave mode */
  SPI1CON1bits.MSTEN = 0;

  SPI1STATbits.SPIROV = 0;
  SPI1STATbits.SPIEN = 1;
}

void send_byte(unsigned char b){
  SPI1BUF = b;
}

