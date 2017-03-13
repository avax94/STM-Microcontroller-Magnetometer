#include "lcd.h"
#include "i2c.h"
#include "magnetometer.h"

void main() {
     init_lcd();
     i2c_init();
     init_magnetometer();

     while(1) {
            asm{ WFI; }
     }
}