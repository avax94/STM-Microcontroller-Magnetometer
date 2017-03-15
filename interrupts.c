#include "interrupts.h"

void enInterrupts() {
     asm { cpsie i; }
}

void disInterrupts() {
     asm { cpsid i; }
}

void nvicEnable(int intId) {
     int regNum = intId / 32;
     int offset = intId % 32;
     switch(regNum) {
     case 0:
          NVIC_ISER0 |= (1UL << offset);
     break;
     case 1:
          NVIC_ISER1 |= (1UL << offset);
     break;
     case 2:
          NVIC_ISER2 |= (1UL << offset);
     break;
     }
}

void nvicDisable(int intId) {
     int regNum = intId / 32;
     int offset = intId % 32;
     switch(regNum) {
     case 0:
          NVIC_ICER0 |= (1UL << offset);
     break;
     case 1:
          NVIC_ICER1 |= (1UL << offset);
     break;
      case 2:
          NVIC_ICER2 |= (1UL << offset);
     break;
     }
}