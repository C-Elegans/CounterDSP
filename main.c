/*
 * File:   main.c
 * Author: mnolan
 *
 * Created on December 27, 2017, 4:14 PM
 */
// DSPIC33FJ128GP802 Configuration Bit Settings

// 'C' source line config statements

// FBS
#pragma config BWRP = WRPROTECT_OFF     // Boot Segment Write Protect (Boot Segment may be written)
#pragma config BSS = NO_FLASH           // Boot Segment Program Flash Code Protection (No Boot program Flash segment)
#pragma config RBS = NO_RAM             // Boot Segment RAM Protection (No Boot RAM)

// FSS
#pragma config SWRP = WRPROTECT_OFF     // Secure Segment Program Write Protect (Secure segment may be written)
#pragma config SSS = NO_FLASH           // Secure Segment Program Flash Code Protection (No Secure Segment)
#pragma config RSS = NO_RAM             // Secure Segment Data RAM Protection (No Secure RAM)

// FGS
#pragma config GWRP = OFF               // General Code Segment Write Protect (User program memory is not write-protected)
#pragma config GSS = OFF                // General Segment Code Protection (User program memory is not code-protected)

// FOSCSEL
#pragma config FNOSC = FRC              // Oscillator Mode (Internal Fast RC (FRC))
#pragma config IESO = OFF               // Internal External Switch Over Mode (Start-up device with user-selected oscillator source)

// FOSC
#pragma config POSCMD = NONE            // Primary Oscillator Source (Primary Oscillator Disabled)
#pragma config OSCIOFNC = ON            // OSC2 Pin Function (OSC2 pin has digital I/O function)
#pragma config IOL1WAY = OFF            // Peripheral Pin Select Configuration (Allow Multiple Re-configurations)
#pragma config FCKSM = CSDCMD           // Clock Switching and Monitor (Both Clock Switching and Fail-Safe Clock Monitor are disabled)

// FWDT
#pragma config WDTPOST = PS32768        // Watchdog Timer Postscaler (1:32,768)
#pragma config WDTPRE = PR128           // WDT Prescaler (1:128)
#pragma config WINDIS = OFF             // Watchdog Timer Window (Watchdog Timer in Non-Window mode)
#pragma config FWDTEN = OFF             // Watchdog Timer Enable (Watchdog timer enabled/disabled by user software)

// FPOR
#pragma config FPWRT = PWR128           // POR Timer Value (128ms)
#pragma config ALTI2C = OFF             // Alternate I2C  pins (I2C mapped to SDA1/SCL1 pins)

// FICD
#pragma config ICS = PGD1               // Comm Channel Select (Communicate on PGC1/EMUC1 and PGD1/EMUD1)
#pragma config JTAGEN = OFF             // JTAG Port Enable (JTAG is Disabled)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>



#include <dsp.h>
#include <uart.h>
#include <adc.h>
#include <dma.h>
#include <stdio.h>
#include "asm_funcs.h"
#define FCY 7372800LL

fractional dmabuf1[512] __attribute__((space(dma)));
fractional dmabuf2[512] __attribute__((space(dma)));
/*
_FOSCSEL(FNOSC_FRCPLL);
_FOSC(OSCIOFNC_OFF & POSCMD_NONE);
_FWDT(FWDTEN_OFF);
_FICD(JTAGEN_OFF & ICS_PGD1);
void setup_pll(void){
    CLKDIVbits.PLLPRE=0;        // PLLPRE (N2) 0=/2
    PLLFBD=41;                  // pll multiplier (M) = +2
    CLKDIVbits.PLLPOST=0;       // PLLPOST (N1) 0=/2
       while(!OSCCONbits.LOCK);    // wait for PLL ready
}*/
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
            DMA0_NORMAL & DMA0_REGISTER_POST_INCREMENT & DMA0_ONE_SHOT & DMA0_MODULE_OFF;
    DMA0REQ = DMA0_AUTOMATIC & 0b1101; // ADC interrupt
    DMA0STA = __builtin_dmaoffset(dmabuf1);
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
//    volatile int i = 0;
//    for(i=0;i<1000;i++){}
    ConvertADC1();

    while(DMA0CONbits.CHEN){}
    for(i=0;i<10;i++){
        printf("%x\n", dmabuf1[i]);
        
    }
    //convolve(data1,7,filter,4);
    return 0;
}
