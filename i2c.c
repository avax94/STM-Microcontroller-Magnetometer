#include "lcd.h"
#include "i2c.h"
#include "magnetometer.h"

volatile sbit ADDMODE_I2C at I2C2_OAR1.B15;
volatile sbit RxNE_I2C at I2C2_SR1.B6;
volatile sbit TxE_I2C at I2C2_SR1.B7;
volatile sbit ADDR_I2C at I2C2_SR1.B1;
int state_ = 0;
int cnt = 0;
char stt[5];
int dummy1, dummy2;
int transfer_count;
char* transfer;
int curr_transfer;
char lout[9];
char address;
int r_notw;
int enabl;
int should_start;
long int sreg;
void i2c_config();

int i2c_get_event() {
  long int sreg1 = I2C2_SR1;
  long int sreg2 = I2C2_SR2;
  sreg = (sreg2 << 16) | sreg1;
  if((sreg & STARTING_EV5) == STARTING_EV5) { //EV5
      return STARTING;
  } else if(I2C2_SR1bits.STOPF == 1) {
      return STOPING;
  } else if((sreg & ADDR_SENT_EV6) == ADDR_SENT_EV6) { //EV6
      return ADDRESS_SENT;
  } else if((sreg & TRANSMITTED_EV8) == TRANSMITTED_EV8) { //EV8
      return TRANSMITTED;
  } else if((sreg & RECEIVED_EV7) == RECEIVED_EV7) { //EV8
      return RECEIVED;
  } else {
      return DEFAULT;
  }
}

void set_ack() {
     ACKN = 1;
}

void clear_ack() {
     ACKN = 0;
}

void clear_start() {
     START_TR = 0;
}

void error_interrupt() iv  IVT_INT_I2C2_ER ics ICS_AUTO {
   DisableInterrupts();
   clear_lcd();
   set_position(0, 0);
   write_string("ERROR: ");
  if(I2C2_SR1bits.BERR == 1){
   write_string("BERR");
   EnableInterrupts();
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
  
  Delay_ms(1000);
  EnableInterrupts();
}

void i2c_start_() {
   NVIC_IntEnable(IVT_INT_I2C2_EV);
   START_TR = 1;
}

void i2c_stop_() {
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
     char result = (char)I2C2_DR;
     
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
        should_start = 0;
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

void i2c_init() {
//I2C2_Init_Advanced(400000, &_GPIO_MODULE_I2C2_PB10_11);
  const int maxRTime = 1000; //ns
  enabl = 1;
  should_start = 0;
  address = 0;
  //enable peripherial clock
  RCC_APB1ENRbits.I2C2EN = 1;
  i2c_config(); //config pins for i2c
  
  NVIC_IntEnable(IVT_INT_I2C2_EV); //set interrupts
  NVIC_IntEnable(IVT_INT_I2C2_ER); //set interrupts
  EnableInterrupts(); //enable interrupts
  //disable per to configure it
  I2C2_CR1bits.PE = 0;
  I2C2_CR2bits.FREQ = 40;

  //set a freq
  I2C2_CCRbits.F_S = 1;
  //set Thigh = 0.9 us = 900 ns and TLow = 1.8
  I2C2_CCRbits.CCR = 34;
  I2C2_TRISEbits.TRISE = I2C2_CR2bits.FREQ*1000 / maxRTime + 1;
  I2C2_CR1bits.PE = 1;
  NOSTRETCH_I2C = 0;
  I2C2_CR2bits.ITERREN = 1;
  ITBUFEN_I2C = 1;
  ITEVTEN_I2C = 1;
  I2C2_OAR1.B14 = 1;
  I2C2_OAR1bits.ADDMODE = 0;
}

 void i2c_config() {
   /* RCC Configuration */
   /*I2C Peripheral clock enable */
   /*SDA and SCL GPIO clock enable */
   RCC_AHB1ENRbits.GPIOBEN = 1;

   /* Reset I2Cx IP */
   RCC_APB1RSTRbits.I2C2RST = 1;
   /* Release reset signal of I2Cx IP */
   RCC_APB1RSTRbits.I2C2RST = 0;

   /* GPIO Configuration */
   /*Configure I2C SCL pin */
   GPIOB_OTYPERbits.OT10 = 1;
   GPIOB_MODERbits.MODER10 = 2; //alternate function
   GPIOB_PUPDRbits.PUPDR10 = 1;
   GPIOB_OSPEEDRbits.OSPEEDR10 = 1;
   GPIOB_AFRHbits.AFRH10 = 4; //i2c af
 
   GPIOB_OTYPERbits.OT11 = 1;
   GPIOB_MODERbits.MODER11 = 2; //alternate function
   GPIOB_PUPDRbits.PUPDR11 = 1;
   GPIOB_OSPEEDRbits.OSPEEDR11 = 1;
   GPIOB_AFRHbits.AFRH11 = 4; //i2c af
 }