_debug:
;magnetometer.c,33 :: 		void debug(char* d) {
SUB	SP, SP, #8
STR	LR, [SP, #0]
STR	R0, [SP, #4]
;magnetometer.c,34 :: 		clear_lcd();
BL	_clear_lcd+0
;magnetometer.c,35 :: 		set_position(0,0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_position+0
;magnetometer.c,36 :: 		write_string(d);
LDR	R0, [SP, #4]
BL	_write_string+0
;magnetometer.c,37 :: 		}
L_end_debug:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _debug
_calcAngle:
;magnetometer.c,39 :: 		void calcAngle(char *xyz) {
; xyz start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; xyz end address is: 0 (R0)
; xyz start address is: 0 (R0)
;magnetometer.c,42 :: 		float declAngle = 0.069;
; declAngle start address is: 32 (R8)
MOVW	R1, #20447
MOVT	R1, #15757
VMOV	S8, R1
;magnetometer.c,48 :: 		x = (((int)xyz[0]) << 8) | xyz[1];
LDRB	R1, [R0, #0]
LSLS	R2, R1, #8
SXTH	R2, R2
ADDS	R1, R0, #1
LDRB	R1, [R1, #0]
ORR	R3, R2, R1, LSL #0
SXTH	R3, R3
;magnetometer.c,49 :: 		y = (((int)xyz[2]) << 8) | xyz[3];
ADDS	R1, R0, #2
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
SXTH	R2, R2
ADDS	R1, R0, #3
; xyz end address is: 0 (R0)
LDRB	R1, [R1, #0]
ORR	R1, R2, R1, LSL #0
SXTH	R1, R1
;magnetometer.c,52 :: 		y -= (int)((0x0000029A + 0x00000438) >> 1);
SUBW	R2, R1, #873
SXTH	R2, R2
;magnetometer.c,53 :: 		x -= (int)((0x0000FD00 + 0x0000FB4F) >> 1);
ADDW	R1, R3, #985
SXTH	R1, R1
;magnetometer.c,54 :: 		heading = atan2(y, x);
VMOV	S1, R1
VCVT.F32	#1, S1, S1
VMOV	S0, R2
VCVT.F32	#1, S0, S0
BL	_atan2+0
;magnetometer.c,55 :: 		heading = heading - declAngle;
VSUB.F32	S0, S0, S8
; declAngle end address is: 32 (R8)
; heading start address is: 4 (R1)
VMOV.F32	S1, S0
;magnetometer.c,57 :: 		if(heading < 0)   heading += 2*3.14;
VCMPE.F32	S0, #0
VMRS	#60, FPSCR
IT	GE
BGE	L__calcAngle53
MOVW	R1, #62915
MOVT	R1, #16584
VMOV	S0, R1
VADD.F32	S0, S1, S0
VMOV.F32	S1, S0
; heading end address is: 4 (R1)
VMOV.F32	S2, S1
IT	AL
BAL	L_calcAngle0
L__calcAngle53:
VMOV.F32	S2, S1
L_calcAngle0:
;magnetometer.c,60 :: 		if(heading > 2*3.14)heading -= 2*3.14;
; heading start address is: 8 (R2)
MOVW	R1, #62915
MOVT	R1, #16584
VMOV	S0, R1
VCMPE.F32	S2, S0
VMRS	#60, FPSCR
IT	LE
BLE	L__calcAngle54
MOVW	R1, #62915
MOVT	R1, #16584
VMOV	S0, R1
VSUB.F32	S2, S2, S0
; heading end address is: 8 (R2)
IT	AL
BAL	L_calcAngle1
L__calcAngle54:
L_calcAngle1:
;magnetometer.c,62 :: 		headingD = heading * 180 / 3.14;
; heading start address is: 8 (R2)
MOVW	R1, #0
MOVT	R1, #17204
VMOV	S0, R1
VMUL.F32	S1, S2, S0
; heading end address is: 8 (R2)
MOVW	R1, #62915
MOVT	R1, #16456
VMOV	S0, R1
VDIV.F32	S0, S1, S0
;magnetometer.c,63 :: 		angle = (int)headingD;
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
SXTH	R1, R1
; angle start address is: 0 (R0)
SXTH	R0, R1
;magnetometer.c,64 :: 		if(angle > 180) {
CMP	R1, #180
IT	LE
BLE	L__calcAngle55
;magnetometer.c,65 :: 		angle = angle - 360;
SUB	R0, R0, #360
SXTH	R0, R0
; angle end address is: 0 (R0)
;magnetometer.c,66 :: 		}
IT	AL
BAL	L_calcAngle2
L__calcAngle55:
;magnetometer.c,64 :: 		if(angle > 180) {
;magnetometer.c,66 :: 		}
L_calcAngle2:
;magnetometer.c,69 :: 		IntToStr(angle, output);
; angle start address is: 0 (R0)
ADD	R1, SP, #4
; angle end address is: 0 (R0)
BL	_IntToStr+0
;magnetometer.c,70 :: 		debug(Ltrim(output));
ADD	R1, SP, #4
MOV	R0, R1
BL	_Ltrim+0
BL	_debug+0
;magnetometer.c,71 :: 		}
L_end_calcAngle:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _calcAngle
_event_handler:
;magnetometer.c,73 :: 		void event_handler() iv  IVT_INT_I2C2_EV ics ICS_AUTO {
SUB	SP, SP, #16
STR	LR, [SP, #0]
;magnetometer.c,74 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;magnetometer.c,75 :: 		switch(i2c_get_event()) {
BL	_i2c_get_event+0
STRH	R0, [SP, #12]
IT	AL
BAL	L_event_handler3
;magnetometer.c,76 :: 		case STARTING:
L_event_handler5:
;magnetometer.c,77 :: 		ACKN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;magnetometer.c,79 :: 		if(reg_send == 0) { //if we are in register address sending state
MOVW	R0, #lo_addr(_reg_send+0)
MOVT	R0, #hi_addr(_reg_send+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_event_handler6
;magnetometer.c,80 :: 		I2C2_DR = address << 1 | 0;
MOVW	R0, #lo_addr(_address+0)
MOVT	R0, #hi_addr(_address+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #1
UXTH	R1, R1
MOVW	R0, #lo_addr(I2C2_DR+0)
MOVT	R0, #hi_addr(I2C2_DR+0)
STR	R1, [R0, #0]
;magnetometer.c,81 :: 		}
IT	AL
BAL	L_event_handler7
L_event_handler6:
;magnetometer.c,83 :: 		i2c_send_addr(address, r_notw); //if we already sent register address we now do read or write
MOVW	R0, #lo_addr(_r_notw+0)
MOVT	R0, #hi_addr(_r_notw+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_address+0)
MOVT	R0, #hi_addr(_address+0)
LDRB	R0, [R0, #0]
BL	_i2c_send_addr+0
;magnetometer.c,84 :: 		}
L_event_handler7:
;magnetometer.c,86 :: 		START_TR = 0; //clear start flag
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;magnetometer.c,87 :: 		break;
IT	AL
BAL	L_event_handler4
;magnetometer.c,88 :: 		case ADDRESS_SENT:
L_event_handler8:
;magnetometer.c,89 :: 		dummy1 = I2C2_SR1; //need to read sr1 followed by read sr2 so we clean flags
MOVW	R0, #lo_addr(I2C2_SR1+0)
MOVT	R0, #hi_addr(I2C2_SR1+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_dummy1+0)
MOVT	R0, #hi_addr(_dummy1+0)
STRH	R1, [R0, #0]
;magnetometer.c,90 :: 		dummy2 = I2C2_SR2;
MOVW	R0, #lo_addr(I2C2_SR2+0)
MOVT	R0, #hi_addr(I2C2_SR2+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_dummy2+0)
MOVT	R0, #hi_addr(_dummy2+0)
STRH	R1, [R0, #0]
;magnetometer.c,92 :: 		curr_transfer = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
STRH	R1, [R0, #0]
;magnetometer.c,93 :: 		break;
IT	AL
BAL	L_event_handler4
;magnetometer.c,94 :: 		case TRANSMITTED:
L_event_handler9:
;magnetometer.c,95 :: 		if(reg_send == 1) {
MOVW	R0, #lo_addr(_reg_send+0)
MOVT	R0, #hi_addr(_reg_send+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_event_handler10
;magnetometer.c,96 :: 		if(curr_transfer != transfer_count) { //transmiter
MOVW	R0, #lo_addr(_transfer_count+0)
MOVT	R0, #hi_addr(_transfer_count+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
LDRSH	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L_event_handler11
;magnetometer.c,97 :: 		i2c_send(transfer[curr_transfer]);
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_transfer+0)
MOVT	R0, #hi_addr(_transfer+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
BL	_i2c_send+0
;magnetometer.c,98 :: 		curr_transfer = curr_transfer +  1;
MOVW	R1, #lo_addr(_curr_transfer+0)
MOVT	R1, #hi_addr(_curr_transfer+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;magnetometer.c,99 :: 		} else if(BTF_I2C == 1) { //STOP when BTF is set
IT	AL
BAL	L_event_handler12
L_event_handler11:
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_event_handler13
;magnetometer.c,100 :: 		i2c_stop_();
BL	_i2c_stop_+0
;magnetometer.c,101 :: 		}
L_event_handler13:
L_event_handler12:
;magnetometer.c,102 :: 		} else {
IT	AL
BAL	L_event_handler14
L_event_handler10:
;magnetometer.c,103 :: 		if(curr_transfer == 0) {
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_event_handler15
;magnetometer.c,104 :: 		i2c_send(reg_addr);
MOVW	R0, #lo_addr(_reg_addr+0)
MOVT	R0, #hi_addr(_reg_addr+0)
LDRB	R0, [R0, #0]
BL	_i2c_send+0
;magnetometer.c,105 :: 		curr_transfer = curr_transfer + 1;
MOVW	R1, #lo_addr(_curr_transfer+0)
MOVT	R1, #hi_addr(_curr_transfer+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;magnetometer.c,106 :: 		} else if(BTF_I2C == 1) { //take action when BTF
IT	AL
BAL	L_event_handler16
L_event_handler15:
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_event_handler17
;magnetometer.c,107 :: 		reg_send = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_reg_send+0)
MOVT	R0, #hi_addr(_reg_send+0)
STRH	R1, [R0, #0]
;magnetometer.c,108 :: 		curr_transfer = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
STRH	R1, [R0, #0]
;magnetometer.c,110 :: 		if(r_notw == 1) //repetead start if RD is desired action
MOVW	R0, #lo_addr(_r_notw+0)
MOVT	R0, #hi_addr(_r_notw+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_event_handler18
;magnetometer.c,111 :: 		i2c_start_();
BL	_i2c_start_+0
L_event_handler18:
;magnetometer.c,112 :: 		}
L_event_handler17:
L_event_handler16:
;magnetometer.c,113 :: 		}
L_event_handler14:
;magnetometer.c,114 :: 		break;
IT	AL
BAL	L_event_handler4
;magnetometer.c,115 :: 		case RECEIVED:
L_event_handler19:
;magnetometer.c,116 :: 		if(curr_transfer != transfer_count) {
MOVW	R0, #lo_addr(_transfer_count+0)
MOVT	R0, #hi_addr(_transfer_count+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
LDRSH	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L_event_handler20
;magnetometer.c,117 :: 		transfer[curr_transfer] = i2c_recv();
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
STR	R0, [SP, #8]
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_transfer+0)
MOVT	R0, #hi_addr(_transfer+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, R1
STR	R0, [SP, #4]
BL	_i2c_recv+0
LDR	R1, [SP, #4]
STRB	R0, [R1, #0]
;magnetometer.c,118 :: 		curr_transfer = curr_transfer + 1;
LDR	R2, [SP, #8]
MOV	R0, R2
LDRSH	R0, [R0, #0]
ADDS	R1, R0, #1
SXTH	R1, R1
STRH	R1, [R2, #0]
;magnetometer.c,120 :: 		if(curr_transfer == transfer_count) {
MOVW	R0, #lo_addr(_transfer_count+0)
MOVT	R0, #hi_addr(_transfer_count+0)
LDRSH	R0, [R0, #0]
CMP	R1, R0
IT	NE
BNE	L_event_handler21
;magnetometer.c,121 :: 		ACKN = 0; //send NACK
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;magnetometer.c,122 :: 		i2c_stop_(); //stop communication
BL	_i2c_stop_+0
;magnetometer.c,123 :: 		state_ = 5;
MOVS	R1, #5
SXTH	R1, R1
MOVW	R0, #lo_addr(_state_+0)
MOVT	R0, #hi_addr(_state_+0)
STRH	R1, [R0, #0]
;magnetometer.c,124 :: 		}
L_event_handler21:
;magnetometer.c,126 :: 		if(curr_transfer == transfer_count) {
MOVW	R0, #lo_addr(_transfer_count+0)
MOVT	R0, #hi_addr(_transfer_count+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
LDRSH	R0, [R0, #0]
CMP	R0, R1
IT	NE
BNE	L_event_handler22
;magnetometer.c,127 :: 		if(reading_xyz == 1) { //STATE: reading magnetometer data
MOVW	R0, #lo_addr(_reading_xyz+0)
MOVT	R0, #hi_addr(_reading_xyz+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_event_handler23
;magnetometer.c,128 :: 		reading_xyz = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_reading_xyz+0)
MOVT	R0, #hi_addr(_reading_xyz+0)
STRH	R1, [R0, #0]
;magnetometer.c,129 :: 		calcAngle(transfer);
MOVW	R0, #lo_addr(_transfer+0)
MOVT	R0, #hi_addr(_transfer+0)
LDR	R0, [R0, #0]
BL	_calcAngle+0
;magnetometer.c,130 :: 		}
L_event_handler23:
;magnetometer.c,131 :: 		}
L_event_handler22:
;magnetometer.c,132 :: 		}  else  {
IT	AL
BAL	L_event_handler24
L_event_handler20:
;magnetometer.c,133 :: 		i2c_recv();
BL	_i2c_recv+0
;magnetometer.c,134 :: 		}
L_event_handler24:
;magnetometer.c,135 :: 		break;
IT	AL
BAL	L_event_handler4
;magnetometer.c,136 :: 		case STOPING:
L_event_handler25:
;magnetometer.c,137 :: 		if(I2C2_SR1bits.STOPF == 1)
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_event_handler26
;magnetometer.c,138 :: 		I2C2_CR1bits.STOP_ = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
L_event_handler26:
;magnetometer.c,139 :: 		break;
IT	AL
BAL	L_event_handler4
;magnetometer.c,140 :: 		case DEFAULT:
L_event_handler27:
;magnetometer.c,141 :: 		break;
IT	AL
BAL	L_event_handler4
;magnetometer.c,142 :: 		}
L_event_handler3:
LDRSH	R0, [SP, #12]
CMP	R0, #0
IT	EQ
BEQ	L_event_handler5
CMP	R0, #1
IT	EQ
BEQ	L_event_handler8
CMP	R0, #3
IT	EQ
BEQ	L_event_handler9
CMP	R0, #2
IT	EQ
BEQ	L_event_handler19
CMP	R0, #4
IT	EQ
BEQ	L_event_handler25
CMP	R0, #5
IT	EQ
BEQ	L_event_handler27
L_event_handler4:
;magnetometer.c,144 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;magnetometer.c,145 :: 		}
L_end_event_handler:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _event_handler
_send_reg_addr_async:
;magnetometer.c,148 :: 		void send_reg_addr_async(char reg_a) {
; reg_a start address is: 0 (R0)
; reg_a end address is: 0 (R0)
; reg_a start address is: 0 (R0)
;magnetometer.c,149 :: 		reg_send = 0;
MOVS	R2, #0
SXTH	R2, R2
MOVW	R1, #lo_addr(_reg_send+0)
MOVT	R1, #hi_addr(_reg_send+0)
STRH	R2, [R1, #0]
;magnetometer.c,150 :: 		reg_addr = reg_a;
MOVW	R1, #lo_addr(_reg_addr+0)
MOVT	R1, #hi_addr(_reg_addr+0)
STRB	R0, [R1, #0]
; reg_a end address is: 0 (R0)
;magnetometer.c,151 :: 		}
L_end_send_reg_addr_async:
BX	LR
; end of _send_reg_addr_async
_read_who_am_i:
;magnetometer.c,154 :: 		void read_who_am_i() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;magnetometer.c,155 :: 		char result = 0;
MOVS	R0, #0
STRB	R0, [SP, #9]
;magnetometer.c,157 :: 		cnt = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
STRH	R1, [R0, #0]
;magnetometer.c,158 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;magnetometer.c,159 :: 		debug("Entered...");
MOVW	R0, #lo_addr(?lstr1_magnetometer+0)
MOVT	R0, #hi_addr(?lstr1_magnetometer+0)
BL	_debug+0
;magnetometer.c,160 :: 		Delay_ms(1000);
MOVW	R7, #49833
MOVT	R7, #162
NOP
NOP
L_read_who_am_i28:
SUBS	R7, R7, #1
BNE	L_read_who_am_i28
NOP
NOP
;magnetometer.c,161 :: 		i2c_start_async();
BL	_i2c_start_async+0
;magnetometer.c,162 :: 		send_reg_addr_async(WHO_AM_I_ADDR);
MOVS	R0, #7
BL	_send_reg_addr_async+0
;magnetometer.c,163 :: 		i2c_send_addr_async(0x0E, 1);
MOVS	R1, #1
SXTH	R1, R1
MOVS	R0, #14
BL	_i2c_send_addr_async+0
;magnetometer.c,164 :: 		i2c_recv_async(&result, 1);
ADD	R0, SP, #9
MOVS	R1, #1
SXTH	R1, R1
BL	_i2c_recv_async+0
;magnetometer.c,165 :: 		Delay_ms(3000);
MOVW	R7, #18430
MOVT	R7, #488
NOP
NOP
L_read_who_am_i30:
SUBS	R7, R7, #1
BNE	L_read_who_am_i30
NOP
NOP
NOP
;magnetometer.c,166 :: 		debug("RES: ");
MOVW	R0, #lo_addr(?lstr2_magnetometer+0)
MOVT	R0, #hi_addr(?lstr2_magnetometer+0)
BL	_debug+0
;magnetometer.c,167 :: 		IntToHex(result, st);
ADD	R0, SP, #4
MOV	R1, R0
LDRB	R0, [SP, #9]
BL	_IntToHex+0
;magnetometer.c,168 :: 		write_string(st);
ADD	R0, SP, #4
BL	_write_string+0
;magnetometer.c,169 :: 		}
L_end_read_who_am_i:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _read_who_am_i
_read_reg:
;magnetometer.c,171 :: 		void read_reg(char reg, char* d, int cnt) {
SUB	SP, SP, #16
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
STR	R1, [SP, #8]
STRH	R2, [SP, #12]
;magnetometer.c,172 :: 		i2c_start_async();
BL	_i2c_start_async+0
;magnetometer.c,173 :: 		send_reg_addr_async(reg);
LDRB	R0, [SP, #4]
BL	_send_reg_addr_async+0
;magnetometer.c,174 :: 		i2c_send_addr_async(0x0E, 1);
MOVS	R1, #1
SXTH	R1, R1
MOVS	R0, #14
BL	_i2c_send_addr_async+0
;magnetometer.c,175 :: 		i2c_recv_async(d, cnt);
LDRSH	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_i2c_recv_async+0
;magnetometer.c,176 :: 		}
L_end_read_reg:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _read_reg
_write_reg:
;magnetometer.c,178 :: 		void write_reg(char reg, char* d, int cnt) {
SUB	SP, SP, #16
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
STR	R1, [SP, #8]
STRH	R2, [SP, #12]
;magnetometer.c,179 :: 		i2c_start_async();
BL	_i2c_start_async+0
;magnetometer.c,180 :: 		send_reg_addr_async(reg);
LDRB	R0, [SP, #4]
BL	_send_reg_addr_async+0
;magnetometer.c,181 :: 		i2c_send_addr_async(0x0E, 0);
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #14
BL	_i2c_send_addr_async+0
;magnetometer.c,182 :: 		i2c_send_async(d, cnt);
LDRSH	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_i2c_send_async+0
;magnetometer.c,183 :: 		}
L_end_write_reg:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _write_reg
_read_xyz:
;magnetometer.c,186 :: 		int read_xyz(char *d) {
; d start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; d end address is: 0 (R0)
; d start address is: 0 (R0)
;magnetometer.c,187 :: 		int dreg = 1;
MOVW	R1, #1
STRH	R1, [SP, #8]
;magnetometer.c,188 :: 		int bitt = 0;
;magnetometer.c,190 :: 		read_reg(DR_STATUS_ADDR, &dreg, 1);
ADD	R1, SP, #8
STR	R0, [SP, #4]
MOVS	R2, #1
SXTH	R2, R2
MOVS	R0, #0
BL	_read_reg+0
LDR	R0, [SP, #4]
;magnetometer.c,191 :: 		Delay_ms(2);
MOVW	R7, #21331
MOVT	R7, #0
NOP
NOP
L_read_xyz32:
SUBS	R7, R7, #1
BNE	L_read_xyz32
NOP
NOP
NOP
NOP
;magnetometer.c,192 :: 		bitt = dreg >> 3 & 1;
LDRSH	R1, [SP, #8]
ASRS	R1, R1, #3
SXTH	R1, R1
AND	R1, R1, #1
SXTH	R1, R1
; bitt start address is: 8 (R2)
SXTH	R2, R1
;magnetometer.c,193 :: 		if(bitt != 0) {
CMP	R1, #0
IT	EQ
BEQ	L_read_xyz34
;magnetometer.c,194 :: 		read_reg(OUT_X_MSB_ADDR, d, 6);
STRH	R2, [SP, #4]
MOVS	R2, #6
SXTH	R2, R2
MOV	R1, R0
; d end address is: 0 (R0)
MOVS	R0, #1
BL	_read_reg+0
LDRSH	R2, [SP, #4]
;magnetometer.c,195 :: 		Delay_ms(2);
MOVW	R7, #21331
MOVT	R7, #0
NOP
NOP
L_read_xyz35:
SUBS	R7, R7, #1
BNE	L_read_xyz35
NOP
NOP
NOP
NOP
;magnetometer.c,196 :: 		}
L_read_xyz34:
;magnetometer.c,198 :: 		return bitt;
SXTH	R0, R2
; bitt end address is: 8 (R2)
;magnetometer.c,199 :: 		}
L_end_read_xyz:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _read_xyz
_configure_exti:
;magnetometer.c,201 :: 		void configure_exti() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;magnetometer.c,203 :: 		RCC_APB2ENRbits.SYSCFGEN = 1; //enable syscfg periph
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB2ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB2ENRbits+0)
STR	R1, [R0, #0]
;magnetometer.c,204 :: 		RCC_AHB1ENRbits.GPIOEEN = 1; //enable PE clock
MOVW	R0, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1ENRbits+0)
STR	R1, [R0, #0]
;magnetometer.c,205 :: 		GPIOE_MODERbits.MODER10 = 0; //set PE10 as input
MOVS	R2, #0
MOVW	R1, #lo_addr(GPIOE_MODERbits+0)
MOVT	R1, #hi_addr(GPIOE_MODERbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #2
STR	R0, [R1, #0]
;magnetometer.c,206 :: 		GPIOE_PUPDRbits.PUPDR10 = 0x1; //pullup
MOVS	R2, #1
MOVW	R1, #lo_addr(GPIOE_PUPDRbits+0)
MOVT	R1, #hi_addr(GPIOE_PUPDRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #2
STR	R0, [R1, #0]
;magnetometer.c,207 :: 		GPIOE_OTYPERbits.OT10 = 0x0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_OTYPERbits+0)
MOVT	R0, #hi_addr(GPIOE_OTYPERbits+0)
STR	R1, [R0, #0]
;magnetometer.c,208 :: 		GPIOE_OSPEEDRbits.OSPEEDR10 = 0x2;
MOVS	R2, #2
MOVW	R1, #lo_addr(GPIOE_OSPEEDRbits+0)
MOVT	R1, #hi_addr(GPIOE_OSPEEDRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #2
STR	R0, [R1, #0]
;magnetometer.c,210 :: 		SYSCFG_EXTICR3bits.EXTI10 = 0x4; //set PE10 to be EXTI pin
MOVS	R2, #4
MOVW	R1, #lo_addr(SYSCFG_EXTICR3bits+0)
MOVT	R1, #hi_addr(SYSCFG_EXTICR3bits+0)
LDRH	R0, [R1, #0]
BFI	R0, R2, #8, #4
STRH	R0, [R1, #0]
;magnetometer.c,211 :: 		EXTI_FTSR = 0x00000000;
MOVS	R1, #0
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;magnetometer.c,212 :: 		EXTI_RTSR = 0x00000400; //detect rising edge
MOVW	R1, #1024
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
STR	R1, [R0, #0]
;magnetometer.c,213 :: 		EXTI_IMR |= 0x00000400; //unmask bit
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;magnetometer.c,214 :: 		NVIC_IntEnable(IVT_INT_EXTI15_10);
MOVW	R0, #56
BL	_NVIC_IntEnable+0
;magnetometer.c,215 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;magnetometer.c,217 :: 		read_xyz(xyz); //we need to read xyz to clear INT1 bit because if its set we won't be able to detect rising edge
ADD	R0, SP, #4
BL	_read_xyz+0
;magnetometer.c,218 :: 		}
L_end_configure_exti:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _configure_exti
_init_magnetometer:
;magnetometer.c,220 :: 		void init_magnetometer() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;magnetometer.c,221 :: 		char creg1 = 0b10001001; //ACTIVE, 2.5Hz, 32 Sample Ratio
MOVS	R0, #137
STRB	R0, [SP, #4]
MOVS	R0, #160
STRB	R0, [SP, #5]
;magnetometer.c,222 :: 		char creg2 = 0b10100000; //AutoReset, RAW
;magnetometer.c,227 :: 		write_reg(CTRL_REG1_ADDR, &creg1, 1);
ADD	R0, SP, #4
MOVS	R2, #1
SXTH	R2, R2
MOV	R1, R0
MOVS	R0, #16
BL	_write_reg+0
;magnetometer.c,228 :: 		Delay_us(500);
MOVW	R7, #5331
MOVT	R7, #0
NOP
NOP
L_init_magnetometer37:
SUBS	R7, R7, #1
BNE	L_init_magnetometer37
NOP
NOP
NOP
NOP
;magnetometer.c,229 :: 		write_reg(CTRL_REG2_ADDR, &creg2, 1);
ADD	R0, SP, #5
MOVS	R2, #1
SXTH	R2, R2
MOV	R1, R0
MOVS	R0, #17
BL	_write_reg+0
;magnetometer.c,230 :: 		Delay_us(500);
MOVW	R7, #5331
MOVT	R7, #0
NOP
NOP
L_init_magnetometer39:
SUBS	R7, R7, #1
BNE	L_init_magnetometer39
NOP
NOP
NOP
NOP
;magnetometer.c,231 :: 		is_configured = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_is_configured+0)
MOVT	R0, #hi_addr(_is_configured+0)
STRH	R1, [R0, #0]
;magnetometer.c,232 :: 		configure_exti();
BL	_configure_exti+0
;magnetometer.c,233 :: 		}
L_end_init_magnetometer:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _init_magnetometer
_interrupt_handle:
;magnetometer.c,235 :: 		void interrupt_handle() iv IVT_INT_EXTI15_10 ics ICS_AUTO {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;magnetometer.c,236 :: 		if(is_configured == 0) {
MOVW	R0, #lo_addr(_is_configured+0)
MOVT	R0, #hi_addr(_is_configured+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt_handle41
;magnetometer.c,237 :: 		return;
IT	AL
BAL	L_end_interrupt_handle
;magnetometer.c,238 :: 		}
L_interrupt_handle41:
;magnetometer.c,240 :: 		EXTI_PR.B10 = 1; // clear interrupt flag
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;magnetometer.c,241 :: 		reading_xyz = 1; // enter STATE: reading magnetometer data
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_reading_xyz+0)
MOVT	R0, #hi_addr(_reading_xyz+0)
STRH	R1, [R0, #0]
;magnetometer.c,242 :: 		read_reg(OUT_X_MSB_ADDR, xyz, 6); //read data
MOVS	R2, #6
SXTH	R2, R2
MOVW	R1, #lo_addr(_xyz+0)
MOVT	R1, #hi_addr(_xyz+0)
MOVS	R0, #1
BL	_read_reg+0
;magnetometer.c,243 :: 		}
L_end_interrupt_handle:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _interrupt_handle
_printToLCD:
;magnetometer.c,245 :: 		void printToLCD(char *d) {
; d start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; d end address is: 0 (R0)
; d start address is: 0 (R0)
;magnetometer.c,246 :: 		write_lcd(d[2]);
ADDS	R1, R0, #2
LDRB	R1, [R1, #0]
STR	R0, [SP, #4]
UXTB	R0, R1
BL	_write_lcd+0
LDR	R0, [SP, #4]
;magnetometer.c,247 :: 		write_lcd(d[3]);
ADDS	R1, R0, #3
; d end address is: 0 (R0)
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_write_lcd+0
;magnetometer.c,248 :: 		}
L_end_printToLCD:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _printToLCD
_poll_value:
;magnetometer.c,251 :: 		void poll_value() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;magnetometer.c,256 :: 		while(1) {
L_poll_value42:
;magnetometer.c,257 :: 		dreg = 1;
MOVS	R0, #1
SXTH	R0, R0
STRH	R0, [SP, #4]
;magnetometer.c,258 :: 		read_reg(DR_STATUS_ADDR, &dreg, 1);
ADD	R0, SP, #4
MOVS	R2, #1
SXTH	R2, R2
MOV	R1, R0
MOVS	R0, #0
BL	_read_reg+0
;magnetometer.c,259 :: 		Delay_ms(2);
MOVW	R7, #21331
MOVT	R7, #0
NOP
NOP
L_poll_value44:
SUBS	R7, R7, #1
BNE	L_poll_value44
NOP
NOP
NOP
NOP
;magnetometer.c,260 :: 		bitt = dreg >> 3 & 1;
LDRSH	R0, [SP, #4]
ASRS	R0, R0, #3
SXTH	R0, R0
AND	R0, R0, #1
SXTH	R0, R0
;magnetometer.c,261 :: 		if(bitt != 0) {
CMP	R0, #0
IT	EQ
BEQ	L_poll_value46
;magnetometer.c,262 :: 		calcAngle(xyz);
ADD	R0, SP, #6
BL	_calcAngle+0
;magnetometer.c,263 :: 		Delay_ms(250);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_poll_value47:
SUBS	R7, R7, #1
BNE	L_poll_value47
NOP
NOP
;magnetometer.c,264 :: 		}
L_poll_value46:
;magnetometer.c,265 :: 		}
IT	AL
BAL	L_poll_value42
;magnetometer.c,266 :: 		}
L_end_poll_value:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _poll_value
_test_rd_write:
;magnetometer.c,269 :: 		void test_rd_write() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;magnetometer.c,270 :: 		char xyz[6], rd = 3;
;magnetometer.c,272 :: 		char creg1 = 0b10001001;
MOVS	R0, #137
STRB	R0, [SP, #10]
;magnetometer.c,273 :: 		write_reg(CTRL_REG1_ADDR, &creg1, 1);
ADD	R0, SP, #10
MOVS	R2, #1
SXTH	R2, R2
MOV	R1, R0
MOVS	R0, #16
BL	_write_reg+0
;magnetometer.c,274 :: 		Delay_ms(1000);
MOVW	R7, #49833
MOVT	R7, #162
NOP
NOP
L_test_rd_write49:
SUBS	R7, R7, #1
BNE	L_test_rd_write49
NOP
NOP
;magnetometer.c,275 :: 		creg1 = 0x00;
MOVS	R0, #0
STRB	R0, [SP, #10]
;magnetometer.c,276 :: 		read_reg(CTRL_REG1_ADDR, &creg1, 1);
ADD	R0, SP, #10
MOVS	R2, #1
SXTH	R2, R2
MOV	R1, R0
MOVS	R0, #16
BL	_read_reg+0
;magnetometer.c,277 :: 		Delay_ms(2000);
MOVW	R7, #34131
MOVT	R7, #325
NOP
NOP
L_test_rd_write51:
SUBS	R7, R7, #1
BNE	L_test_rd_write51
NOP
NOP
NOP
NOP
;magnetometer.c,278 :: 		IntToHex(creg1, xyz);
ADD	R0, SP, #4
MOV	R1, R0
LDRB	R0, [SP, #10]
BL	_IntToHex+0
;magnetometer.c,279 :: 		debug(xyz);
ADD	R0, SP, #4
BL	_debug+0
;magnetometer.c,280 :: 		}
L_end_test_rd_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _test_rd_write
