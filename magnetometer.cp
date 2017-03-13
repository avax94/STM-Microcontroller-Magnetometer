#line 1 "G:/Projects/MIPS/P1/magnetometer.c"
#line 1 "g:/projects/mips/p1/lcd.h"



void clear_lcd();
void write_string(char* c);
void write_lcd(char c);
void set_position(char x, char y);
void init_lcd();
#line 1 "g:/projects/mips/p1/i2c.h"
#line 23 "g:/projects/mips/p1/i2c.h"
void i2c_start_();
void i2c_stop_();
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
void set_ack();
void clear_start();
void clear_ack();
int i2c_get_event();

enum states {STARTING, ADDRESS_SENT, RECEIVED, TRANSMITTED, STOPING, DEFAULT} ;

extern volatile sbit ADDMODE_I2C;
extern volatile sbit RxNE_I2C;
extern volatile sbit TxE_I2C;
extern volatile sbit ADDR_I2C;

extern volatile sbit TRA_I2C;

extern int state_;
extern int cnt;
extern char stt[];
extern int dummy1, dummy2;
extern int transfer_count;
extern char* transfer;
extern int curr_transfer;
extern char address;
extern char reg_addr;
extern int r_notw;
extern int enabl;
extern int should_start;
extern long int sreg;

extern int state_;
#line 23 "G:/Projects/MIPS/P1/magnetometer.c"
int reg_send = 0;
int is_configured = 0;
int counter = 0;
int called = 0;
char reg_addr;
char xyz[6];
char output[10];
int reading_xyz = 0;
int stop_generated = 0;

void debug(char* d) {
 clear_lcd();
 set_position(0,0);
 write_string(d);
}

void calcAngle(char *xyz) {
 char output[5];
 float heading;
 float declAngle = 0.069;
 int x;
 int y;
 float headingD;
 int angle;
 x = (((int)xyz[0]) << 8) | xyz[1];
 y = (((int)xyz[2]) << 8) | xyz[3];
 y -= (int)((0x0000029A + 0x00000438) >> 1);
 x -= (int)((0x0000FD00 + 0x0000FB4F) >> 1);
 heading = atan2(y, x);
 heading = heading - declAngle;

 if(heading < 0) heading += 2*3.14;


 if(heading > 2*3.14)heading -= 2*3.14;

 headingD = heading * 180 / 3.14;
 angle = (int)headingD;
 if(angle > 180) {
 angle = angle - 360;
 }
 IntToStr(angle, output);
 debug(Ltrim(output));
}

void event_handler() iv IVT_INT_I2C2_EV ics ICS_AUTO {
 DisableInterrupts();
 switch(i2c_get_event()) {
 case STARTING:
 state_ = 1;
  I2C2_CR1bits.ACK  = 1;

 if(reg_send == 0) {
 I2C2_DR = address << 1 | 0;
 }
 else {
 i2c_send_addr(address, r_notw);
 }


  I2C2_CR1bits.START  = 0;

 break;
 case ADDRESS_SENT:
 state_ = 2;


 dummy1 = I2C2_SR1;
 dummy2 = I2C2_SR2;

 curr_transfer = 0;
 break;
 case TRANSMITTED:
 state_ = 3;
 if(reg_send == 1) {
 if(curr_transfer != transfer_count) {
 i2c_send(transfer[curr_transfer]);
 curr_transfer = curr_transfer + 1;
 } else if( I2C2_SR1bits.BTF  == 1) {
 i2c_stop_();
 }
 } else {
 if(curr_transfer == 0) {
 i2c_send(reg_addr);
 curr_transfer = curr_transfer + 1;
 } else if( I2C2_SR1bits.BTF  == 1) {
 reg_send = 1;
 curr_transfer = 0;
 if(r_notw == 1)
 i2c_start_();
 }
 }
 break;
 case RECEIVED:
 if(curr_transfer != transfer_count) {


 transfer[curr_transfer] = i2c_recv();
 curr_transfer = curr_transfer + 1;

 if(curr_transfer == transfer_count) {
  I2C2_CR1bits.ACK  = 0;
 i2c_stop_();
 state_ = 6;
 }

 state_ = 5;

 if(curr_transfer == transfer_count) {
 if(reading_xyz == 1) {
 reading_xyz = 0;
 calcAngle(transfer);
 }
 }
 } else {
 i2c_recv();
 }
 break;
 case STOPING:
 if(I2C2_SR1bits.STOPF == 1)
 I2C2_CR1bits.STOP_ = 0;
 break;
 case DEFAULT:
 break;
 }

 EnableInterrupts();
}

void send_reg_addr_async(char reg_a) {
 reg_send = 0;
 reg_addr = reg_a;
}

void read_who_am_i() {
 char result = 0;
 char st[5];
 cnt = 0;
 EnableInterrupts();
 debug("Uso sam ovde...");
 Delay_ms(1000);
 i2c_start_async();
 send_reg_addr_async( 0x07 );
 i2c_send_addr_async(0x0E, 1);
 i2c_recv_async(&result, 1);
 Delay_ms(3000);
 debug("RES: ");
 IntToHex(result, st);
 write_string(st);
}

void read_reg(char reg, char* d, int cnt) {
 i2c_start_async();
 send_reg_addr_async(reg);
 i2c_send_addr_async(0x0E, 1);
 i2c_recv_async(d, cnt);
}

void write_reg(char reg, char* d, int cnt) {
 i2c_start_async();
 send_reg_addr_async(reg);
 i2c_send_addr_async(0x0E, 0);
 i2c_send_async(d, cnt);
}

int read_xyz(char *d) {
 int dreg = 1;
 int bitt = 0;

 read_reg( 0x00 , &dreg, 1);
 Delay_ms(2);
 bitt = dreg >> 3 & 1;
 if(bitt != 0) {
 read_reg( 0x01 , d, 6);
 Delay_ms(2);
 }

 return bitt;
}

void configure_exti() {
 char xyz[6];
 RCC_APB2ENRbits.SYSCFGEN = 1;
 RCC_AHB1ENRbits.GPIOEEN = 1;
 GPIOE_MODERbits.MODER10 = 0;
 GPIOE_PUPDRbits.PUPDR10 = 0x1;
 GPIOE_OTYPERbits.OT10 = 0x0;
 GPIOE_OSPEEDRbits.OSPEEDR10 = 0x2;


 SYSCFG_EXTICR3bits.EXTI10 = 0x4;
 EXTI_FTSR = 0x00000000;
 EXTI_RTSR = 0x00000400;
 EXTI_IMR |= 0x00000400;
 NVIC_IntEnable(IVT_INT_EXTI15_10);
 EnableInterrupts();

 read_xyz(xyz);
 }



void init_magnetometer() {
 char creg1 = 0b10001001;
 char creg2 = 0b10100000;
 char c1;
 char c2;
 char o[5];

 write_reg( 0x10 , &creg1, 1);
 Delay_us(500);
 write_reg( 0x11 , &creg2, 1);
 Delay_us(500);
 is_configured = 1;
 configure_exti();

 }
 void interrupt_handle() iv IVT_INT_EXTI15_10 ics ICS_AUTO {
 if(is_configured == 0) {
 return;
 }

 EXTI_PR.B10 = 1;
 reading_xyz = 1;
 read_reg( 0x01 , xyz, 6);
 }

 void printToLCD(char *d) {
 write_lcd(d[2]);
 write_lcd(d[3]);
 }
void dealwithit() {
 char xyz[6];
 char output[5];
 float heading;
 float declAngle = 0.069;
 int x;
 int y;
 float headingD;
 int angle;

 xyz[0] = xyz[1] = xyz[2] = xyz[3] = xyz[4] = xyz[5] = 0;

 Delay_ms(2);

x = (((int)xyz[0]) << 8) | xyz[1];
 y = (((int)xyz[2]) << 8) | xyz[3];

 y -= (int)((0x0000029A + 0x00000438) >> 1);
 x -= (int)((0x0000FD00 + 0x0000FB4F) >> 1);







 heading = atan2(y, x);
 heading = heading - declAngle;


 if(heading < 0) heading += 2*3.14;
 if(heading < 0) heading += 2*3.14;

 if(heading > 2*3.14)heading -= 2*3.14;
 headingD = heading * 180 / 3.14;
 angle = (int)headingD;

 IntToStr(angle, output);
 clear_lcd();
 set_position(0, 0);
 write_string(Ltrim(output));
}
void poll_value() {
 int dreg;
 char xyz[6];
 char output[5];
 int bitt;
 while(1) {
 dreg = 1;
 read_reg( 0x00 , &dreg, 1);
 Delay_ms(2);
 IntToHex(dreg, output);

 bitt = dreg >> 3 & 1;
 if(bitt != 0) {
 dealwithit();
 Delay_ms(250);
 }


 }
}

void test_rd_write() {
 char xyz[6], rd = 3;
 char o[5];
 char creg1 = 0b10001001;
 write_reg( 0x10 , &creg1, 1);
 Delay_ms(1000);
 creg1 = 0x00;
 read_reg( 0x10 , &creg1, 1);
 Delay_ms(2000);
 IntToHex(creg1, xyz);
 debug(xyz);

}
