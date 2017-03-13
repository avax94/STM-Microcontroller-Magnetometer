#line 1 "G:/Projects/MIPS/P1/MyProject.c"
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
#line 1 "g:/projects/mips/p1/magnetometer.h"


void read_who_am_i();
void test_rd_write();
void init_magnetometer();
void poll_value();
void dealwithit();
void interrupt_handle();
extern int reading_xyz;
extern int called;
void debug(char* d);
void read_reg(char reg, char* d, int cnt);
#line 5 "G:/Projects/MIPS/P1/MyProject.c"
void main() {
 init_lcd();
 i2c_init();
 init_magnetometer();

 while(1) {
 asm{ WFI; }
 }
}
