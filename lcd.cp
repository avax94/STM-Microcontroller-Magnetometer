#line 1 "G:/Projects/MIPS/P1/lcd.c"
#line 28 "G:/Projects/MIPS/P1/lcd.c"
volatile sbit LCD_D4 at GPIOC_ODR.B0;
volatile sbit LCD_D5 at GPIOC_ODR.B1;
volatile sbit LCD_D6 at GPIOC_ODR.B2;
volatile sbit LCD_D7 at GPIOC_ODR.B3;
volatile sbit LCD_RS at GPIOC_ODR.B4;
volatile sbit LCD_EN at GPIOC_ODR.B13;

 void init_lcd() {
  GPIOC_ODR = 0x0 ;
 Delay_ms(20);
  GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x33 >> 4 ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us (1); GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x33 & 0xF ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us(1); ;
 Delay_ms(20);
  GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x32 >> 4 ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us (1); GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x32 & 0xF ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us(1); ;
 Delay_us(20);
  GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x28 >> 4 ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us (1); GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x28 & 0xF ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us(1); ;
 Delay_us(20);
  GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x08 >> 4 ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us (1); GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x08 & 0xF ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us(1); ;
 Delay_us(20);
  GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x01 >> 4 ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us (1); GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x01 & 0xF ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us(1); ;
 Delay_us(900);
  GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x06 >> 4 ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us (1); GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x06 & 0xF ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us(1); ;
 Delay_us(20);
  GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x0C >> 4 ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us (1); GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x0C & 0xF ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us(1); ;
 Delay_us(20);
  GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x02 >> 4 ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us (1); GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x02 & 0xF ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us(1); ;
 Delay_us(20);
}

void set_position(char x, char y){
 unsigned char pos;
 switch(x){
 case 0: pos = y; break;
 case 1: pos = 0x40+y; break;
 default: pos = y;
 }

 GPIOC_ODR = 0;
  GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x80 | pos >> 4 ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us (1); GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x80 | pos & 0xF ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us(1); ;
 Delay_ms(20);
}

void write_lcd(char c) {
 GPIOC_ODR =  0x10 ;
  GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | c >> 4 ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us (1); GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | c & 0xF ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us(1); ;
 Delay_ms(2);
}

void write_string(char* c) {
 while(*c != '\0') {
 write_lcd(*c);
 c++;
 }
}

void clear_lcd() {
  GPIOC_ODR = 0x0 ;
  GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x01 >> 4 ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us (1); GPIOC_ODR |= (1UL << 13) ; GPIOC_ODR = (GPIOC_ODR & ~0xF) | 0x01 & 0xF ; GPIOC_ODR &= ~(1UL << 13) ; ; Delay_us(1); ;

}
