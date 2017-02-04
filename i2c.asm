_i2c_get_event:
;i2c.c,36 :: 		int i2c_get_event() {
;i2c.c,38 :: 		BUSY == 1 &&
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__i2c_get_event56
MOVW	R1, #lo_addr(I2C2_SR2bits+0)
MOVT	R1, #hi_addr(I2C2_SR2bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__i2c_get_event55
;i2c.c,39 :: 		MSL == 1) { //EV5
MOVW	R1, #lo_addr(I2C2_SR2bits+0)
MOVT	R1, #hi_addr(I2C2_SR2bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__i2c_get_event54
L__i2c_get_event53:
;i2c.c,40 :: 		return STARTING;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_get_event
;i2c.c,38 :: 		BUSY == 1 &&
L__i2c_get_event56:
L__i2c_get_event55:
;i2c.c,39 :: 		MSL == 1) { //EV5
L__i2c_get_event54:
;i2c.c,41 :: 		} else if(I2C2_SR1bits.STOPF == 1) {
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_i2c_get_event4
;i2c.c,42 :: 		return STOPING;
MOVS	R0, #4
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_get_event
;i2c.c,43 :: 		} else if(
L_i2c_get_event4:
;i2c.c,45 :: 		) { //EV6
MOVW	R1, #lo_addr(I2C2_SR1+0)
MOVT	R1, #hi_addr(I2C2_SR1+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_i2c_get_event6
;i2c.c,46 :: 		return ADDRESS_SENT;
MOVS	R0, #1
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_get_event
;i2c.c,47 :: 		} else if(TRA == 1 &&
L_i2c_get_event6:
;i2c.c,48 :: 		BUSY == 1 &&
MOVW	R1, #lo_addr(I2C2_SR2bits+0)
MOVT	R1, #hi_addr(I2C2_SR2bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__i2c_get_event60
MOVW	R1, #lo_addr(I2C2_SR2bits+0)
MOVT	R1, #hi_addr(I2C2_SR2bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__i2c_get_event59
;i2c.c,49 :: 		MSL == 1 &&
MOVW	R1, #lo_addr(I2C2_SR2bits+0)
MOVT	R1, #hi_addr(I2C2_SR2bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__i2c_get_event58
;i2c.c,50 :: 		TxE_I2C == 1) { //EV8
MOVW	R1, #lo_addr(I2C2_SR1+0)
MOVT	R1, #hi_addr(I2C2_SR1+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__i2c_get_event57
L__i2c_get_event52:
;i2c.c,51 :: 		return TRANSMITTED;
MOVS	R0, #3
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_get_event
;i2c.c,48 :: 		BUSY == 1 &&
L__i2c_get_event60:
L__i2c_get_event59:
;i2c.c,49 :: 		MSL == 1 &&
L__i2c_get_event58:
;i2c.c,50 :: 		TxE_I2C == 1) { //EV8
L__i2c_get_event57:
;i2c.c,53 :: 		MSL == 1 &&
MOVW	R1, #lo_addr(I2C2_SR2bits+0)
MOVT	R1, #hi_addr(I2C2_SR2bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__i2c_get_event63
MOVW	R1, #lo_addr(I2C2_SR2bits+0)
MOVT	R1, #hi_addr(I2C2_SR2bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__i2c_get_event62
;i2c.c,54 :: 		RxNE_I2C) {
MOVW	R1, #lo_addr(I2C2_SR1+0)
MOVT	R1, #hi_addr(I2C2_SR1+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__i2c_get_event61
L__i2c_get_event51:
;i2c.c,55 :: 		return RECEIVED;
MOVS	R0, #2
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_get_event
;i2c.c,53 :: 		MSL == 1 &&
L__i2c_get_event63:
L__i2c_get_event62:
;i2c.c,54 :: 		RxNE_I2C) {
L__i2c_get_event61:
;i2c.c,57 :: 		return DEFAULT;
MOVS	R0, #5
SXTH	R0, R0
;i2c.c,59 :: 		}
L_end_i2c_get_event:
BX	LR
; end of _i2c_get_event
_interrupt:
;i2c.c,60 :: 		void interrupt() iv  IVT_INT_I2C2_EV ics ICS_AUTO {
SUB	SP, SP, #16
STR	LR, [SP, #0]
;i2c.c,61 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;i2c.c,63 :: 		switch(i2c_get_event()) {
BL	_i2c_get_event+0
STRH	R0, [SP, #12]
IT	AL
BAL	L_interrupt16
;i2c.c,64 :: 		case STARTING:
L_interrupt18:
;i2c.c,65 :: 		state_ = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_state_+0)
MOVT	R0, #hi_addr(_state_+0)
STRH	R1, [R0, #0]
;i2c.c,66 :: 		ACKN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,67 :: 		i2c_send_addr(address, r_notw);
MOVW	R0, #lo_addr(_r_notw+0)
MOVT	R0, #hi_addr(_r_notw+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_address+0)
MOVT	R0, #hi_addr(_address+0)
LDRB	R0, [R0, #0]
BL	_i2c_send_addr+0
;i2c.c,68 :: 		START_TR = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,69 :: 		break;
IT	AL
BAL	L_interrupt17
;i2c.c,70 :: 		case ADDRESS_SENT:
L_interrupt19:
;i2c.c,71 :: 		state_ = 2;
MOVS	R1, #2
SXTH	R1, R1
MOVW	R0, #lo_addr(_state_+0)
MOVT	R0, #hi_addr(_state_+0)
STRH	R1, [R0, #0]
;i2c.c,73 :: 		if(transfer_count == 1) {
MOVW	R0, #lo_addr(_transfer_count+0)
MOVT	R0, #hi_addr(_transfer_count+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_interrupt20
;i2c.c,74 :: 		ACKN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,75 :: 		} else {
IT	AL
BAL	L_interrupt21
L_interrupt20:
;i2c.c,76 :: 		ACKN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,77 :: 		}
L_interrupt21:
;i2c.c,79 :: 		dummy1 = I2C2_SR1;
MOVW	R0, #lo_addr(I2C2_SR1+0)
MOVT	R0, #hi_addr(I2C2_SR1+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_dummy1+0)
MOVT	R0, #hi_addr(_dummy1+0)
STRH	R1, [R0, #0]
;i2c.c,80 :: 		dummy2 = I2C2_SR2;
MOVW	R0, #lo_addr(I2C2_SR2+0)
MOVT	R0, #hi_addr(I2C2_SR2+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_dummy2+0)
MOVT	R0, #hi_addr(_dummy2+0)
STRH	R1, [R0, #0]
;i2c.c,82 :: 		cnt = cnt + 1;
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;i2c.c,83 :: 		curr_transfer = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
STRH	R1, [R0, #0]
;i2c.c,84 :: 		break;
IT	AL
BAL	L_interrupt17
;i2c.c,85 :: 		case TRANSMITTED:
L_interrupt22:
;i2c.c,87 :: 		if(curr_transfer != transfer_count) { //transmiter
MOVW	R0, #lo_addr(_transfer_count+0)
MOVT	R0, #hi_addr(_transfer_count+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
LDRSH	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L_interrupt23
;i2c.c,89 :: 		i2c_send(transfer[curr_transfer]);
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
STR	R0, [SP, #4]
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_transfer+0)
MOVT	R0, #hi_addr(_transfer+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
BL	_i2c_send+0
;i2c.c,90 :: 		state_ = 3;
MOVS	R1, #3
SXTH	R1, R1
MOVW	R0, #lo_addr(_state_+0)
MOVT	R0, #hi_addr(_state_+0)
STRH	R1, [R0, #0]
;i2c.c,91 :: 		if (curr_transfer != transfer_count)
MOVW	R0, #lo_addr(_transfer_count+0)
MOVT	R0, #hi_addr(_transfer_count+0)
LDRSH	R1, [R0, #0]
LDR	R0, [SP, #4]
LDRSH	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L_interrupt24
;i2c.c,92 :: 		curr_transfer = curr_transfer +  1;
MOVW	R1, #lo_addr(_curr_transfer+0)
MOVT	R1, #hi_addr(_curr_transfer+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
L_interrupt24:
;i2c.c,93 :: 		} else {
IT	AL
BAL	L_interrupt25
L_interrupt23:
;i2c.c,94 :: 		i2c_stop();
BL	_i2c_stop+0
;i2c.c,95 :: 		}
L_interrupt25:
;i2c.c,96 :: 		case RECEIVED:
L_interrupt26:
;i2c.c,98 :: 		if(curr_transfer != transfer_count) {
MOVW	R0, #lo_addr(_transfer_count+0)
MOVT	R0, #hi_addr(_transfer_count+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
LDRSH	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L_interrupt27
;i2c.c,99 :: 		transfer[curr_transfer] = i2c_recv();
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
;i2c.c,100 :: 		curr_transfer = curr_transfer + 1;
LDR	R1, [SP, #8]
MOV	R0, R1
LDRSH	R0, [R0, #0]
ADDS	R2, R0, #1
SXTH	R2, R2
STRH	R2, [R1, #0]
;i2c.c,101 :: 		state_ = 5;
MOVS	R1, #5
SXTH	R1, R1
MOVW	R0, #lo_addr(_state_+0)
MOVT	R0, #hi_addr(_state_+0)
STRH	R1, [R0, #0]
;i2c.c,103 :: 		if(curr_transfer+1 == transfer_count || curr_transfer == transfer_count) {
ADDS	R1, R2, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_transfer_count+0)
MOVT	R0, #hi_addr(_transfer_count+0)
LDRSH	R0, [R0, #0]
CMP	R1, R0
IT	EQ
BEQ	L__interrupt66
MOVW	R0, #lo_addr(_transfer_count+0)
MOVT	R0, #hi_addr(_transfer_count+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_curr_transfer+0)
MOVT	R0, #hi_addr(_curr_transfer+0)
LDRSH	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L__interrupt65
IT	AL
BAL	L_interrupt30
L__interrupt66:
L__interrupt65:
;i2c.c,104 :: 		enabl = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_enabl+0)
MOVT	R0, #hi_addr(_enabl+0)
STRH	R1, [R0, #0]
;i2c.c,105 :: 		ACKN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,106 :: 		i2c_stop();
BL	_i2c_stop+0
;i2c.c,107 :: 		state_ = 6;
MOVS	R1, #6
SXTH	R1, R1
MOVW	R0, #lo_addr(_state_+0)
MOVT	R0, #hi_addr(_state_+0)
STRH	R1, [R0, #0]
;i2c.c,108 :: 		}
L_interrupt30:
;i2c.c,109 :: 		} else {
IT	AL
BAL	L_interrupt31
L_interrupt27:
;i2c.c,110 :: 		i2c_stop();
BL	_i2c_stop+0
;i2c.c,111 :: 		}
L_interrupt31:
;i2c.c,113 :: 		break;
IT	AL
BAL	L_interrupt17
;i2c.c,114 :: 		case STOPING:
L_interrupt32:
;i2c.c,115 :: 		if(I2C2_SR1bits.STOPF == 1)
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt33
;i2c.c,116 :: 		I2C2_CR1bits.STOP_ = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
L_interrupt33:
;i2c.c,117 :: 		break;
IT	AL
BAL	L_interrupt17
;i2c.c,118 :: 		case DEFAULT:
L_interrupt34:
;i2c.c,119 :: 		break;
IT	AL
BAL	L_interrupt17
;i2c.c,120 :: 		}
L_interrupt16:
LDRSH	R0, [SP, #12]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt18
CMP	R0, #1
IT	EQ
BEQ	L_interrupt19
CMP	R0, #3
IT	EQ
BEQ	L_interrupt22
CMP	R0, #2
IT	EQ
BEQ	L_interrupt26
CMP	R0, #4
IT	EQ
BEQ	L_interrupt32
CMP	R0, #5
IT	EQ
BEQ	L_interrupt34
L_interrupt17:
;i2c.c,121 :: 		if(enabl == 1)
MOVW	R0, #lo_addr(_enabl+0)
MOVT	R0, #hi_addr(_enabl+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_interrupt35
;i2c.c,122 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
L_interrupt35:
;i2c.c,123 :: 		}
L_end_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _interrupt
_interrupt2:
;i2c.c,125 :: 		void interrupt2() iv  IVT_INT_I2C2_ER ics ICS_AUTO {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;i2c.c,126 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;i2c.c,128 :: 		clear_lcd();
BL	_clear_lcd+0
;i2c.c,129 :: 		set_position(0,0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_position+0
;i2c.c,131 :: 		write_string("AVAX");
MOVW	R0, #lo_addr(?lstr1_i2c+0)
MOVT	R0, #hi_addr(?lstr1_i2c+0)
BL	_write_string+0
;i2c.c,133 :: 		if(I2C2_SR1bits.BERR == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt236
;i2c.c,134 :: 		write_string("BERR");
MOVW	R0, #lo_addr(?lstr2_i2c+0)
MOVT	R0, #hi_addr(?lstr2_i2c+0)
BL	_write_string+0
;i2c.c,135 :: 		}
L_interrupt236:
;i2c.c,137 :: 		if(I2C2_SR1bits.AF == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt237
;i2c.c,138 :: 		write_string("AF");
MOVW	R0, #lo_addr(?lstr3_i2c+0)
MOVT	R0, #hi_addr(?lstr3_i2c+0)
BL	_write_string+0
;i2c.c,139 :: 		}
L_interrupt237:
;i2c.c,141 :: 		if(I2C2_SR1bits.ARLO == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt238
;i2c.c,142 :: 		write_string("ARLO");
MOVW	R0, #lo_addr(?lstr4_i2c+0)
MOVT	R0, #hi_addr(?lstr4_i2c+0)
BL	_write_string+0
;i2c.c,143 :: 		}
L_interrupt238:
;i2c.c,145 :: 		if(I2C2_SR1bits.OVR == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt239
;i2c.c,146 :: 		write_string("OVR");
MOVW	R0, #lo_addr(?lstr5_i2c+0)
MOVT	R0, #hi_addr(?lstr5_i2c+0)
BL	_write_string+0
;i2c.c,147 :: 		}
L_interrupt239:
;i2c.c,149 :: 		if(I2C2_SR1bits.PECERR == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt240
;i2c.c,150 :: 		write_string("PECERR");
MOVW	R0, #lo_addr(?lstr6_i2c+0)
MOVT	R0, #hi_addr(?lstr6_i2c+0)
BL	_write_string+0
;i2c.c,151 :: 		}
L_interrupt240:
;i2c.c,153 :: 		if(I2C2_SR1bits.TIMEOUT == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt241
;i2c.c,154 :: 		write_string("TIMEOUT");
MOVW	R0, #lo_addr(?lstr7_i2c+0)
MOVT	R0, #hi_addr(?lstr7_i2c+0)
BL	_write_string+0
;i2c.c,155 :: 		}
L_interrupt241:
;i2c.c,157 :: 		if(I2C2_SR1bits.SMBALERT == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt242
;i2c.c,158 :: 		write_string("SMBALERT");
MOVW	R0, #lo_addr(?lstr8_i2c+0)
MOVT	R0, #hi_addr(?lstr8_i2c+0)
BL	_write_string+0
;i2c.c,159 :: 		}
L_interrupt242:
;i2c.c,160 :: 		}
L_end_interrupt2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _interrupt2
_i2c_start_:
;i2c.c,162 :: 		void i2c_start_() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;i2c.c,163 :: 		NVIC_IntEnable(IVT_INT_I2C2_EV);
MOVW	R0, #49
BL	_NVIC_IntEnable+0
;i2c.c,164 :: 		START_TR = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,165 :: 		}
L_end_i2c_start_:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _i2c_start_
_i2c_stop:
;i2c.c,167 :: 		void i2c_stop() {
;i2c.c,168 :: 		I2C2_CR1bits.STOP_ = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,169 :: 		}
L_end_i2c_stop:
BX	LR
; end of _i2c_stop
_i2c_send_addr:
;i2c.c,171 :: 		void i2c_send_addr(char addr, int r_w) {
; r_w start address is: 4 (R1)
; addr start address is: 0 (R0)
; r_w end address is: 4 (R1)
; addr end address is: 0 (R0)
; addr start address is: 0 (R0)
; r_w start address is: 4 (R1)
;i2c.c,172 :: 		I2C2_DR = addr << 1 | r_w;
LSLS	R2, R0, #1
UXTH	R2, R2
; addr end address is: 0 (R0)
ORR	R3, R2, R1, LSL #0
UXTH	R3, R3
; r_w end address is: 4 (R1)
MOVW	R2, #lo_addr(I2C2_DR+0)
MOVT	R2, #hi_addr(I2C2_DR+0)
STR	R3, [R2, #0]
;i2c.c,173 :: 		address = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_address+0)
MOVT	R2, #hi_addr(_address+0)
STRB	R3, [R2, #0]
;i2c.c,174 :: 		}
L_end_i2c_send_addr:
BX	LR
; end of _i2c_send_addr
_i2c_send:
;i2c.c,176 :: 		void i2c_send(char d) {
; d start address is: 0 (R0)
; d end address is: 0 (R0)
; d start address is: 0 (R0)
;i2c.c,177 :: 		I2C2_DRbits.DR = d;
UXTB	R3, R0
; d end address is: 0 (R0)
MOVW	R2, #lo_addr(I2C2_DRbits+0)
MOVT	R2, #hi_addr(I2C2_DRbits+0)
LDRB	R1, [R2, #0]
BFI	R1, R3, #0, #8
STRB	R1, [R2, #0]
;i2c.c,178 :: 		}
L_end_i2c_send:
BX	LR
; end of _i2c_send
_i2c_recv:
;i2c.c,180 :: 		char i2c_recv() {
;i2c.c,181 :: 		char result = I2C2_DRbits.DR;
MOVW	R0, #lo_addr(I2C2_DRbits+0)
MOVT	R0, #hi_addr(I2C2_DRbits+0)
LDRB	R0, [R0, #0]
UBFX	R0, R0, #0, #8
; result start address is: 0 (R0)
;i2c.c,183 :: 		return result;
; result end address is: 0 (R0)
;i2c.c,184 :: 		}
L_end_i2c_recv:
BX	LR
; end of _i2c_recv
_i2c_start_async:
;i2c.c,186 :: 		void i2c_start_async() {
;i2c.c,187 :: 		should_start = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_should_start+0)
MOVT	R0, #hi_addr(_should_start+0)
STRH	R1, [R0, #0]
;i2c.c,188 :: 		}
L_end_i2c_start_async:
BX	LR
; end of _i2c_start_async
_i2c_send_addr_async:
;i2c.c,190 :: 		void i2c_send_addr_async(char addr, int r_w) {
; r_w start address is: 4 (R1)
; addr start address is: 0 (R0)
; r_w end address is: 4 (R1)
; addr end address is: 0 (R0)
; addr start address is: 0 (R0)
; r_w start address is: 4 (R1)
;i2c.c,191 :: 		address = addr;
MOVW	R2, #lo_addr(_address+0)
MOVT	R2, #hi_addr(_address+0)
STRB	R0, [R2, #0]
; addr end address is: 0 (R0)
;i2c.c,192 :: 		r_notw = r_w;
MOVW	R2, #lo_addr(_r_notw+0)
MOVT	R2, #hi_addr(_r_notw+0)
STRH	R1, [R2, #0]
; r_w end address is: 4 (R1)
;i2c.c,193 :: 		}
L_end_i2c_send_addr_async:
BX	LR
; end of _i2c_send_addr_async
_i2c_send_async:
;i2c.c,195 :: 		int i2c_send_async(char* d, int num) {
; num start address is: 4 (R1)
; d start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; num end address is: 4 (R1)
; d end address is: 0 (R0)
; d start address is: 0 (R0)
; num start address is: 4 (R1)
;i2c.c,196 :: 		transfer = d;
MOVW	R2, #lo_addr(_transfer+0)
MOVT	R2, #hi_addr(_transfer+0)
STR	R0, [R2, #0]
; d end address is: 0 (R0)
;i2c.c,197 :: 		transfer_count = num;
MOVW	R2, #lo_addr(_transfer_count+0)
MOVT	R2, #hi_addr(_transfer_count+0)
STRH	R1, [R2, #0]
; num end address is: 4 (R1)
;i2c.c,200 :: 		address != 0) {
MOVW	R2, #lo_addr(_should_start+0)
MOVT	R2, #hi_addr(_should_start+0)
LDRSH	R2, [R2, #0]
CMP	R2, #1
IT	NE
BNE	L__i2c_send_async69
MOVW	R2, #lo_addr(_address+0)
MOVT	R2, #hi_addr(_address+0)
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L__i2c_send_async68
L__i2c_send_async67:
;i2c.c,201 :: 		i2c_start_();
BL	_i2c_start_+0
;i2c.c,202 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_send_async
;i2c.c,200 :: 		address != 0) {
L__i2c_send_async69:
L__i2c_send_async68:
;i2c.c,204 :: 		return 1;
MOVS	R0, #1
SXTH	R0, R0
;i2c.c,206 :: 		}
L_end_i2c_send_async:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _i2c_send_async
_i2c_recv_async:
;i2c.c,208 :: 		int i2c_recv_async(char* d, int num) {
; num start address is: 4 (R1)
; d start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; num end address is: 4 (R1)
; d end address is: 0 (R0)
; d start address is: 0 (R0)
; num start address is: 4 (R1)
;i2c.c,209 :: 		transfer = d;
MOVW	R2, #lo_addr(_transfer+0)
MOVT	R2, #hi_addr(_transfer+0)
STR	R0, [R2, #0]
; d end address is: 0 (R0)
;i2c.c,210 :: 		transfer_count = num;
MOVW	R2, #lo_addr(_transfer_count+0)
MOVT	R2, #hi_addr(_transfer_count+0)
STRH	R1, [R2, #0]
; num end address is: 4 (R1)
;i2c.c,213 :: 		address != 0) {
MOVW	R2, #lo_addr(_should_start+0)
MOVT	R2, #hi_addr(_should_start+0)
LDRSH	R2, [R2, #0]
CMP	R2, #1
IT	NE
BNE	L__i2c_recv_async72
MOVW	R2, #lo_addr(_address+0)
MOVT	R2, #hi_addr(_address+0)
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L__i2c_recv_async71
L__i2c_recv_async70:
;i2c.c,214 :: 		should_start = 0;
MOVS	R3, #0
SXTH	R3, R3
MOVW	R2, #lo_addr(_should_start+0)
MOVT	R2, #hi_addr(_should_start+0)
STRH	R3, [R2, #0]
;i2c.c,215 :: 		i2c_start_();
BL	_i2c_start_+0
;i2c.c,216 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_recv_async
;i2c.c,213 :: 		address != 0) {
L__i2c_recv_async72:
L__i2c_recv_async71:
;i2c.c,218 :: 		return 1;
MOVS	R0, #1
SXTH	R0, R0
;i2c.c,220 :: 		}
L_end_i2c_recv_async:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _i2c_recv_async
_i2c_init:
;i2c.c,277 :: 		void i2c_init() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;i2c.c,280 :: 		enabl = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_enabl+0)
MOVT	R0, #hi_addr(_enabl+0)
STRH	R1, [R0, #0]
;i2c.c,281 :: 		should_start = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_should_start+0)
MOVT	R0, #hi_addr(_should_start+0)
STRH	R1, [R0, #0]
;i2c.c,282 :: 		address = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_address+0)
MOVT	R0, #hi_addr(_address+0)
STRB	R1, [R0, #0]
;i2c.c,284 :: 		RCC_APB1ENRbits.I2C2EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB1ENRbits+0)
STR	R1, [R0, #0]
;i2c.c,285 :: 		i2c_config(); //config pins for i2c
BL	_i2c_config+0
;i2c.c,287 :: 		NVIC_IntEnable(IVT_INT_I2C2_EV); //set interrupts
MOVW	R0, #49
BL	_NVIC_IntEnable+0
;i2c.c,289 :: 		NVIC_IntEnable(IVT_INT_I2C2_ER); //set interrupts
MOVW	R0, #50
BL	_NVIC_IntEnable+0
;i2c.c,290 :: 		EnableInterrupts(); //enable interrupts
BL	_EnableInterrupts+0
;i2c.c,292 :: 		I2C2_CR1bits.PE = 0;
MOVS	R4, #0
SXTB	R4, R4
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R4, [R0, #0]
;i2c.c,293 :: 		I2C2_CR2bits.FREQ = 40;
MOVS	R2, #40
MOVW	R1, #lo_addr(I2C2_CR2bits+0)
MOVT	R1, #hi_addr(I2C2_CR2bits+0)
LDRB	R0, [R1, #0]
BFI	R0, R2, #0, #6
STRB	R0, [R1, #0]
;i2c.c,296 :: 		I2C2_CCRbits.F_S = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R0, #lo_addr(I2C2_CCRbits+0)
MOVT	R0, #hi_addr(I2C2_CCRbits+0)
STR	R3, [R0, #0]
;i2c.c,298 :: 		I2C2_CCRbits.CCR = 34;
MOVS	R2, #34
MOVW	R1, #lo_addr(I2C2_CCRbits+0)
MOVT	R1, #hi_addr(I2C2_CCRbits+0)
LDRH	R0, [R1, #0]
BFI	R0, R2, #0, #12
STRH	R0, [R1, #0]
;i2c.c,299 :: 		I2C2_TRISEbits.TRISE = I2C2_CR2bits.FREQ*1000 / maxRTime + 1;
MOVW	R0, #lo_addr(I2C2_CR2bits+0)
MOVT	R0, #hi_addr(I2C2_CR2bits+0)
LDRB	R0, [R0, #0]
UBFX	R0, R0, #0, #6
UXTB	R1, R0
MOVW	R0, #1000
SXTH	R0, R0
MULS	R1, R0, R1
SXTH	R1, R1
MOVW	R0, #1000
SXTH	R0, R0
SDIV	R0, R1, R0
SXTH	R0, R0
ADDS	R0, R0, #1
UXTB	R2, R0
MOVW	R1, #lo_addr(I2C2_TRISEbits+0)
MOVT	R1, #hi_addr(I2C2_TRISEbits+0)
LDRB	R0, [R1, #0]
BFI	R0, R2, #0, #6
STRB	R0, [R1, #0]
;i2c.c,300 :: 		I2C2_CR1bits.PE = 1;
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R3, [R0, #0]
;i2c.c,301 :: 		NOSTRETCH_I2C = 0;
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R4, [R0, #0]
;i2c.c,302 :: 		I2C2_CR2bits.ITERREN = 1;
MOVW	R0, #lo_addr(I2C2_CR2bits+0)
MOVT	R0, #hi_addr(I2C2_CR2bits+0)
STR	R3, [R0, #0]
;i2c.c,303 :: 		ITBUFEN_I2C = 1;
MOVW	R0, #lo_addr(I2C2_CR2bits+0)
MOVT	R0, #hi_addr(I2C2_CR2bits+0)
STR	R3, [R0, #0]
;i2c.c,304 :: 		ITEVTEN_I2C = 1;
MOVW	R0, #lo_addr(I2C2_CR2bits+0)
MOVT	R0, #hi_addr(I2C2_CR2bits+0)
STR	R3, [R0, #0]
;i2c.c,305 :: 		I2C2_OAR1.B14 = 1;
MOVW	R0, #lo_addr(I2C2_OAR1+0)
MOVT	R0, #hi_addr(I2C2_OAR1+0)
STR	R3, [R0, #0]
;i2c.c,306 :: 		I2C2_OAR1bits.ADDMODE = 0;
MOVW	R0, #lo_addr(I2C2_OAR1bits+0)
MOVT	R0, #hi_addr(I2C2_OAR1bits+0)
STR	R4, [R0, #0]
;i2c.c,307 :: 		}
L_end_i2c_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _i2c_init
_i2c_config:
;i2c.c,309 :: 		void i2c_config() {
;i2c.c,313 :: 		RCC_AHB1ENRbits.GPIOBEN = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R0, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1ENRbits+0)
STR	R3, [R0, #0]
;i2c.c,316 :: 		RCC_APB1RSTRbits.I2C2RST = 1;
MOVW	R0, #lo_addr(RCC_APB1RSTRbits+0)
MOVT	R0, #hi_addr(RCC_APB1RSTRbits+0)
STR	R3, [R0, #0]
;i2c.c,318 :: 		RCC_APB1RSTRbits.I2C2RST = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1RSTRbits+0)
MOVT	R0, #hi_addr(RCC_APB1RSTRbits+0)
STR	R1, [R0, #0]
;i2c.c,322 :: 		GPIOB_OTYPERbits.OT10 = 1;
MOVW	R0, #lo_addr(GPIOB_OTYPERbits+0)
MOVT	R0, #hi_addr(GPIOB_OTYPERbits+0)
STR	R3, [R0, #0]
;i2c.c,323 :: 		GPIOB_MODERbits.MODER10 = 2; //alternate function
MOVS	R2, #2
MOVW	R1, #lo_addr(GPIOB_MODERbits+0)
MOVT	R1, #hi_addr(GPIOB_MODERbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #2
STR	R0, [R1, #0]
;i2c.c,324 :: 		GPIOB_PUPDRbits.PUPDR10 = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(GPIOB_PUPDRbits+0)
MOVT	R1, #hi_addr(GPIOB_PUPDRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #2
STR	R0, [R1, #0]
;i2c.c,325 :: 		GPIOB_OSPEEDRbits.OSPEEDR10 = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(GPIOB_OSPEEDRbits+0)
MOVT	R1, #hi_addr(GPIOB_OSPEEDRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #2
STR	R0, [R1, #0]
;i2c.c,326 :: 		GPIOB_AFRHbits.AFRH10 = 4; //i2c af
MOVS	R2, #4
MOVW	R1, #lo_addr(GPIOB_AFRHbits+0)
MOVT	R1, #hi_addr(GPIOB_AFRHbits+0)
LDRH	R0, [R1, #0]
BFI	R0, R2, #8, #4
STRH	R0, [R1, #0]
;i2c.c,328 :: 		GPIOB_OTYPERbits.OT11 = 1;
MOVW	R0, #lo_addr(GPIOB_OTYPERbits+0)
MOVT	R0, #hi_addr(GPIOB_OTYPERbits+0)
STR	R3, [R0, #0]
;i2c.c,329 :: 		GPIOB_MODERbits.MODER11 = 2; //alternate function
MOVS	R2, #2
MOVW	R1, #lo_addr(GPIOB_MODERbits+0)
MOVT	R1, #hi_addr(GPIOB_MODERbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #22, #2
STR	R0, [R1, #0]
;i2c.c,330 :: 		GPIOB_PUPDRbits.PUPDR11 = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(GPIOB_PUPDRbits+0)
MOVT	R1, #hi_addr(GPIOB_PUPDRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #22, #2
STR	R0, [R1, #0]
;i2c.c,331 :: 		GPIOB_OSPEEDRbits.OSPEEDR10 = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(GPIOB_OSPEEDRbits+0)
MOVT	R1, #hi_addr(GPIOB_OSPEEDRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #2
STR	R0, [R1, #0]
;i2c.c,332 :: 		GPIOB_AFRHbits.AFRH11 = 4; //i2c af
MOVS	R2, #4
MOVW	R1, #lo_addr(GPIOB_AFRHbits+0)
MOVT	R1, #hi_addr(GPIOB_AFRHbits+0)
LDRH	R0, [R1, #0]
BFI	R0, R2, #12, #4
STRH	R0, [R1, #0]
;i2c.c,333 :: 		}
L_end_i2c_config:
BX	LR
; end of _i2c_config
