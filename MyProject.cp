#line 1 "G:/Projects/MIPS/P1/MyProject.c"
#line 1 "g:/projects/mips/p1/lcd.h"



void clear_lcd();
void write_string(char* c);
void write_lcd(char c);
void set_position(char x, char y);
void init_lcd();
#line 1 "g:/projects/mips/p1/i2c.h"



void i2c_start_();
void i2c_stop();
void i2c_send_addr(char addr, int r_w);
void i2c_send(char d);
char i2c_recv();
void i2c_start_async();
void i2c_send_addr_async(char addr, int r_w);
int i2c_send_async(char* d, int num);
int i2c_recv_async(char* d, int num);
void i2c_init();
void i2c_config();
void i2c_stop();
extern int state_;
#line 3 "G:/Projects/MIPS/P1/MyProject.c"
void init_io() {

 RCC_AHB1ENRbits.GPIOCEN = 1;


 GPIOC_MODER &= ~((3UL << 2*13));
 GPIOC_MODER &= ~((3UL << 2*4));
 GPIOC_MODER &= ~((3UL << 2*3));
 GPIOC_MODER &= ~((3UL << 2*2));
 GPIOC_MODER &= ~((3UL << 2*1));
 GPIOC_MODER &= ~((3UL << 2*0));


 GPIOC_MODER |= ((1UL << 2*13));
 GPIOC_MODER |= ((1UL << 2*4));
 GPIOC_MODER |= ((1UL << 2*3));
 GPIOC_MODER |= ((1UL << 2*2));
 GPIOC_MODER |= ((1UL << 2*1));
 GPIOC_MODER |= ((1UL << 2*0));
#line 33 "G:/Projects/MIPS/P1/MyProject.c"
 GPIOC_OTYPER &= ~((3UL << 13));
 GPIOC_OTYPER &= ~((3UL << 4));
 GPIOC_OTYPER &= ~((3UL << 3));
 GPIOC_OTYPER &= ~((3UL << 2));
 GPIOC_OTYPER &= ~((3UL << 1));
 GPIOC_OTYPER &= ~((3UL << 0));


 GPIOC_OSPEEDR &= ~((3UL << 2*13));
 GPIOC_OSPEEDR &= ~((3UL << 2*4));
 GPIOC_OSPEEDR &= ~((3UL << 2*3));
 GPIOC_OSPEEDR &= ~((3UL << 2*2));
 GPIOC_OSPEEDR &= ~((3UL << 2*1));
 GPIOC_OSPEEDR &= ~((3UL << 2*0));


 GPIOC_OSPEEDR |= ((3UL << 2*13));
 GPIOC_OSPEEDR |= ((3UL << 2*4));
 GPIOC_OSPEEDR |= ((3UL << 2*3));
 GPIOC_OSPEEDR |= ((3UL << 2*2));
 GPIOC_OSPEEDR |= ((3UL << 2*1));
 GPIOC_OSPEEDR |= ((3UL << 2*0));


 GPIOC_PUPDR &= ~((3UL << 2*13));
 GPIOC_PUPDR &= ~((3UL << 2*4));
 GPIOC_PUPDR &= ~((3UL << 2*3));
 GPIOC_PUPDR &= ~((3UL << 2*2));
 GPIOC_PUPDR &= ~((3UL << 2*1));
 GPIOC_PUPDR &= ~((3UL << 2*0));
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



 IntToHex(result, st);
 clear_lcd();
 set_position(0, 0);
 write_string(st);
}


void main() {
 init_io();
 init_lcd();
 i2c_init();
 read_who_am_i2();
 GPIOC_ODR = 0;
 Delay_ms(5000);
 while(1) {}
}
