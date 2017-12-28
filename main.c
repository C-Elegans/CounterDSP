/*
 * File:   main.c
 * Author: mnolan
 *
 * Created on December 27, 2017, 4:14 PM
 */


#include "xc.h"
#include <dsp.h>
#include <uart.h>
#include "asm_funcs.h"
#define FCY 7372800LL

short _XDATA(2) data1[11] = {0,0,0,0x100,0x200,0x300,0x400,0,0,0};
short _YDATA(2) filter[5] = {0x400,0x500,0x600,0x700};

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

int main(void) {
    OpenUART1(UART_EN & UART_NO_PAR_8BIT, UART_TX_ENABLE, (FCY/115200)/16 - 1);
    CORCONbits.IF = 1; //Integer
    putsUART1("Hello world2!\n");
   
    while(BusyUART1()){}
    convolve(data1,7,filter,4);
    return 0;
}
