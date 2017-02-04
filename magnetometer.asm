_read_who_am_i:
;magnetometer.c,23 :: 		void read_who_am_i() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;magnetometer.c,24 :: 		char result = 0;
;magnetometer.c,25 :: 		char send_addr = WHO_AM_I_ADDR;
MOVS	R0, #7
STRB	R0, [SP, #4]
;magnetometer.c,26 :: 		i2c_start_async();
BL	_i2c_start_async+0
;magnetometer.c,27 :: 		i2c_send_addr_async(0x0E, 0);
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #14
BL	_i2c_send_addr_async+0
;magnetometer.c,28 :: 		i2c_send_async(&send_addr, 1);
ADD	R0, SP, #4
MOVS	R1, #1
SXTH	R1, R1
BL	_i2c_send_async+0
;magnetometer.c,33 :: 		Delay_ms(1);
MOVW	R7, #10665
MOVT	R7, #0
NOP
NOP
L_read_who_am_i0:
SUBS	R7, R7, #1
BNE	L_read_who_am_i0
NOP
NOP
;magnetometer.c,34 :: 		i2c_stop();
BL	_i2c_stop+0
;magnetometer.c,37 :: 		}
L_end_read_who_am_i:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _read_who_am_i
