#ifndef I2C_H_
#define I2C_H_

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
#define BTF_I2C I2C2_SR1bits.BTF

/* events */
#define STARTING_EV5 0x00000001
#define ADDR_SENT_EV6 0x00000002
#define RECEIVED_EV7 0x00000040
#define TRANSMITTED_EV8 0x00000080

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
#endif