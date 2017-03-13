_i2c_get_event:
;i2c.c,23 :: 		int i2c_get_event() {
;i2c.c,24 :: 		long int sreg1 = I2C2_SR1;
MOVW	R0, #lo_addr(I2C2_SR1+0)
MOVT	R0, #hi_addr(I2C2_SR1+0)
; sreg1 start address is: 8 (R2)
LDR	R2, [R0, #0]
;i2c.c,25 :: 		long int sreg2 = I2C2_SR2;
MOVW	R0, #lo_addr(I2C2_SR2+0)
MOVT	R0, #hi_addr(I2C2_SR2+0)
; sreg2 start address is: 4 (R1)
LDR	R1, [R0, #0]
;i2c.c,26 :: 		sreg = (sreg2 << 16) | sreg1;
LSLS	R0, R1, #16
; sreg2 end address is: 4 (R1)
ORR	R1, R0, R2, LSL #0
; sreg1 end address is: 8 (R2)
MOVW	R0, #lo_addr(_sreg+0)
MOVT	R0, #hi_addr(_sreg+0)
STR	R1, [R0, #0]
;i2c.c,27 :: 		if((sreg & STARTING_EV5) == STARTING_EV5) { //EV5
AND	R0, R1, #1
CMP	R0, #1
IT	NE
BNE	L_i2c_get_event0
;i2c.c,28 :: 		return STARTING;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_get_event
;i2c.c,29 :: 		} else if(I2C2_SR1bits.STOPF == 1) {
L_i2c_get_event0:
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_i2c_get_event2
;i2c.c,30 :: 		return STOPING;
MOVS	R0, #4
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_get_event
;i2c.c,31 :: 		} else if((sreg & ADDR_SENT_EV6) == ADDR_SENT_EV6) { //EV6
L_i2c_get_event2:
MOVW	R0, #lo_addr(_sreg+0)
MOVT	R0, #hi_addr(_sreg+0)
LDR	R0, [R0, #0]
AND	R0, R0, #2
CMP	R0, #2
IT	NE
BNE	L_i2c_get_event4
;i2c.c,32 :: 		return ADDRESS_SENT;
MOVS	R0, #1
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_get_event
;i2c.c,33 :: 		} else if((sreg & TRANSMITTED_EV8) == TRANSMITTED_EV8) { //EV8
L_i2c_get_event4:
MOVW	R0, #lo_addr(_sreg+0)
MOVT	R0, #hi_addr(_sreg+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #128
IT	NE
BNE	L_i2c_get_event6
;i2c.c,34 :: 		return TRANSMITTED;
MOVS	R0, #3
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_get_event
;i2c.c,35 :: 		} else if((sreg & RECEIVED_EV7) == RECEIVED_EV7) { //EV8
L_i2c_get_event6:
MOVW	R0, #lo_addr(_sreg+0)
MOVT	R0, #hi_addr(_sreg+0)
LDR	R0, [R0, #0]
AND	R0, R0, #64
CMP	R0, #64
IT	NE
BNE	L_i2c_get_event8
;i2c.c,36 :: 		return RECEIVED;
MOVS	R0, #2
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_get_event
;i2c.c,37 :: 		} else {
L_i2c_get_event8:
;i2c.c,38 :: 		return DEFAULT;
MOVS	R0, #5
SXTH	R0, R0
;i2c.c,40 :: 		}
L_end_i2c_get_event:
BX	LR
; end of _i2c_get_event
_set_ack:
;i2c.c,42 :: 		void set_ack() {
;i2c.c,43 :: 		ACKN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,44 :: 		}
L_end_set_ack:
BX	LR
; end of _set_ack
_clear_ack:
;i2c.c,46 :: 		void clear_ack() {
;i2c.c,47 :: 		ACKN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,48 :: 		}
L_end_clear_ack:
BX	LR
; end of _clear_ack
_clear_start:
;i2c.c,50 :: 		void clear_start() {
;i2c.c,51 :: 		START_TR = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,52 :: 		}
L_end_clear_start:
BX	LR
; end of _clear_start
_interrupt2:
;i2c.c,130 :: 		void interrupt2() iv  IVT_INT_I2C2_ER ics ICS_AUTO {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;i2c.c,131 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;i2c.c,132 :: 		clear_lcd();
BL	_clear_lcd+0
;i2c.c,133 :: 		set_position(0, 0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_position+0
;i2c.c,134 :: 		write_string("ERROR: ");
MOVW	R0, #lo_addr(?lstr1_i2c+0)
MOVT	R0, #hi_addr(?lstr1_i2c+0)
BL	_write_string+0
;i2c.c,135 :: 		if(I2C2_SR1bits.BERR == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt210
;i2c.c,136 :: 		write_string("BERR");
MOVW	R0, #lo_addr(?lstr2_i2c+0)
MOVT	R0, #hi_addr(?lstr2_i2c+0)
BL	_write_string+0
;i2c.c,137 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;i2c.c,138 :: 		}
L_interrupt210:
;i2c.c,140 :: 		if(I2C2_SR1bits.AF == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt211
;i2c.c,141 :: 		write_string("AF");
MOVW	R0, #lo_addr(?lstr3_i2c+0)
MOVT	R0, #hi_addr(?lstr3_i2c+0)
BL	_write_string+0
;i2c.c,142 :: 		}
L_interrupt211:
;i2c.c,144 :: 		if(I2C2_SR1bits.ARLO == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt212
;i2c.c,145 :: 		write_string("ARLO");
MOVW	R0, #lo_addr(?lstr4_i2c+0)
MOVT	R0, #hi_addr(?lstr4_i2c+0)
BL	_write_string+0
;i2c.c,146 :: 		}
L_interrupt212:
;i2c.c,148 :: 		if(I2C2_SR1bits.OVR == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt213
;i2c.c,149 :: 		write_string("OVR");
MOVW	R0, #lo_addr(?lstr5_i2c+0)
MOVT	R0, #hi_addr(?lstr5_i2c+0)
BL	_write_string+0
;i2c.c,150 :: 		}
L_interrupt213:
;i2c.c,152 :: 		if(I2C2_SR1bits.PECERR == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt214
;i2c.c,153 :: 		write_string("PECERR");
MOVW	R0, #lo_addr(?lstr6_i2c+0)
MOVT	R0, #hi_addr(?lstr6_i2c+0)
BL	_write_string+0
;i2c.c,154 :: 		}
L_interrupt214:
;i2c.c,156 :: 		if(I2C2_SR1bits.TIMEOUT == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt215
;i2c.c,157 :: 		write_string("TIMEOUT");
MOVW	R0, #lo_addr(?lstr7_i2c+0)
MOVT	R0, #hi_addr(?lstr7_i2c+0)
BL	_write_string+0
;i2c.c,158 :: 		}
L_interrupt215:
;i2c.c,160 :: 		if(I2C2_SR1bits.SMBALERT == 1){
MOVW	R1, #lo_addr(I2C2_SR1bits+0)
MOVT	R1, #hi_addr(I2C2_SR1bits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt216
;i2c.c,161 :: 		write_string("SMBALERT");
MOVW	R0, #lo_addr(?lstr8_i2c+0)
MOVT	R0, #hi_addr(?lstr8_i2c+0)
BL	_write_string+0
;i2c.c,162 :: 		}
L_interrupt216:
;i2c.c,164 :: 		Delay_ms(1000);
MOVW	R7, #49833
MOVT	R7, #162
NOP
NOP
L_interrupt217:
SUBS	R7, R7, #1
BNE	L_interrupt217
NOP
NOP
;i2c.c,165 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;i2c.c,166 :: 		}
L_end_interrupt2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _interrupt2
_i2c_start_:
;i2c.c,168 :: 		void i2c_start_() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;i2c.c,169 :: 		NVIC_IntEnable(IVT_INT_I2C2_EV);
MOVW	R0, #49
BL	_NVIC_IntEnable+0
;i2c.c,170 :: 		START_TR = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,171 :: 		}
L_end_i2c_start_:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _i2c_start_
_i2c_stop_:
;i2c.c,173 :: 		void i2c_stop_() {
;i2c.c,174 :: 		I2C2_CR1bits.STOP_ = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R1, [R0, #0]
;i2c.c,175 :: 		}
L_end_i2c_stop_:
BX	LR
; end of _i2c_stop_
_i2c_send_addr:
;i2c.c,177 :: 		void i2c_send_addr(char addr, int r_w) {
; r_w start address is: 4 (R1)
; addr start address is: 0 (R0)
; r_w end address is: 4 (R1)
; addr end address is: 0 (R0)
; addr start address is: 0 (R0)
; r_w start address is: 4 (R1)
;i2c.c,178 :: 		I2C2_DR = addr << 1 | r_w;
LSLS	R2, R0, #1
UXTH	R2, R2
; addr end address is: 0 (R0)
ORR	R3, R2, R1, LSL #0
UXTH	R3, R3
; r_w end address is: 4 (R1)
MOVW	R2, #lo_addr(I2C2_DR+0)
MOVT	R2, #hi_addr(I2C2_DR+0)
STR	R3, [R2, #0]
;i2c.c,179 :: 		address = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_address+0)
MOVT	R2, #hi_addr(_address+0)
STRB	R3, [R2, #0]
;i2c.c,180 :: 		}
L_end_i2c_send_addr:
BX	LR
; end of _i2c_send_addr
_i2c_send:
;i2c.c,182 :: 		void i2c_send(char d) {
; d start address is: 0 (R0)
; d end address is: 0 (R0)
; d start address is: 0 (R0)
;i2c.c,183 :: 		I2C2_DRbits.DR = d;
UXTB	R3, R0
; d end address is: 0 (R0)
MOVW	R2, #lo_addr(I2C2_DRbits+0)
MOVT	R2, #hi_addr(I2C2_DRbits+0)
LDRB	R1, [R2, #0]
BFI	R1, R3, #0, #8
STRB	R1, [R2, #0]
;i2c.c,184 :: 		}
L_end_i2c_send:
BX	LR
; end of _i2c_send
_i2c_recv:
;i2c.c,186 :: 		char i2c_recv() {
;i2c.c,187 :: 		char result = (char)I2C2_DR;
MOVW	R0, #lo_addr(I2C2_DR+0)
MOVT	R0, #hi_addr(I2C2_DR+0)
LDR	R0, [R0, #0]
;i2c.c,189 :: 		return result;
;i2c.c,190 :: 		}
L_end_i2c_recv:
BX	LR
; end of _i2c_recv
_i2c_start_async:
;i2c.c,192 :: 		void i2c_start_async() {
;i2c.c,193 :: 		should_start = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_should_start+0)
MOVT	R0, #hi_addr(_should_start+0)
STRH	R1, [R0, #0]
;i2c.c,194 :: 		}
L_end_i2c_start_async:
BX	LR
; end of _i2c_start_async
_i2c_send_addr_async:
;i2c.c,196 :: 		void i2c_send_addr_async(char addr, int r_w) {
; r_w start address is: 4 (R1)
; addr start address is: 0 (R0)
; r_w end address is: 4 (R1)
; addr end address is: 0 (R0)
; addr start address is: 0 (R0)
; r_w start address is: 4 (R1)
;i2c.c,197 :: 		address = addr;
MOVW	R2, #lo_addr(_address+0)
MOVT	R2, #hi_addr(_address+0)
STRB	R0, [R2, #0]
; addr end address is: 0 (R0)
;i2c.c,198 :: 		r_notw = r_w;
MOVW	R2, #lo_addr(_r_notw+0)
MOVT	R2, #hi_addr(_r_notw+0)
STRH	R1, [R2, #0]
; r_w end address is: 4 (R1)
;i2c.c,199 :: 		}
L_end_i2c_send_addr_async:
BX	LR
; end of _i2c_send_addr_async
_i2c_send_async:
;i2c.c,201 :: 		int i2c_send_async(char* d, int num) {
; num start address is: 4 (R1)
; d start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; num end address is: 4 (R1)
; d end address is: 0 (R0)
; d start address is: 0 (R0)
; num start address is: 4 (R1)
;i2c.c,202 :: 		transfer = d;
MOVW	R2, #lo_addr(_transfer+0)
MOVT	R2, #hi_addr(_transfer+0)
STR	R0, [R2, #0]
; d end address is: 0 (R0)
;i2c.c,203 :: 		transfer_count = num;
MOVW	R2, #lo_addr(_transfer_count+0)
MOVT	R2, #hi_addr(_transfer_count+0)
STRH	R1, [R2, #0]
; num end address is: 4 (R1)
;i2c.c,206 :: 		address != 0) {
MOVW	R2, #lo_addr(_should_start+0)
MOVT	R2, #hi_addr(_should_start+0)
LDRSH	R2, [R2, #0]
CMP	R2, #1
IT	NE
BNE	L__i2c_send_async29
MOVW	R2, #lo_addr(_address+0)
MOVT	R2, #hi_addr(_address+0)
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L__i2c_send_async28
L__i2c_send_async27:
;i2c.c,207 :: 		should_start = 0;
MOVS	R3, #0
SXTH	R3, R3
MOVW	R2, #lo_addr(_should_start+0)
MOVT	R2, #hi_addr(_should_start+0)
STRH	R3, [R2, #0]
;i2c.c,208 :: 		i2c_start_();
BL	_i2c_start_+0
;i2c.c,209 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_send_async
;i2c.c,206 :: 		address != 0) {
L__i2c_send_async29:
L__i2c_send_async28:
;i2c.c,211 :: 		return 1;
MOVS	R0, #1
SXTH	R0, R0
;i2c.c,213 :: 		}
L_end_i2c_send_async:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _i2c_send_async
_i2c_recv_async:
;i2c.c,215 :: 		int i2c_recv_async(char* d, int num) {
; num start address is: 4 (R1)
; d start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; num end address is: 4 (R1)
; d end address is: 0 (R0)
; d start address is: 0 (R0)
; num start address is: 4 (R1)
;i2c.c,216 :: 		transfer = d;
MOVW	R2, #lo_addr(_transfer+0)
MOVT	R2, #hi_addr(_transfer+0)
STR	R0, [R2, #0]
; d end address is: 0 (R0)
;i2c.c,217 :: 		transfer_count = num;
MOVW	R2, #lo_addr(_transfer_count+0)
MOVT	R2, #hi_addr(_transfer_count+0)
STRH	R1, [R2, #0]
; num end address is: 4 (R1)
;i2c.c,220 :: 		address != 0) {
MOVW	R2, #lo_addr(_should_start+0)
MOVT	R2, #hi_addr(_should_start+0)
LDRSH	R2, [R2, #0]
CMP	R2, #1
IT	NE
BNE	L__i2c_recv_async32
MOVW	R2, #lo_addr(_address+0)
MOVT	R2, #hi_addr(_address+0)
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L__i2c_recv_async31
L__i2c_recv_async30:
;i2c.c,221 :: 		should_start = 0;
MOVS	R3, #0
SXTH	R3, R3
MOVW	R2, #lo_addr(_should_start+0)
MOVT	R2, #hi_addr(_should_start+0)
STRH	R3, [R2, #0]
;i2c.c,222 :: 		i2c_start_();
BL	_i2c_start_+0
;i2c.c,223 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_i2c_recv_async
;i2c.c,220 :: 		address != 0) {
L__i2c_recv_async32:
L__i2c_recv_async31:
;i2c.c,225 :: 		return 1;
MOVS	R0, #1
SXTH	R0, R0
;i2c.c,227 :: 		}
L_end_i2c_recv_async:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _i2c_recv_async
_i2c_init:
;i2c.c,284 :: 		void i2c_init() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;i2c.c,287 :: 		enabl = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_enabl+0)
MOVT	R0, #hi_addr(_enabl+0)
STRH	R1, [R0, #0]
;i2c.c,288 :: 		should_start = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_should_start+0)
MOVT	R0, #hi_addr(_should_start+0)
STRH	R1, [R0, #0]
;i2c.c,289 :: 		address = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_address+0)
MOVT	R0, #hi_addr(_address+0)
STRB	R1, [R0, #0]
;i2c.c,291 :: 		RCC_APB1ENRbits.I2C2EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB1ENRbits+0)
STR	R1, [R0, #0]
;i2c.c,292 :: 		i2c_config(); //config pins for i2c
BL	_i2c_config+0
;i2c.c,294 :: 		NVIC_IntEnable(IVT_INT_I2C2_EV); //set interrupts
MOVW	R0, #49
BL	_NVIC_IntEnable+0
;i2c.c,295 :: 		NVIC_IntEnable(IVT_INT_I2C2_ER); //set interrupts
MOVW	R0, #50
BL	_NVIC_IntEnable+0
;i2c.c,296 :: 		EnableInterrupts(); //enable interrupts
BL	_EnableInterrupts+0
;i2c.c,298 :: 		I2C2_CR1bits.PE = 0;
MOVS	R4, #0
SXTB	R4, R4
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R4, [R0, #0]
;i2c.c,299 :: 		I2C2_CR2bits.FREQ = 40;
MOVS	R2, #40
MOVW	R1, #lo_addr(I2C2_CR2bits+0)
MOVT	R1, #hi_addr(I2C2_CR2bits+0)
LDRB	R0, [R1, #0]
BFI	R0, R2, #0, #6
STRB	R0, [R1, #0]
;i2c.c,302 :: 		I2C2_CCRbits.F_S = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R0, #lo_addr(I2C2_CCRbits+0)
MOVT	R0, #hi_addr(I2C2_CCRbits+0)
STR	R3, [R0, #0]
;i2c.c,304 :: 		I2C2_CCRbits.CCR = 34;
MOVS	R2, #34
MOVW	R1, #lo_addr(I2C2_CCRbits+0)
MOVT	R1, #hi_addr(I2C2_CCRbits+0)
LDRH	R0, [R1, #0]
BFI	R0, R2, #0, #12
STRH	R0, [R1, #0]
;i2c.c,305 :: 		I2C2_TRISEbits.TRISE = I2C2_CR2bits.FREQ*1000 / maxRTime + 1;
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
;i2c.c,306 :: 		I2C2_CR1bits.PE = 1;
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R3, [R0, #0]
;i2c.c,307 :: 		NOSTRETCH_I2C = 0;
MOVW	R0, #lo_addr(I2C2_CR1bits+0)
MOVT	R0, #hi_addr(I2C2_CR1bits+0)
STR	R4, [R0, #0]
;i2c.c,308 :: 		I2C2_CR2bits.ITERREN = 1;
MOVW	R0, #lo_addr(I2C2_CR2bits+0)
MOVT	R0, #hi_addr(I2C2_CR2bits+0)
STR	R3, [R0, #0]
;i2c.c,309 :: 		ITBUFEN_I2C = 1;
MOVW	R0, #lo_addr(I2C2_CR2bits+0)
MOVT	R0, #hi_addr(I2C2_CR2bits+0)
STR	R3, [R0, #0]
;i2c.c,310 :: 		ITEVTEN_I2C = 1;
MOVW	R0, #lo_addr(I2C2_CR2bits+0)
MOVT	R0, #hi_addr(I2C2_CR2bits+0)
STR	R3, [R0, #0]
;i2c.c,311 :: 		I2C2_OAR1.B14 = 1;
MOVW	R0, #lo_addr(I2C2_OAR1+0)
MOVT	R0, #hi_addr(I2C2_OAR1+0)
STR	R3, [R0, #0]
;i2c.c,312 :: 		I2C2_OAR1bits.ADDMODE = 0;
MOVW	R0, #lo_addr(I2C2_OAR1bits+0)
MOVT	R0, #hi_addr(I2C2_OAR1bits+0)
STR	R4, [R0, #0]
;i2c.c,313 :: 		}
L_end_i2c_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _i2c_init
_i2c_config:
;i2c.c,315 :: 		void i2c_config() {
;i2c.c,319 :: 		RCC_AHB1ENRbits.GPIOBEN = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R0, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1ENRbits+0)
STR	R3, [R0, #0]
;i2c.c,322 :: 		RCC_APB1RSTRbits.I2C2RST = 1;
MOVW	R0, #lo_addr(RCC_APB1RSTRbits+0)
MOVT	R0, #hi_addr(RCC_APB1RSTRbits+0)
STR	R3, [R0, #0]
;i2c.c,324 :: 		RCC_APB1RSTRbits.I2C2RST = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1RSTRbits+0)
MOVT	R0, #hi_addr(RCC_APB1RSTRbits+0)
STR	R1, [R0, #0]
;i2c.c,328 :: 		GPIOB_OTYPERbits.OT10 = 1;
MOVW	R0, #lo_addr(GPIOB_OTYPERbits+0)
MOVT	R0, #hi_addr(GPIOB_OTYPERbits+0)
STR	R3, [R0, #0]
;i2c.c,329 :: 		GPIOB_MODERbits.MODER10 = 2; //alternate function
MOVS	R2, #2
MOVW	R1, #lo_addr(GPIOB_MODERbits+0)
MOVT	R1, #hi_addr(GPIOB_MODERbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #2
STR	R0, [R1, #0]
;i2c.c,330 :: 		GPIOB_PUPDRbits.PUPDR10 = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(GPIOB_PUPDRbits+0)
MOVT	R1, #hi_addr(GPIOB_PUPDRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #2
STR	R0, [R1, #0]
;i2c.c,331 :: 		GPIOB_OSPEEDRbits.OSPEEDR10 = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(GPIOB_OSPEEDRbits+0)
MOVT	R1, #hi_addr(GPIOB_OSPEEDRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #2
STR	R0, [R1, #0]
;i2c.c,332 :: 		GPIOB_AFRHbits.AFRH10 = 4; //i2c af
MOVS	R2, #4
MOVW	R1, #lo_addr(GPIOB_AFRHbits+0)
MOVT	R1, #hi_addr(GPIOB_AFRHbits+0)
LDRH	R0, [R1, #0]
BFI	R0, R2, #8, #4
STRH	R0, [R1, #0]
;i2c.c,334 :: 		GPIOB_OTYPERbits.OT11 = 1;
MOVW	R0, #lo_addr(GPIOB_OTYPERbits+0)
MOVT	R0, #hi_addr(GPIOB_OTYPERbits+0)
STR	R3, [R0, #0]
;i2c.c,335 :: 		GPIOB_MODERbits.MODER11 = 2; //alternate function
MOVS	R2, #2
MOVW	R1, #lo_addr(GPIOB_MODERbits+0)
MOVT	R1, #hi_addr(GPIOB_MODERbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #22, #2
STR	R0, [R1, #0]
;i2c.c,336 :: 		GPIOB_PUPDRbits.PUPDR11 = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(GPIOB_PUPDRbits+0)
MOVT	R1, #hi_addr(GPIOB_PUPDRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #22, #2
STR	R0, [R1, #0]
;i2c.c,337 :: 		GPIOB_OSPEEDRbits.OSPEEDR11 = 1;
MOVS	R2, #1
MOVW	R1, #lo_addr(GPIOB_OSPEEDRbits+0)
MOVT	R1, #hi_addr(GPIOB_OSPEEDRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #22, #2
STR	R0, [R1, #0]
;i2c.c,338 :: 		GPIOB_AFRHbits.AFRH11 = 4; //i2c af
MOVS	R2, #4
MOVW	R1, #lo_addr(GPIOB_AFRHbits+0)
MOVT	R1, #hi_addr(GPIOB_AFRHbits+0)
LDRH	R0, [R1, #0]
BFI	R0, R2, #12, #4
STRH	R0, [R1, #0]
;i2c.c,339 :: 		}
L_end_i2c_config:
BX	LR
; end of _i2c_config
