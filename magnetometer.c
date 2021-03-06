#define DR_STATUS_ADDR 0x00
#define OUT_X_MSB_ADDR 0x01
#define OUT_X_LSB_ADDR 0x02
#define OUT_Y_MSB_ADDR 0x03
#define OUT_Y_LSB_ADDR 0x04
#define OUT_Z_MSB_ADDR 0x05
#define OUT_Z_LSB_ADDR 0x06
#define WHO_AM_I_ADDR  0x07
#define SYS_MOD_ADDR   0x08
#define OFF_X_MSB_ADDR 0x09
#define OFF_X_LSB_ADDR 0x0A
#define OFF_Y_MSB_ADDR 0x0B
#define OFF_Y_LSB_ADDR 0x0C
#define OUT_Z_MSB_ADDR 0x0D
#define OFF_Z_LSB_ADDR 0x0E
#define DIE_TEMP_ADDR  0x0F
#define CTRL_REG1_ADDR 0x10
#define CTRL_REG2_ADDR 0x11
#define SENSOR_ADDR    0xC4
#include "lcd.h"
#include "i2c.h"
#include "interrupts.h"

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
     
     //substract offset
     y -= (int)((0x00000264 + 0x000003FE) >> 1);
     x -= (int)((0x0000FD05 + 0x0000FB89) >> 1);
     heading = atan2(y, x);
     heading = heading - declAngle;
     
     if(heading < 0)   heading += 2*3.14;
     
     // Check for wrap due to addition of declination.
     if(heading > 2*3.14)heading -= 2*3.14;
     
     headingD = heading * 180 / 3.14;
     angle = (int)headingD;
     if(angle > 180) {
        angle = angle - 360;
     }
     
     //print to LCD
     IntToStr(angle, output);
     debug(Ltrim(output));
}

void event_handler() iv  IVT_INT_I2C2_EV ics ICS_AUTO {
    disInterrupts();
    switch(i2c_get_event()) {
    case STARTING:
         set_ack();
         
         if(reg_send == 0) { //if we are in register address sending state
             I2C2_DR = address << 1 | 0;
         }
         else {
             i2c_send_addr(address, r_notw); //if we already sent register address we now do read or write
         }

         clear_start();
         break;
    case ADDRESS_SENT:
         dummy1 = I2C2_SR1; //need to read sr1 followed by read sr2 so we clean flags
         dummy2 = I2C2_SR2;

         curr_transfer = 0;
         break;
    case TRANSMITTED:
         if(reg_send == 1) {
             if(curr_transfer != transfer_count) { //transmiter
                 i2c_send(transfer[curr_transfer]);
                 curr_transfer = curr_transfer +  1;
              } else if(get_btf() == 1) { //STOP when BTF is set
                    i2c_stop_();
              }
         } else {
            if(curr_transfer == 0) {
               i2c_send(reg_addr);
               curr_transfer = curr_transfer + 1;
            } else if(get_btf() == 1) { //take action when BTF
               reg_send = 1;
               curr_transfer = 0;
               
               if(r_notw == 1) //repetead start if RD is desired action
                   i2c_start_();
            }
         }
         break;
    case RECEIVED:
         if(curr_transfer != transfer_count) {
             transfer[curr_transfer] = i2c_recv();
             curr_transfer = curr_transfer + 1;

             if(curr_transfer == transfer_count) {
                 clear_ack(); //send NACK
                 i2c_stop_(); //stop communication
                 state_ = 5;
             }

             if(curr_transfer == transfer_count) {
                 if(reading_xyz == 1) { //STATE: reading magnetometer data
                     reading_xyz = 0;
                     calcAngle(transfer);
                 }
             }
         }  else  {
            i2c_recv();
         }
         break;
    case DEFAULT:
        break;
    }
    enInterrupts();
}

//send MAG3110 reg addr
void send_reg_addr_async(char reg_a) {
     reg_send = 0;
     reg_addr = reg_a;
}

//used for debugging
void read_who_am_i() {
    char result = 0;
    char st[5];
    cnt = 0;
    debug("Entered...");
    Delay_ms(1000);
    i2c_start_async();
    send_reg_addr_async(WHO_AM_I_ADDR);
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

//sync reading magnet data
int read_xyz(char *d) {
     int dreg = 1;
     int bitt = 0;

     read_reg(DR_STATUS_ADDR, &dreg, 1);
     Delay_ms(2);
     bitt = dreg >> 3 & 1;
     if(bitt != 0) {
       read_reg(OUT_X_MSB_ADDR, d, 6);
       Delay_ms(2);
     }

     return bitt;
}

void configure_exti() {
     char xyz[6];
     RCC_APB2ENR |= 1UL << 14; // SYSCFGEN = 1; enable syscfg periph
     RCC_AHB1ENR |= 1UL << 4; // GPIOEEN = 1; enable PE clock

     /* configure GPIO pin */
     //set PE10 as input
     GPIOE_MODER &= ~(3UL << 2*10);
     //Set otyper bits (Open drain)
     GPIOE_OTYPER &= ~(1UL << 10);
     // Clear bits OSEED register than set speed
     GPIOE_OSPEEDR &= ~((3UL << 2*10));
     GPIOE_OSPEEDR |= (2UL << 2*10);
     // Clear bits PUPD registar than set to PullUp
     GPIOE_PUPDR &= ~((3UL << 2*10));
     GPIOE_PUPDR |= ((1UL << 2*10));
     /*GPIOE_MODERbits.MODER10 = 0; //set PE10 as input
     GPIOE_PUPDRbits.PUPDR10 = 0x1; //pullup
     GPIOE_OTYPERbits.OT10 = 0x0;
     GPIOE_OSPEEDRbits.OSPEEDR10 = 0x2;*/
     SYSCFG_EXTICR3 &= ~(0xF << 2*4);
     SYSCFG_EXTICR3 |= 0x4 << 2*4; //set PE10 to be EXTI pin
     EXTI_FTSR = 0x00000000;
     EXTI_RTSR = 0x00000400; //detect rising edge
     EXTI_IMR |= 0x00000400; //unmask bit
     nvicEnable(IVT_INT_EXTI15_10);

     read_xyz(xyz); //we need to read xyz to clear INT1 bit because if its set we won't be able to detect rising edge
}

void init_magnetometer() {
     char creg1 = 0b10001001; //ACTIVE, 2.5Hz, 32 Sample Ratio
     char creg2 = 0b10100000; //AutoReset, RAW
     char c1;
     char c2;
     char o[5];

     write_reg(CTRL_REG1_ADDR, &creg1, 1);
     Delay_us(500);
     write_reg(CTRL_REG2_ADDR, &creg2, 1);
     Delay_us(500);
     is_configured = 1;
     configure_exti();
}

void interrupt_handle() iv IVT_INT_EXTI15_10 ics ICS_AUTO {
  if(is_configured == 0) {
     return;
   }
   
   EXTI_PR = 1 << 10; // clear interrupt flag
   reading_xyz = 1; // enter STATE: reading magnetometer data
   read_reg(OUT_X_MSB_ADDR, xyz, 6); //read data
}

void printToLCD(char *d) {
   write_lcd(d[2]);
   write_lcd(d[3]);
}

//sync polling magnetometer data
void poll_value() {
     int dreg;
     char xyz[6];
     char output[5];
     int bitt;
     while(1) {
       dreg = 1;
       read_reg(DR_STATUS_ADDR, &dreg, 1);
       Delay_ms(2);
       bitt = dreg >> 3 & 1;
       if(bitt != 0) {
          calcAngle(xyz);
          Delay_ms(250);
       }
     }
}

//unit test for i2c rd and write
void test_rd_write() {
     char xyz[6], rd = 3;
     char o[5];
     char creg1 = 0b10001001;
     write_reg(CTRL_REG1_ADDR, &creg1, 1);
     Delay_ms(1000);
     creg1 = 0x00;
     read_reg(CTRL_REG1_ADDR, &creg1, 1);
     Delay_ms(2000);
     IntToHex(creg1, xyz);
     debug(xyz);
}