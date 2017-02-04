#line 1 "G:/Projects/MIPS/P1/magnetometer.c"
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
#line 23 "G:/Projects/MIPS/P1/magnetometer.c"
void read_who_am_i() {
 char result = 0;
 char send_addr =  0x07 ;
 i2c_start_async();
 i2c_send_addr_async(0x0E, 0);
 i2c_send_async(&send_addr, 1);




 Delay_ms(1);
 i2c_stop();


}
