_main:
;MyProject.c,5 :: 		void main() {
;MyProject.c,6 :: 		init_lcd();
BL	_init_lcd+0
;MyProject.c,7 :: 		i2c_init();
BL	_i2c_init+0
;MyProject.c,8 :: 		init_magnetometer();
BL	_init_magnetometer+0
;MyProject.c,10 :: 		while(1) {
L_main0:
;MyProject.c,11 :: 		asm{ WFI; }
WFI
;MyProject.c,12 :: 		}
IT	AL
BAL	L_main0
;MyProject.c,13 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
