#include "lcd.h"
#include "i2c.h"
#include "magnetometer.h"
void init_io() {
    // Enable GPIOC clock
    RCC_AHB1ENRbits.GPIOCEN = 1; //  |= ((1UL << 2) );
    RCC_AHB1LPENRbits.GPIOCLPEN = 1;
    // Clear bits for ports C0 C1 C2 C3 C4 C13
    GPIOC_MODER &= ~((3UL << 2*13));
    GPIOC_MODER &= ~((3UL << 2*4));
    GPIOC_MODER &= ~((3UL << 2*3));
    GPIOC_MODER &= ~((3UL << 2*2));
    GPIOC_MODER &= ~((3UL << 2*1));
    GPIOC_MODER &= ~((3UL << 2*0));

    // Set bits for ports C0 C1 C2 C3 C4 C13 OUTPUT MODE (01b)
    GPIOC_MODER |= ((1UL << 2*13));
    GPIOC_MODER |= ((1UL << 2*4));
    GPIOC_MODER |= ((1UL << 2*3));
    GPIOC_MODER |= ((1UL << 2*2));
    GPIOC_MODER |= ((1UL << 2*1));
    GPIOC_MODER |= ((1UL << 2*0));

    // Set push-pull (reset state) on zero for ports C0 C1 C2 C3 C4 C13
    /*
    GPIOC_OTYPER &= ~((1UL << 13));
    GPIOC_OTYPER &= ~((1UL << 4));
    GPIOC_OTYPER &= ~((1UL << 3));
    GPIOC_OTYPER &= ~((1UL << 2));
    GPIOC_OTYPER &= ~((1UL << 1));
    GPIOC_OTYPER &= ~((1UL << 0));
    */

    GPIOC_OTYPER &= ~((3UL << 13));
    GPIOC_OTYPER &= ~((3UL << 4));
    GPIOC_OTYPER &= ~((3UL << 3));
    GPIOC_OTYPER &= ~((3UL << 2));
    GPIOC_OTYPER &= ~((3UL << 1));
    GPIOC_OTYPER &= ~((3UL << 0));

    // Clear bits OSEED registar for ports  C0 C1 C2 C3 C4 C13
    GPIOC_OSPEEDR &= ~((3UL << 2*13));
    GPIOC_OSPEEDR &= ~((3UL << 2*4));
    GPIOC_OSPEEDR &= ~((3UL << 2*3));
    GPIOC_OSPEEDR &= ~((3UL << 2*2));
    GPIOC_OSPEEDR &= ~((3UL << 2*1));
    GPIOC_OSPEEDR &= ~((3UL << 2*0));

    // Set bits OSEED registar for ports  C0 C1 C2 C3 C4 C13    on high speed (2h = 10b)
    GPIOC_OSPEEDR |= ((3UL << 2*13));
    GPIOC_OSPEEDR |= ((3UL << 2*4));
    GPIOC_OSPEEDR |= ((3UL << 2*3));
    GPIOC_OSPEEDR |= ((3UL << 2*2));
    GPIOC_OSPEEDR |= ((3UL << 2*1));
    GPIOC_OSPEEDR |= ((3UL << 2*0));

    // Clear bits PUPD registar for ports  C0 C1 C2 C3 C4 C13 - NO PULL (00b = 0)
    GPIOC_PUPDR   &= ~((3UL << 2*13));
    GPIOC_PUPDR   &= ~((3UL << 2*4));
    GPIOC_PUPDR   &= ~((3UL << 2*3));
    GPIOC_PUPDR   &= ~((3UL << 2*2));
    GPIOC_PUPDR   &= ~((3UL << 2*1));
    GPIOC_PUPDR   &= ~((3UL << 2*0));
}

void read_who_am_i2() {
    char result = 11;
    char send_addr = 0x07;
    char st[32];
    char st2;
    i2c_start_async();
    i2c_send_addr_async(0x0E, 0);
    i2c_send_async(&send_addr, 1);
    Delay_ms(1000);
    i2c_start_async();
    i2c_send_addr_async(0x0E, 1);
    i2c_recv_async(&result, 1);

    Delay_ms(1000);
    //i2c_stop();
 
 
    IntToHex(result, st);
    clear_lcd();
    set_position(0, 0);
    write_string(st);
}


void main() {
     int counter;
     char d[6];
     char output[5];
     init_io();
     init_lcd();
     i2c_init();
     
     init_magnetometer();

     while(1) {
            asm{ WFI; }
     }
}