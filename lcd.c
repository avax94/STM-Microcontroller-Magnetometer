#define S_DDRAM 0b001
#define W_RAM 1UL << RS_PIN
#define EN_SET GPIOx_ODR |= (1UL << E_PIN)
#define EN_R GPIOx_ODR &= ~(1UL << E_PIN)
#define START_COMMAND GPIOx_ODR = 0x0
#define setLow(x) GPIOx_ODR = (GPIOx_ODR & ~0xF) | x
#define sendBit(x, pos) GPIOx_ODR &= ~(1 << pos); \
                        GPIOx_ODR |= x << pos;
#define send_data(x)  EN_SET; \
                      sendBit((x & 1) >> 0, DATA4_PIN); \
                      sendBit((x & 2) >> 1, DATA5_PIN); \
                      sendBit((x & 4) >> 2, DATA6_PIN); \
                      sendBit((x & 8) >> 3, DATA7_PIN); \
                      EN_R;
#define send_word(x)  send_data(x >> 4); \
                      Delay_us (1); \
                      send_data(x & 0xF); \
                      Delay_us(1);

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

#define E_PIN     13
#define RS_PIN     4
#define DATA7_PIN  3
#define DATA6_PIN  2
#define DATA5_PIN  1
#define DATA4_PIN  0

#define GPIO(xx, yy) GPIOC_##yy

#define GPIOx_MODER GPIO(GPIOx, MODER)
#define GPIOx_OTYPER GPIO(GPIOx, OTYPER)
#define GPIOx_OSPEEDR GPIO(GPIOx, OSPEEDR)
#define GPIOx_PUPDR GPIO(GPIOx, PUPDR)
#define GPIOx_ODR GPIO(GPIOx, ODR)

void init_io() {
    // Enable GPIOC clock
    RCC_AHB1ENRbits.GPIOCEN = 1; //  |= ((1UL << 2) );
    RCC_AHB1LPENRbits.GPIOCLPEN = 1;
    //Configure E_PIN
    GPIOx_MODER &= ~(3UL << 2*E_PIN); //clear
    GPIOx_MODER |= 1UL << 2*E_PIN; //output mode
    GPIOx_OTYPER &= ~(3UL << E_PIN);
    GPIOx_OSPEEDR &= ~(3UL << 2*E_PIN); //clear
    GPIOx_OSPEEDR |= 3UL << 2*E_PIN;  //high speed
    GPIOx_PUPDR   &= ~(3UL << 2*E_PIN); //no pull

    // Configure RS_PIN
    GPIOx_MODER &= ~(3UL << 2*RS_PIN); //clear
    GPIOx_MODER |= 1UL << 2*RS_PIN; //output mode
    GPIOx_OTYPER &= ~(3UL << RS_PIN);
    GPIOx_OSPEEDR &= ~(3UL << 2*RS_PIN); //clear
    GPIOx_OSPEEDR |= 3UL << 2*RS_PIN;  //high speed
    GPIOx_PUPDR   &= ~(3UL << 2*RS_PIN); //no pull

    // Configure DATA7_PIN
    GPIOx_MODER &= ~(3UL << 2*DATA7_PIN); //clear
    GPIOx_MODER |= 1UL << 2*DATA7_PIN; //output mode
    GPIOx_OTYPER &= ~(3UL << DATA7_PIN);
    GPIOx_OSPEEDR &= ~(3UL << 2*DATA7_PIN); //clear
    GPIOx_OSPEEDR |= 3UL << 2*DATA7_PIN;  //high speed
    GPIOx_PUPDR   &= ~(3UL << 2*DATA7_PIN); //no pull

    // Configure DATA6_PIN
    GPIOx_MODER &= ~(3UL << 2*DATA6_PIN); //clear
    GPIOx_MODER |= 1UL << 2*DATA6_PIN; //output mode
    GPIOx_OTYPER &= ~(3UL << DATA6_PIN);
    GPIOx_OSPEEDR &= ~(3UL << 2*DATA6_PIN); //clear
    GPIOx_OSPEEDR |= 3UL << 2*DATA6_PIN;  //high speed
    GPIOx_PUPDR   &= ~(3UL << 2*DATA6_PIN); //no pull

    // Configure DATA5_PIN
    GPIOx_MODER &= ~(3UL << 2*DATA5_PIN); //clear
    GPIOx_MODER |= 1UL << 2*DATA5_PIN; //output mode
    GPIOx_OTYPER &= ~(3UL << DATA5_PIN);
    GPIOx_OSPEEDR &= ~(3UL << 2*DATA5_PIN); //clear
    GPIOx_OSPEEDR |= 3UL << 2*DATA5_PIN;  //high speed
    GPIOx_PUPDR   &= ~(3UL << 2*DATA5_PIN); //no pull

    // Configure DATA4_PIN
    GPIOx_MODER &= ~(3UL << 2*DATA4_PIN); //clear
    GPIOx_MODER |= 1UL << 2*DATA4_PIN; //output mode
    GPIOx_OTYPER &= ~(3UL << DATA4_PIN);
    GPIOx_OSPEEDR &= ~(3UL << 2*DATA4_PIN); //clear
    GPIOx_OSPEEDR |= 3UL << 2*DATA4_PIN;  //high speed
    GPIOx_PUPDR   &= ~(3UL << 2*DATA4_PIN); //no pull
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

    GPIOx_ODR = 0;
    send_word(0x80 | pos);
    Delay_ms(20);
}

void write_lcd(char c) {
    GPIOx_ODR = W_RAM;
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