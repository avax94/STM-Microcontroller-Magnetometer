#include "lcd.h"

void init_io() {
  // Enable GPIOC clock
    RCC_AHB1ENR  |= ((1UL << 2) );

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
    GPIOC_PUPDR   &= ~((3UL << 2*0));}




void main() {
     init_io();
     init_lcd();
     GPIOC_ODR = 0;
     clear_lcd();
     set_position(0, 0);
     write_string("avaxe bravo");
     Delay_ms(5000);
     set_position(1, 0);
     write_string("BRZINAAA");
     while(1) {}
}