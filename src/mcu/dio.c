/*****************************************************************************/
/* File: dio.c                                                               */
/*                                                                           */
/* Description: Driver for digital input and output                          */
/*                                                                           */
/*                                                                           */
/* Date: 2021/12/29                                                          */
/*                                                                           */
/*****************************************************************************/
                                                                               
                                                                               
                                                                               
/*****************************************************************************/
/* Include definitions                                                       */
/*****************************************************************************/

#include "avr/io.h"
#include "typedefs.h"
#include "dio.h"


/*****************************************************************************/
/* typedefs definitions                                                      */
/*****************************************************************************/
typedef struct {
  volatile uint8 * portxn_addr; 
  volatile uint8 * ddxn_addr; 
  volatile uint8 * pud_addr; 
} IoCfg;

/*****************************************************************************/
/* Macro definitions                                                         */
/*****************************************************************************/
#define IO_SHIFT(x)             ((1U) << (x))                                                                               
#define SET_BIT(value, bit)     ((value) | IO_SHIFT(bit))
#define CLEAR_BIT(value, bit)   ((value) & (~IO_SHIFT(bit)))
                                                                               
/*****************************************************************************/
/* Constant definitions                                                      */
/*****************************************************************************/
IoCfg const kIo_cfg[kNoMorePorts] = {
  {&PORTB, &DDRB, &MCUCR},
  {&PORTB, &DDRB, &MCUCR},
  {&PORTB, &DDRB, &MCUCR},

};                                                                            
                                                                               
/*****************************************************************************/
/* Prototype definitions                                                     */
/*****************************************************************************/
                                                                               
                                                                               
/*****************************************************************************/
/* Global Variables                                                          */
/*****************************************************************************/
                                                                               
                                                                               
/*****************************************************************************/
/* Public functions                                                          */
/*****************************************************************************/


void SetDirection(kportn port, kDirection direction, kBit io, Boolean pullup) {
  if (direction == kInput) {
    //Set input mode
    *kIo_cfg[port].ddxn_addr = CLEAR_BIT(*kIo_cfg[port].ddxn_addr,io);
    *kIo_cfg[port].portxn_addr = SET_BIT(*kIo_cfg[port].portxn_addr,io);
    // Enable pull up resistor 
    if (pullup == kEnable) {
      *kIo_cfg[port].pud_addr = CLEAR_BIT(*kIo_cfg[port].pud_addr, kBit4);
    } else {
      *kIo_cfg[port].pud_addr = SET_BIT(*kIo_cfg[port].pud_addr, kBit4);
    }
  } else { // Set output mode
    *kIo_cfg[port].pud_addr = CLEAR_BIT(*kIo_cfg[port].pud_addr, kBit4);
    *kIo_cfg[port].portxn_addr = CLEAR_BIT(*kIo_cfg[port].portxn_addr,io);
    *kIo_cfg[port].ddxn_addr = SET_BIT  (*kIo_cfg[port].ddxn_addr,io);
  }

}

void SetOutputValue(kportn port, kBit io, Boolean state) {
  if (state == kHigh) {
    *kIo_cfg[port].portxn_addr = SET_BIT(*kIo_cfg[port].portxn_addr,io);
  } else {
    *kIo_cfg[port].portxn_addr = CLEAR_BIT(*kIo_cfg[port].portxn_addr,io);
  }
}

/*****************************************************************************/
/* Static functions                                                          */
/*****************************************************************************/
                                                                               
                                                                               