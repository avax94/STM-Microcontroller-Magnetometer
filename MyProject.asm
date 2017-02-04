_init_io:
;MyProject.c,3 :: 		void init_io() {
;MyProject.c,5 :: 		RCC_AHB1ENRbits.GPIOCEN = 1; //  |= ((1UL << 2) );
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1ENRbits+0)
STR	R1, [R0, #0]
;MyProject.c,8 :: 		GPIOC_MODER &= ~((3UL << 2*13));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R1, [R0, #0]
MVN	R0, #201326592
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,9 :: 		GPIOC_MODER &= ~((3UL << 2*4));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,10 :: 		GPIOC_MODER &= ~((3UL << 2*3));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
AND	R1, R0, #63
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,11 :: 		GPIOC_MODER &= ~((3UL << 2*2));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R1, [R0, #0]
MVN	R0, #48
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,12 :: 		GPIOC_MODER &= ~((3UL << 2*1));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R1, [R0, #0]
MVN	R0, #12
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,13 :: 		GPIOC_MODER &= ~((3UL << 2*0));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R1, [R0, #0]
MVN	R0, #3
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,16 :: 		GPIOC_MODER |= ((1UL << 2*13));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #67108864
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,17 :: 		GPIOC_MODER |= ((1UL << 2*4));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,18 :: 		GPIOC_MODER |= ((1UL << 2*3));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,19 :: 		GPIOC_MODER |= ((1UL << 2*2));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,20 :: 		GPIOC_MODER |= ((1UL << 2*1));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,21 :: 		GPIOC_MODER |= ((1UL << 2*0));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;MyProject.c,33 :: 		GPIOC_OTYPER &= ~((3UL << 13));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #24576
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;MyProject.c,34 :: 		GPIOC_OTYPER &= ~((3UL << 4));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #48
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;MyProject.c,35 :: 		GPIOC_OTYPER &= ~((3UL << 3));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #24
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;MyProject.c,36 :: 		GPIOC_OTYPER &= ~((3UL << 2));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #12
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;MyProject.c,37 :: 		GPIOC_OTYPER &= ~((3UL << 1));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #6
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;MyProject.c,38 :: 		GPIOC_OTYPER &= ~((3UL << 0));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #3
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;MyProject.c,41 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*13));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R1, [R0, #0]
MVN	R0, #201326592
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,42 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*4));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,43 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*3));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
AND	R1, R0, #63
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,44 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*2));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R1, [R0, #0]
MVN	R0, #48
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,45 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*1));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R1, [R0, #0]
MVN	R0, #12
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,46 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*0));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R1, [R0, #0]
MVN	R0, #3
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,49 :: 		GPIOC_OSPEEDR |= ((3UL << 2*13));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #201326592
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,50 :: 		GPIOC_OSPEEDR |= ((3UL << 2*4));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #768
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,51 :: 		GPIOC_OSPEEDR |= ((3UL << 2*3));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #192
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,52 :: 		GPIOC_OSPEEDR |= ((3UL << 2*2));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #48
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,53 :: 		GPIOC_OSPEEDR |= ((3UL << 2*1));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #12
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,54 :: 		GPIOC_OSPEEDR |= ((3UL << 2*0));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #3
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;MyProject.c,57 :: 		GPIOC_PUPDR   &= ~((3UL << 2*13));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R1, [R0, #0]
MVN	R0, #201326592
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;MyProject.c,58 :: 		GPIOC_PUPDR   &= ~((3UL << 2*4));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;MyProject.c,59 :: 		GPIOC_PUPDR   &= ~((3UL << 2*3));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R0, [R0, #0]
AND	R1, R0, #63
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;MyProject.c,60 :: 		GPIOC_PUPDR   &= ~((3UL << 2*2));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R1, [R0, #0]
MVN	R0, #48
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;MyProject.c,61 :: 		GPIOC_PUPDR   &= ~((3UL << 2*1));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R1, [R0, #0]
MVN	R0, #12
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;MyProject.c,62 :: 		GPIOC_PUPDR   &= ~((3UL << 2*0));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R1, [R0, #0]
MVN	R0, #3
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;MyProject.c,63 :: 		}
L_end_init_io:
BX	LR
; end of _init_io
_read_who_am_i2:
;MyProject.c,65 :: 		void read_who_am_i2() {
SUB	SP, SP, #40
STR	LR, [SP, #0]
;MyProject.c,66 :: 		char result = 11;
MOVS	R0, #11
STRB	R0, [SP, #36]
MOVS	R0, #7
STRB	R0, [SP, #37]
;MyProject.c,67 :: 		char send_addr = 0x07;
;MyProject.c,70 :: 		i2c_start_async();
BL	_i2c_start_async+0
;MyProject.c,71 :: 		i2c_send_addr_async(0x0E, 0);
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #14
BL	_i2c_send_addr_async+0
;MyProject.c,72 :: 		i2c_send_async(&send_addr, 1);
ADD	R0, SP, #37
MOVS	R1, #1
SXTH	R1, R1
BL	_i2c_send_async+0
;MyProject.c,73 :: 		Delay_ms(1000);
MOVW	R7, #49833
MOVT	R7, #162
NOP
NOP
L_read_who_am_i20:
SUBS	R7, R7, #1
BNE	L_read_who_am_i20
NOP
NOP
;MyProject.c,74 :: 		i2c_start_async();
BL	_i2c_start_async+0
;MyProject.c,75 :: 		i2c_send_addr_async(0x0E, 1);
MOVS	R1, #1
SXTH	R1, R1
MOVS	R0, #14
BL	_i2c_send_addr_async+0
;MyProject.c,76 :: 		i2c_recv_async(&result, 1);
ADD	R0, SP, #36
MOVS	R1, #1
SXTH	R1, R1
BL	_i2c_recv_async+0
;MyProject.c,78 :: 		Delay_ms(1000);
MOVW	R7, #49833
MOVT	R7, #162
NOP
NOP
L_read_who_am_i22:
SUBS	R7, R7, #1
BNE	L_read_who_am_i22
NOP
NOP
;MyProject.c,82 :: 		IntToHex(result, st);
ADD	R0, SP, #4
MOV	R1, R0
LDRB	R0, [SP, #36]
BL	_IntToHex+0
;MyProject.c,83 :: 		clear_lcd();
BL	_clear_lcd+0
;MyProject.c,84 :: 		set_position(0, 0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_position+0
;MyProject.c,85 :: 		write_string(st);
ADD	R0, SP, #4
BL	_write_string+0
;MyProject.c,86 :: 		}
L_end_read_who_am_i2:
LDR	LR, [SP, #0]
ADD	SP, SP, #40
BX	LR
; end of _read_who_am_i2
_main:
;MyProject.c,89 :: 		void main() {
;MyProject.c,90 :: 		init_io();
BL	_init_io+0
;MyProject.c,91 :: 		init_lcd();
BL	_init_lcd+0
;MyProject.c,92 :: 		i2c_init();
BL	_i2c_init+0
;MyProject.c,93 :: 		read_who_am_i2();
BL	_read_who_am_i2+0
;MyProject.c,94 :: 		GPIOC_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;MyProject.c,95 :: 		Delay_ms(5000);
MOVW	R7, #52563
MOVT	R7, #813
NOP
NOP
L_main4:
SUBS	R7, R7, #1
BNE	L_main4
NOP
NOP
NOP
NOP
;MyProject.c,96 :: 		while(1) {}
L_main6:
IT	AL
BAL	L_main6
;MyProject.c,97 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
