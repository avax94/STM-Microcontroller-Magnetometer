#include "lcd.h"
#include "i2c.h"
#include "magnetometer.h"
#include "interrupts.h"

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
     I2C2_CR1 |= (1UL << 10);
}

void clear_ack() {
     I2C2_CR1 &= ~(1UL << 10);
}

void set_start() {
     I2C2_CR1 |= (1UL << 8);
}

void clear_start() {
     I2C2_CR1 &= ~(1UL << 8);
}

void set_stop() {
     I2C2_CR1 |= (1UL << 9);
}

void clear_stop() {
     I2C2_CR1 &= ~(1UL << 9);
}

int get_btf() {
    return (I2C2_SR1 >> 2) & 1;
}

void error_interrupt() iv  IVT_INT_I2C2_ER ics ICS_AUTO {
   disInterrupts();
   clear_lcd();
   set_position(0, 0);
   write_string("ERROR: ");
   
   if(((I2C2_SR1 >> 10) & 1) == 1) {
     write_string("AF");
   }
  
   if(((I2C2_SR1 >> 9) & 1) == 1) {
     write_string("ARLO");
   }
   
   if(((I2C2_SR1 >> 8) & 1) == 1) {
     write_string("BERR");
   }

   if(((I2C2_SR1 >> 11) & 1) == 1) {
     write_string("OVR");
   }
  
   if(((I2C2_SR1 >> 12) & 1) == 1){
     write_string("PECERR");
   }
  
   if(((I2C2_SR1 >> 14) & 1) == 1){
     write_string("TIMEOUT");
   }
  
   if(((I2C2_SR1 >> 15) & 1) == 1){
     write_string("SMBALERT");
   }
   
   Delay_ms(1000);
   enInterrupts();
}

void i2c_start_() {
   nvicEnable(IVT_INT_I2C2_EV);
   set_start();
}

void i2c_stop_() {
     set_stop();
}

void i2c_send_addr(char addr, int r_w) {
     I2C2_DR = addr << 1 | r_w;
     address = 0;
}

void i2c_send(char d) {
     I2C2_DR = (unsigned long) d;
}

char i2c_recv() {
     char result = (char)I2C2_DR;
     
     return result;
}

void i2c_start_async() {
     should_start = 1; //set start flag
}

//send slave addr
void i2c_send_addr_async(char addr, int r_w) {
     address = addr; // remember slave address for sending later
     r_notw = r_w; // remember r_w flag
}

int i2c_send_async(char* d, int num) {
     transfer = d;
     transfer_count = num;
     
     if(should_start == 1 &&
        address != 0) { // really start if start_async and send_addr_async are called before
        should_start = 0;
        i2c_start_();
        return 0;
     } else { // return error flag
        return 1;
     }
}

int i2c_recv_async(char* d, int num) {
     transfer = d;
     transfer_count = num;

     if(should_start == 1 &&
        address != 0) { // really start if start_async and send_addr_async are called before
        should_start = 0;
        i2c_start_();
        return 0;
     } else { // return error flag
        return 1;
     }
}

void i2c_init() {
  const int maxRTime = 1000; //ns
  const int freq = 40;
  enabl = 1;
  should_start = 0;
  address = 0;
  RCC_APB1ENR |= 1UL << 22; // enable peripherial clock
  i2c_config(); // config pins for i2c
  
  I2C2_CR1 &= ~(1UL << 0); // PE (PeripherEnable) = 0 disable per to configure it
  
  I2C2_CR2 &= ~((1UL << 6) - 1); //clear lowest 6 bits
  I2C2_CR2 |= freq; //FREQ = 40Mhz
  //set a freq
  I2C2_CCR |= 1UL << 15;
  I2C2_CCR &= ~((1UL << 12) - 1);
  I2C2_CCR |= 34; //Clock Control - value calculated according to documentation
  I2C2_TRISE = freq*maxRTime / maxRTime + 1;
  
  I2C2_CR1 |= 1UL << 0; // PE (PeripherEnable) = 1 enable per to configure it
  
  I2C2_CR1 &= ~(1UL << 7); //NOSTRETCH = 0
  I2C2_CR2 |= 0x7UL << 8; //ITBUFEN, ITEVTEN, ITERREN - Enable interrupts for error and event
  I2C2_OAR1 |= 1UL << 14; //must be kept at 1 value (documenatation)
  I2C2_OAR1 &= ~(1UL << 15); //ADDMODE = 0 (7bits slave address)
  
  nvicEnable(IVT_INT_I2C2_EV); // set interrupts
  nvicEnable(IVT_INT_I2C2_ER); // set interrupts
}

 void i2c_config() {
    /* RCC Configuration */
    /*I2C Peripheral clock enable */
    /*SDA and SCL GPIO clock enable */
    RCC_AHB1ENR |= 1UL << 1; //GPIOBEN = 1

    /* Reset I2Cx IP */
    RCC_APB1RSTR |= 1UL << 22; //I2C2RST = 1;
    /* Release reset signal of I2Cx IP */
    RCC_APB1RSTR &= ~1UL << 22; //I2C2RST = 0;

    /* GPIO Configuration */
    /*Configure I2C SCL and SDA pins (B10, B11) pin */
    // clear then set to ALTERNATE FUNCTION MODE (10b)
    GPIOB_MODER &= ~(3UL << 2*10);
    GPIOB_MODER &= ~(3UL << 2*11);
    GPIOB_MODER |= 2UL << 2*10;
    GPIOB_MODER |= 2UL << 2*11;

    //Set otyper bits (Open drain)
    GPIOB_OTYPER |= 1UL << 10;
    GPIOB_OTYPER |= 1UL << 11;

    // Clear bits OSEED register than set to medium speed
    GPIOB_OSPEEDR &= ~(3UL << 2*10);
    GPIOB_OSPEEDR &= ~(3UL << 2*11);
    GPIOB_OSPEEDR |= 1UL << 2*10;
    GPIOB_OSPEEDR |= 1UL << 2*11;

    // Clear bits PUPD registar than set to PullUp
    GPIOB_PUPDR &= ~(3UL << 2*10);
    GPIOB_PUPDR &= ~(3UL << 2*11);
    GPIOB_PUPDR |= 1UL << 2*11;
    GPIOB_PUPDR |= 1UL << 2*10;

    //Clear AFRH bits and set AF to i2c
    GPIOB_AFRH &= ~(0xFUL << 4*2); // 10 - 8 = 2
    GPIOB_AFRH &= ~(0xFUL << 4*3); // 11 - 8 = 3
    GPIOB_AFRH |= 4UL << 4*2;
    GPIOB_AFRH |= 4UL << 4*3;
 }