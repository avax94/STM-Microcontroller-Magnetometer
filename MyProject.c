#include "lcd.h"
#include "i2c.h"
#include "magnetometer.h"
#include "interrupts.h"
void main() {
     disInterrupts();
     init_lcd();
     i2c_init();
     init_magnetometer();
     enInterrupts();

     while(1) {
            asm{ WFI; }
     }
}