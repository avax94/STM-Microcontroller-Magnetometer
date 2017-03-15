#ifndef MAG_H_
#define MAG_H_
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
#endif