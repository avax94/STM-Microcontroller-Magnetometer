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

#include "i2c.h"

void read_who_am_i() {
    char result = 0;
    char send_addr = WHO_AM_I_ADDR;
    i2c_start_async();
    i2c_send_addr_async(0x0E, 0);
    i2c_send_async(&send_addr, 1);
    //i2c_start_async();
    //i2c_send_addr_async(0x0E, 1);
    //i2c_recv_async(&result, 1);
    
    Delay_ms(1);
    i2c_stop();

    
}