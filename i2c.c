#include "lcd.h"

volatile sbit ACKN at I2C1_CR1.B10;
volatile sbit START_TR at I2C1_CR1.B9;
volatile sbit STOP at I2C1_CR1.B8;
volatile sbit NOSTRETCH_I2C at I2C1_CR1.B7;

volatile sbit ITBUFEN_I2C at I2C1_CR2.B10;
volatile sbit ITEVTEN_I2C at I2C1_CR2.B9;

volatile sbit ADDMODE_I2C at I2C1_OAR1.B15;

volatile sbit RxNE_I2C at I2C1_SR1.B6;
volatile sbit TxE_I2C at I2C1_SR1.B7;
volatile sbit BTF_I2C at I2C1_SR1.B2;
volatile sbit ADDR_I2C at I2C1_SR1.B1;

volatile sbit TRA_I2C at I2C1_SR2.B2;

int transfer_count;
char* transfer;
char address;
char reg_addr;
int r_notw;
enum states {STARTING, ADDRESS_SENT, SENDING_REG, SENDRCV_DATA} state;

void interrupt_routine() iv  IVT_INT_I2C1_EV ics ICS_AUTO{
    switch(state) {
    case STARTING:
         I2C1_DR = (address << 1) | r_notw;
         state = ADDRESS_SENT;
         break;
    case ADDRESS_SENT:
         if(ADDR) {
             I2C1_SR1.B1;
             I2C1_SR1.B2;
             state = SENDING_REG;
         }
         break;
    case SENDING_REG:
         if(START_TR != 1) {
             START_TR = 1;
         } else {
             I2C1_DR = reg_addr;
             state = SENDRCV_DATA;
         }
         break;
    case SENDRCV_DATA:
         if(transfer_count == 1) {
             ACKN = 0;
             STOP = 1;
             START_TR = 0;
         } else if(transfer_count == 0) {
             STOP = 0;
             state = STARTING;
             ACKN = 1;
         }
         
         transfer_count--;
         
         if(TxE_I2C && TRA_I2C) {
             I2C1_DR = transfer[transfer_count];
         } else if(RxNE && !TRA_I2C) {
             transfer[transfer_count] = I2C1_DR;
         }
         break;
    }
}

void i2c_transaction(char* d, int size, char addr, int r_w) {
     transfer = d;
     transfer_count = size;
     address = addr;
     r_notw = r_w;
     START_TR = 1;
     state = STARTING;
}

void i2c_send(char* d, int size, char addr) {
     i2c_transaction(d, size, addr, 0);
}

void i2c_recv(char* d, int size, char addr) {
     i2c_transaction(d, size, addr, 1);
}

