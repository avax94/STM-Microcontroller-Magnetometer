#define S_DDRAM 0b001
#define W_RAM 0x10
#define EN_SET GPIOC_ODR |= (1UL << 13)
#define EN_R GPIOC_ODR &= ~(1UL << 13)
#define START_COMMAND GPIOC_ODR = 0x0
#define setLow(x) GPIOC_ODR = (GPIOC_ODR & ~0xF) | x
#define send_data(x)  EN_SET; \
                      setLow(x); \
                      EN_R;
#define send_word(x)  send_data(x >> 4); \
                      Delay_us (1); \
                      send_data(x & 0xF); \
                      Delay_us(1);
               // 0100 0001

#define LCD_CLEAR_DISPLAY           0x01
#define LCD_RETRN_HOME              0x02
#define LCD_DISP_INIT               0x28
#define LCD_INC_MODE                0x06
#define LCD_DISP_ON                 0x0C
#define LCD_DISP_OFF                0x08
#define LCD_CURSOR_ON               0x04
#define LCD_CURSOR_OFF              0x00
#define LCD_CUR_MOV_LEFT            0x10
#define LCD_CUR_MOV_RIGHT           0x14
#define LCD_BUSY                    0x80

volatile sbit LCD_D4 at GPIOC_ODR.B0;
volatile sbit LCD_D5 at GPIOC_ODR.B1;
volatile sbit LCD_D6 at GPIOC_ODR.B2;
volatile sbit LCD_D7 at GPIOC_ODR.B3;
volatile sbit LCD_RS at GPIOC_ODR.B4;
volatile sbit LCD_EN at GPIOC_ODR.B13;
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

 void init_lcd() {
     init_io();
     START_COMMAND;
     Delay_ms(20);
     send_word(0x33);
     Delay_ms(20);
     send_word(0x32);
     Delay_us(20);
     send_word(LCD_DISP_INIT);
     Delay_us(20);
     send_word(LCD_DISP_OFF);
     Delay_us(20);
     send_word(LCD_CLEAR_DISPLAY);
     Delay_us(900);
     send_word(LCD_INC_MODE);
     Delay_us(20);
     send_word(LCD_DISP_ON);
     Delay_us(20);
     send_word(LCD_RETRN_HOME);
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
    send_word(0x80 | pos);
    Delay_ms(20);
}

void write_lcd(char c) {
    GPIOC_ODR = W_RAM;
    send_word(c);
    Delay_ms(2);
}

void write_string(char* c) {
      while(*c != '\0') {
              write_lcd(*c);
              c++;
     }
}

void clear_lcd() {
     START_COMMAND;
     send_word(LCD_CLEAR_DISPLAY);
}