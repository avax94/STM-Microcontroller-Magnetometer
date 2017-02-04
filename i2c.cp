#line 1 "G:/Projects/MIPS/P1/i2c.c"
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
#line 15 "G:/Projects/MIPS/P1/i2c.c"
volatile sbit ADDMODE_I2C at I2C2_OAR1.B15;
volatile sbit RxNE_I2C at I2C2_SR1.B6;
volatile sbit TxE_I2C at I2C2_SR1.B7;
volatile sbit BTF_I2C at I2C2_SR1.B2;
volatile sbit ADDR_I2C at I2C2_SR1.B1;

volatile sbit TRA_I2C at I2C2_SR2.B2;
int state_ = 0;
int cnt = 0;
char stt[5];
int dummy1, dummy2;
int transfer_count;
char* transfer;
int curr_transfer;
char address;
char reg_addr;
int r_notw;
int enabl;
int should_start;
void i2c_config();
enum {STARTING, ADDRESS_SENT, RECEIVED, TRANSMITTED, STOPING, DEFAULT} states;
int i2c_get_event() {
 if( I2C2_SR1bits.SB  == 1 &&
  I2C2_SR2bits.BUSY  == 1 &&
  I2C2_SR2bits.MSL  == 1) {
 return STARTING;
 } else if(I2C2_SR1bits.STOPF == 1) {
 return STOPING;
 } else if(
 ADDR_I2C == 1
 ) {
 return ADDRESS_SENT;
 } else if( I2C2_SR2bits.TRA  == 1 &&
  I2C2_SR2bits.BUSY  == 1 &&
  I2C2_SR2bits.MSL  == 1 &&
 TxE_I2C == 1) {
 return TRANSMITTED;
 } else if( I2C2_SR2bits.BUSY  == 1 &&
  I2C2_SR2bits.MSL  == 1 &&
 RxNE_I2C) {
 return RECEIVED;
 } else {
 return DEFAULT;
 }
}
void interrupt() iv IVT_INT_I2C2_EV ics ICS_AUTO {
 DisableInterrupts();

 switch(i2c_get_event()) {
 case STARTING:
 state_ = 1;
  I2C2_CR1bits.ACK  = 1;
 i2c_send_addr(address, r_notw);
  I2C2_CR1bits.START  = 0;
 break;
 case ADDRESS_SENT:
 state_ = 2;

 if(transfer_count == 1) {
  I2C2_CR1bits.ACK  = 0;
 } else {
  I2C2_CR1bits.ACK  = 1;
 }

 dummy1 = I2C2_SR1;
 dummy2 = I2C2_SR2;

 cnt = cnt + 1;
 curr_transfer = 0;
 break;
 case TRANSMITTED:

 if(curr_transfer != transfer_count) {

 i2c_send(transfer[curr_transfer]);
 state_ = 3;
 if (curr_transfer != transfer_count)
 curr_transfer = curr_transfer + 1;
 } else {
 i2c_stop();
 }
 case RECEIVED:

 if(curr_transfer != transfer_count) {
 transfer[curr_transfer] = i2c_recv();
 curr_transfer = curr_transfer + 1;
 state_ = 5;

 if(curr_transfer+1 == transfer_count || curr_transfer == transfer_count) {
 enabl = 0;
  I2C2_CR1bits.ACK  = 0;
 i2c_stop();
 state_ = 6;
 }
 } else {
 i2c_stop();
 }

 break;
 case STOPING:
 if(I2C2_SR1bits.STOPF == 1)
 I2C2_CR1bits.STOP_ = 0;
 break;
 case DEFAULT:
 break;
 }
 if(enabl == 1)
 EnableInterrupts();
}

void interrupt2() iv IVT_INT_I2C2_ER ics ICS_AUTO {
 DisableInterrupts();

 clear_lcd();
 set_position(0,0);

 write_string("AVAX");

 if(I2C2_SR1bits.BERR == 1){
 write_string("BERR");
 }

 if(I2C2_SR1bits.AF == 1){
 write_string("AF");
 }

 if(I2C2_SR1bits.ARLO == 1){
 write_string("ARLO");
 }

 if(I2C2_SR1bits.OVR == 1){
 write_string("OVR");
 }

 if(I2C2_SR1bits.PECERR == 1){
 write_string("PECERR");
 }

 if(I2C2_SR1bits.TIMEOUT == 1){
 write_string("TIMEOUT");
 }

 if(I2C2_SR1bits.SMBALERT == 1){
 write_string("SMBALERT");
 }
}

void i2c_start_() {
 NVIC_IntEnable(IVT_INT_I2C2_EV);
  I2C2_CR1bits.START  = 1;
}

void i2c_stop() {
 I2C2_CR1bits.STOP_ = 1;
}

void i2c_send_addr(char addr, int r_w) {
 I2C2_DR = addr << 1 | r_w;
 address = 0;
}

void i2c_send(char d) {
 I2C2_DRbits.DR = d;
}

char i2c_recv() {
 char result = I2C2_DRbits.DR;

 return result;
}

void i2c_start_async() {
 should_start = 1;
}

void i2c_send_addr_async(char addr, int r_w) {
 address = addr;
 r_notw = r_w;
}

int i2c_send_async(char* d, int num) {
 transfer = d;
 transfer_count = num;

 if(should_start == 1 &&
 address != 0) {
 i2c_start_();
 return 0;
 } else {
 return 1;
 }
}

int i2c_recv_async(char* d, int num) {
 transfer = d;
 transfer_count = num;

 if(should_start == 1 &&
 address != 0) {
 should_start = 0;
 i2c_start_();
 return 0;
 } else {
 return 1;
 }
}
#line 277 "G:/Projects/MIPS/P1/i2c.c"
void i2c_init() {

 const int maxRTime = 1000;
 enabl = 1;
 should_start = 0;
 address = 0;

 RCC_APB1ENRbits.I2C2EN = 1;
 i2c_config();

 NVIC_IntEnable(IVT_INT_I2C2_EV);

 NVIC_IntEnable(IVT_INT_I2C2_ER);
 EnableInterrupts();

 I2C2_CR1bits.PE = 0;
 I2C2_CR2bits.FREQ = 40;


 I2C2_CCRbits.F_S = 1;

 I2C2_CCRbits.CCR = 34;
 I2C2_TRISEbits.TRISE = I2C2_CR2bits.FREQ*1000 / maxRTime + 1;
 I2C2_CR1bits.PE = 1;
  I2C2_CR1bits.NOSTRETCH  = 0;
 I2C2_CR2bits.ITERREN = 1;
  I2C2_CR2bits.ITBUFEN  = 1;
  I2C2_CR2bits.ITEVTEN  = 1;
 I2C2_OAR1.B14 = 1;
 I2C2_OAR1bits.ADDMODE = 0;
}

 void i2c_config() {



 RCC_AHB1ENRbits.GPIOBEN = 1;


 RCC_APB1RSTRbits.I2C2RST = 1;

 RCC_APB1RSTRbits.I2C2RST = 0;



 GPIOB_OTYPERbits.OT10 = 1;
 GPIOB_MODERbits.MODER10 = 2;
 GPIOB_PUPDRbits.PUPDR10 = 1;
 GPIOB_OSPEEDRbits.OSPEEDR10 = 1;
 GPIOB_AFRHbits.AFRH10 = 4;

 GPIOB_OTYPERbits.OT11 = 1;
 GPIOB_MODERbits.MODER11 = 2;
 GPIOB_PUPDRbits.PUPDR11 = 1;
 GPIOB_OSPEEDRbits.OSPEEDR10 = 1;
 GPIOB_AFRHbits.AFRH11 = 4;
 }
