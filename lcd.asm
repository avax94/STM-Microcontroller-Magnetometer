_init_io:
;lcd.c,34 :: 		void init_io() {
;lcd.c,36 :: 		RCC_AHB1ENRbits.GPIOCEN = 1; //  |= ((1UL << 2) );
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_AHB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1ENRbits+0)
STR	R1, [R0, #0]
;lcd.c,37 :: 		RCC_AHB1LPENRbits.GPIOCLPEN = 1;
MOVW	R0, #lo_addr(RCC_AHB1LPENRbits+0)
MOVT	R0, #hi_addr(RCC_AHB1LPENRbits+0)
STR	R1, [R0, #0]
;lcd.c,39 :: 		GPIOC_MODER &= ~((3UL << 2*13));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R1, [R0, #0]
MVN	R0, #201326592
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,40 :: 		GPIOC_MODER &= ~((3UL << 2*4));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,41 :: 		GPIOC_MODER &= ~((3UL << 2*3));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
AND	R1, R0, #63
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,42 :: 		GPIOC_MODER &= ~((3UL << 2*2));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R1, [R0, #0]
MVN	R0, #48
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,43 :: 		GPIOC_MODER &= ~((3UL << 2*1));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R1, [R0, #0]
MVN	R0, #12
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,44 :: 		GPIOC_MODER &= ~((3UL << 2*0));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R1, [R0, #0]
MVN	R0, #3
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,47 :: 		GPIOC_MODER |= ((1UL << 2*13));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #67108864
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,48 :: 		GPIOC_MODER |= ((1UL << 2*4));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,49 :: 		GPIOC_MODER |= ((1UL << 2*3));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,50 :: 		GPIOC_MODER |= ((1UL << 2*2));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,51 :: 		GPIOC_MODER |= ((1UL << 2*1));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,52 :: 		GPIOC_MODER |= ((1UL << 2*0));
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_MODER+0)
MOVT	R0, #hi_addr(GPIOC_MODER+0)
STR	R1, [R0, #0]
;lcd.c,54 :: 		GPIOC_OTYPER &= ~((3UL << 13));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #24576
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;lcd.c,55 :: 		GPIOC_OTYPER &= ~((3UL << 4));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #48
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;lcd.c,56 :: 		GPIOC_OTYPER &= ~((3UL << 3));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #24
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;lcd.c,57 :: 		GPIOC_OTYPER &= ~((3UL << 2));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #12
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;lcd.c,58 :: 		GPIOC_OTYPER &= ~((3UL << 1));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #6
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;lcd.c,59 :: 		GPIOC_OTYPER &= ~((3UL << 0));
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
LDR	R1, [R0, #0]
MVN	R0, #3
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OTYPER+0)
MOVT	R0, #hi_addr(GPIOC_OTYPER+0)
STR	R1, [R0, #0]
;lcd.c,62 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*13));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R1, [R0, #0]
MVN	R0, #201326592
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,63 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*4));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,64 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*3));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
AND	R1, R0, #63
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,65 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*2));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R1, [R0, #0]
MVN	R0, #48
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,66 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*1));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R1, [R0, #0]
MVN	R0, #12
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,67 :: 		GPIOC_OSPEEDR &= ~((3UL << 2*0));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R1, [R0, #0]
MVN	R0, #3
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,70 :: 		GPIOC_OSPEEDR |= ((3UL << 2*13));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #201326592
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,71 :: 		GPIOC_OSPEEDR |= ((3UL << 2*4));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #768
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,72 :: 		GPIOC_OSPEEDR |= ((3UL << 2*3));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #192
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,73 :: 		GPIOC_OSPEEDR |= ((3UL << 2*2));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #48
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,74 :: 		GPIOC_OSPEEDR |= ((3UL << 2*1));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #12
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,75 :: 		GPIOC_OSPEEDR |= ((3UL << 2*0));
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #3
MOVW	R0, #lo_addr(GPIOC_OSPEEDR+0)
MOVT	R0, #hi_addr(GPIOC_OSPEEDR+0)
STR	R1, [R0, #0]
;lcd.c,78 :: 		GPIOC_PUPDR   &= ~((3UL << 2*13));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R1, [R0, #0]
MVN	R0, #201326592
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;lcd.c,79 :: 		GPIOC_PUPDR   &= ~((3UL << 2*4));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;lcd.c,80 :: 		GPIOC_PUPDR   &= ~((3UL << 2*3));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R0, [R0, #0]
AND	R1, R0, #63
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;lcd.c,81 :: 		GPIOC_PUPDR   &= ~((3UL << 2*2));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R1, [R0, #0]
MVN	R0, #48
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;lcd.c,82 :: 		GPIOC_PUPDR   &= ~((3UL << 2*1));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R1, [R0, #0]
MVN	R0, #12
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;lcd.c,83 :: 		GPIOC_PUPDR   &= ~((3UL << 2*0));
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
LDR	R1, [R0, #0]
MVN	R0, #3
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_PUPDR+0)
MOVT	R0, #hi_addr(GPIOC_PUPDR+0)
STR	R1, [R0, #0]
;lcd.c,84 :: 		}
L_end_init_io:
BX	LR
; end of _init_io
_init_lcd:
;lcd.c,86 :: 		void init_lcd() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;lcd.c,87 :: 		init_io();
BL	_init_io+0
;lcd.c,88 :: 		START_COMMAND;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;lcd.c,89 :: 		Delay_ms(20);
MOVW	R7, #16723
MOVT	R7, #3
NOP
NOP
L_init_lcd0:
SUBS	R7, R7, #1
BNE	L_init_lcd0
NOP
NOP
NOP
NOP
;lcd.c,90 :: 		send_word(0x33);
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #3
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd2:
SUBS	R7, R7, #1
BNE	L_init_lcd2
NOP
NOP
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #3
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd4:
SUBS	R7, R7, #1
BNE	L_init_lcd4
NOP
NOP
;lcd.c,91 :: 		Delay_ms(20);
MOVW	R7, #16723
MOVT	R7, #3
NOP
NOP
L_init_lcd6:
SUBS	R7, R7, #1
BNE	L_init_lcd6
NOP
NOP
NOP
NOP
;lcd.c,92 :: 		send_word(0x32);
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #3
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd8:
SUBS	R7, R7, #1
BNE	L_init_lcd8
NOP
NOP
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #2
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd10:
SUBS	R7, R7, #1
BNE	L_init_lcd10
NOP
NOP
;lcd.c,93 :: 		Delay_us(20);
MOVW	R7, #211
MOVT	R7, #0
NOP
NOP
L_init_lcd12:
SUBS	R7, R7, #1
BNE	L_init_lcd12
NOP
NOP
NOP
NOP
;lcd.c,94 :: 		send_word(LCD_DISP_INIT);
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #2
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd14:
SUBS	R7, R7, #1
BNE	L_init_lcd14
NOP
NOP
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #8
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd16:
SUBS	R7, R7, #1
BNE	L_init_lcd16
NOP
NOP
;lcd.c,95 :: 		Delay_us(20);
MOVW	R7, #211
MOVT	R7, #0
NOP
NOP
L_init_lcd18:
SUBS	R7, R7, #1
BNE	L_init_lcd18
NOP
NOP
NOP
NOP
;lcd.c,96 :: 		send_word(LCD_DISP_OFF);
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd20:
SUBS	R7, R7, #1
BNE	L_init_lcd20
NOP
NOP
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #8
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd22:
SUBS	R7, R7, #1
BNE	L_init_lcd22
NOP
NOP
;lcd.c,97 :: 		Delay_us(20);
MOVW	R7, #211
MOVT	R7, #0
NOP
NOP
L_init_lcd24:
SUBS	R7, R7, #1
BNE	L_init_lcd24
NOP
NOP
NOP
NOP
;lcd.c,98 :: 		send_word(LCD_CLEAR_DISPLAY);
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd26:
SUBS	R7, R7, #1
BNE	L_init_lcd26
NOP
NOP
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd28:
SUBS	R7, R7, #1
BNE	L_init_lcd28
NOP
NOP
;lcd.c,99 :: 		Delay_us(900);
MOVW	R7, #9598
MOVT	R7, #0
NOP
NOP
L_init_lcd30:
SUBS	R7, R7, #1
BNE	L_init_lcd30
NOP
NOP
NOP
;lcd.c,100 :: 		send_word(LCD_INC_MODE);
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd32:
SUBS	R7, R7, #1
BNE	L_init_lcd32
NOP
NOP
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #6
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd34:
SUBS	R7, R7, #1
BNE	L_init_lcd34
NOP
NOP
;lcd.c,101 :: 		Delay_us(20);
MOVW	R7, #211
MOVT	R7, #0
NOP
NOP
L_init_lcd36:
SUBS	R7, R7, #1
BNE	L_init_lcd36
NOP
NOP
NOP
NOP
;lcd.c,102 :: 		send_word(LCD_DISP_ON);
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd38:
SUBS	R7, R7, #1
BNE	L_init_lcd38
NOP
NOP
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #12
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd40:
SUBS	R7, R7, #1
BNE	L_init_lcd40
NOP
NOP
;lcd.c,103 :: 		Delay_us(20);
MOVW	R7, #211
MOVT	R7, #0
NOP
NOP
L_init_lcd42:
SUBS	R7, R7, #1
BNE	L_init_lcd42
NOP
NOP
NOP
NOP
;lcd.c,104 :: 		send_word(LCD_RETRN_HOME);
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd44:
SUBS	R7, R7, #1
BNE	L_init_lcd44
NOP
NOP
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #2
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_init_lcd46:
SUBS	R7, R7, #1
BNE	L_init_lcd46
NOP
NOP
;lcd.c,105 :: 		Delay_us(20);
MOVW	R7, #211
MOVT	R7, #0
NOP
NOP
L_init_lcd48:
SUBS	R7, R7, #1
BNE	L_init_lcd48
NOP
NOP
NOP
NOP
;lcd.c,106 :: 		}
L_end_init_lcd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_lcd
_set_position:
;lcd.c,108 :: 		void set_position(char x, char y){
; y start address is: 4 (R1)
; x start address is: 0 (R0)
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 0 (R0)
; y start address is: 4 (R1)
;lcd.c,110 :: 		switch(x){
IT	AL
BAL	L_set_position50
; x end address is: 0 (R0)
;lcd.c,111 :: 		case 0: pos = y; break;
L_set_position52:
; pos start address is: 0 (R0)
UXTB	R0, R1
; y end address is: 4 (R1)
; pos end address is: 0 (R0)
IT	AL
BAL	L_set_position51
;lcd.c,112 :: 		case 1: pos = 0x40+y; break;
L_set_position53:
; y start address is: 4 (R1)
ADDW	R2, R1, #64
; y end address is: 4 (R1)
; pos start address is: 0 (R0)
UXTB	R0, R2
; pos end address is: 0 (R0)
IT	AL
BAL	L_set_position51
;lcd.c,113 :: 		default: pos = y;
L_set_position54:
; pos start address is: 0 (R0)
; y start address is: 4 (R1)
UXTB	R0, R1
; y end address is: 4 (R1)
;lcd.c,114 :: 		}
; pos end address is: 0 (R0)
IT	AL
BAL	L_set_position51
L_set_position50:
; y start address is: 4 (R1)
; x start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_set_position52
CMP	R0, #1
IT	EQ
BEQ	L_set_position53
; x end address is: 0 (R0)
IT	AL
BAL	L_set_position54
; y end address is: 4 (R1)
L_set_position51:
;lcd.c,116 :: 		GPIOC_ODR = 0;
; pos start address is: 0 (R0)
MOVS	R3, #0
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
STR	R3, [R2, #0]
;lcd.c,117 :: 		send_word(0x80 | pos);
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
LDR	R2, [R2, #0]
ORR	R3, R2, #8192
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
STR	R3, [R2, #0]
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
LDR	R3, [R2, #0]
MVN	R2, #15
AND	R2, R3, R2, LSL #0
ORR	R3, R2, #128
LSRS	R2, R0, #4
UXTB	R2, R2
ORRS	R3, R2
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
STR	R3, [R2, #0]
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
LDR	R3, [R2, #0]
MVN	R2, #8192
ANDS	R3, R2
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
STR	R3, [R2, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_set_position55:
SUBS	R7, R7, #1
BNE	L_set_position55
NOP
NOP
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
LDR	R2, [R2, #0]
ORR	R3, R2, #8192
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
STR	R3, [R2, #0]
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
LDR	R3, [R2, #0]
MVN	R2, #15
AND	R2, R3, R2, LSL #0
ORR	R3, R2, #128
AND	R2, R0, #15
UXTB	R2, R2
; pos end address is: 0 (R0)
ORRS	R3, R2
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
STR	R3, [R2, #0]
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
LDR	R3, [R2, #0]
MVN	R2, #8192
ANDS	R3, R2
MOVW	R2, #lo_addr(GPIOC_ODR+0)
MOVT	R2, #hi_addr(GPIOC_ODR+0)
STR	R3, [R2, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_set_position57:
SUBS	R7, R7, #1
BNE	L_set_position57
NOP
NOP
;lcd.c,118 :: 		Delay_ms(20);
MOVW	R7, #16723
MOVT	R7, #3
NOP
NOP
L_set_position59:
SUBS	R7, R7, #1
BNE	L_set_position59
NOP
NOP
NOP
NOP
;lcd.c,119 :: 		}
L_end_set_position:
BX	LR
; end of _set_position
_write_lcd:
;lcd.c,121 :: 		void write_lcd(char c) {
; c start address is: 0 (R0)
; c end address is: 0 (R0)
; c start address is: 0 (R0)
;lcd.c,122 :: 		GPIOC_ODR = W_RAM;
MOVS	R2, #16
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
STR	R2, [R1, #0]
;lcd.c,123 :: 		send_word(c);
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R1, #0]
ORR	R2, R1, #8192
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
STR	R2, [R1, #0]
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R2, [R1, #0]
MVN	R1, #15
ANDS	R2, R1
LSRS	R1, R0, #4
UXTB	R1, R1
ORRS	R2, R1
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
STR	R2, [R1, #0]
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R2, [R1, #0]
MVN	R1, #8192
ANDS	R2, R1
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
STR	R2, [R1, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_write_lcd61:
SUBS	R7, R7, #1
BNE	L_write_lcd61
NOP
NOP
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R1, #0]
ORR	R2, R1, #8192
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
STR	R2, [R1, #0]
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R2, [R1, #0]
MVN	R1, #15
ANDS	R2, R1
AND	R1, R0, #15
UXTB	R1, R1
; c end address is: 0 (R0)
ORRS	R2, R1
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
STR	R2, [R1, #0]
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R2, [R1, #0]
MVN	R1, #8192
ANDS	R2, R1
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
STR	R2, [R1, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_write_lcd63:
SUBS	R7, R7, #1
BNE	L_write_lcd63
NOP
NOP
;lcd.c,124 :: 		Delay_ms(2);
MOVW	R7, #21331
MOVT	R7, #0
NOP
NOP
L_write_lcd65:
SUBS	R7, R7, #1
BNE	L_write_lcd65
NOP
NOP
NOP
NOP
;lcd.c,125 :: 		}
L_end_write_lcd:
BX	LR
; end of _write_lcd
_write_string:
;lcd.c,127 :: 		void write_string(char* c) {
; c start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; c end address is: 0 (R0)
; c start address is: 0 (R0)
MOV	R3, R0
; c end address is: 0 (R0)
;lcd.c,128 :: 		while(*c != '\0') {
L_write_string67:
; c start address is: 12 (R3)
LDRB	R1, [R3, #0]
CMP	R1, #0
IT	EQ
BEQ	L_write_string68
;lcd.c,129 :: 		write_lcd(*c);
LDRB	R1, [R3, #0]
UXTB	R0, R1
BL	_write_lcd+0
;lcd.c,130 :: 		c++;
ADDS	R3, R3, #1
;lcd.c,131 :: 		}
; c end address is: 12 (R3)
IT	AL
BAL	L_write_string67
L_write_string68:
;lcd.c,132 :: 		}
L_end_write_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _write_string
_clear_lcd:
;lcd.c,134 :: 		void clear_lcd() {
;lcd.c,135 :: 		START_COMMAND;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;lcd.c,136 :: 		send_word(LCD_CLEAR_DISPLAY);
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_clear_lcd69:
SUBS	R7, R7, #1
BNE	L_clear_lcd69
NOP
NOP
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #15
AND	R0, R1, R0, LSL #0
ORR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
MOVW	R7, #9
MOVT	R7, #0
NOP
NOP
L_clear_lcd71:
SUBS	R7, R7, #1
BNE	L_clear_lcd71
NOP
NOP
;lcd.c,137 :: 		}
L_end_clear_lcd:
BX	LR
; end of _clear_lcd
