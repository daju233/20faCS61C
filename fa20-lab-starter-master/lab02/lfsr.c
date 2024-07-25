#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

void lfsr_calculate(uint16_t *reg) {
    /* YOUR CODE HERE */
    int zero,two,three,five;
    zero=(*reg>>0)&0x0001;
    two=(*reg>>2)&0x0001;
    three=(*reg>>3)&0x0001;
    five=(*reg>>5)&0x0001;
    unsigned next=zero^two^three^five;
    next=next<<15;
    *reg=*reg>>1;
    *reg=*reg|next;
    // printf("%d,%d,%d,%d,%d  ",zero,two,three,five,next);
}

