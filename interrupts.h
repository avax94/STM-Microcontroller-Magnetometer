#ifndef INTERRUPTS_H_
#define INTERRUPTS_H_

void enInterrupts();
void disInterrupts();
void nvicEnable(int intId);
void nvicDisable(int intId);
#endif