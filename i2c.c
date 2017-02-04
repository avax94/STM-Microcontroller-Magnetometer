#include "lcd.h"
#include "i2c.h"
#define ACKN I2C2_CR1bits.ACK
#define START_TR I2C2_CR1bits.START
#define STOP I2C2_CR1bits.STOP_
#define NOSTRETCH_I2C I2C2_CR1bits.NOSTRETCH
#define ITBUFEN_I2C I2C2_CR2bits.ITBUFEN
#define ITEVTEN_I2C I2C2_CR2bits.ITEVTEN

#define BUSY I2C2_SR2bits.BUSY
#define MSL I2C2_SR2bits.MSL
#define TRA I2C2_SR2bits.TRA
#define SB I2C2_SR1bits.SB

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
  if(SB == 1 &&
     BUSY == 1 &&
     MSL == 1) { //EV5
      return STARTING;
  } else if(I2C2_SR1bits.STOPF == 1) {
      return STOPING;
  } else if(
          ADDR_I2C == 1
          ) { //EV6
      return ADDRESS_SENT;
  } else if(TRA == 1 &&
            BUSY == 1 &&
            MSL == 1 &&
            TxE_I2C == 1) { //EV8
      return TRANSMITTED;
  } else if(BUSY == 1 &&
            MSL == 1 &&
            RxNE_I2C) {
      return RECEIVED;
  } else {
      return DEFAULT;
  }
}
void interrupt() iv  IVT_INT_I2C2_EV ics ICS_AUTO {
    DisableInterrupts();

    switch(i2c_get_event()) {
    case STARTING:
         state_ = 1;
         ACKN = 1;
         i2c_send_addr(address, r_notw);
         START_TR = 0;
         break;
    case ADDRESS_SENT:
          state_ = 2;
     
         if(transfer_count == 1) {
            ACKN = 0;
         } else {
            ACKN = 1;
         }

         dummy1 = I2C2_SR1;
         dummy2 = I2C2_SR2;

         cnt = cnt + 1;
         curr_transfer = 0;
         break;
    case TRANSMITTED:

         if(curr_transfer != transfer_count) { //transmiter

              i2c_send(transfer[curr_transfer]);
              state_ = 3;
              if (curr_transfer != transfer_count)
                  curr_transfer = curr_transfer +  1;
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
               ACKN = 0;
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

void interrupt2() iv  IVT_INT_I2C2_ER ics ICS_AUTO {
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
   START_TR = 1;
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

/*void i2c_transaction(char* d, int size, char addr, int r_w) {
    char res[2];
     transfer = d;
     transfer_count = size;
     address = addr;
     r_notw = r_w;
      /*   if(I2C2_Start() != 0) {
         clear_lcd();
         set_position(0, 0);
         write_string("START FAIL");
      }
       enabl = I2C2_Write(0x0D, res, 2, END_MODE_);          // write num_bytes, stored in data_, and issue a stop condition.
        if(enabl != 0)
        {
         clear_lcd();
         set_position(0, 0);
         write_string("IPAK ERROR");
        }           else {
        clear_lcd();
         set_position(0, 0);
         write_string("ALL GOOD");

        }      */ /*
    address = 0x0E << 1;
    ACKN = 0;
    START_TR = 1;  clear_lcd();

     while(I2C2_SR1bits.SB == 0);
     ACKN = 1;
       I2C2_DR = address;

     clear_lcd();
     set_position(0,0);
     write_string("Startovao sam!");
     while(I2C2_SR1bits.ADDR == 0);
     clear_lcd();
     set_position(0,0);
     write_string("ADDR je 0");
     I2C2_SR1.B0;
     I2C2_SR2.B0;

     while(I2C2_SR1bits.TxE == 0);
     clear_lcd();
     set_position(0,0);
     write_string("BTF se setuje");
}

void i2c_send(char* d, int size, char addr) {
     i2c_transaction(d, size, addr, 0);
}

void i2c_recv(char* d, int size, char addr) {
     i2c_transaction(d, size, addr, 1);
}
*/
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
   GPIOB_OSPEEDRbits.OSPEEDR10 = 1;
   GPIOB_AFRHbits.AFRH11 = 4; //i2c af
 }