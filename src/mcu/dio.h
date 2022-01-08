/*****************************************************************************/
/* File: dio.h                                                               */
/*                                                                           */
/* Description: Module for all interfaces declared in dio.c                  */
/*              required for external access                                 */
/*                                                                           */
/* Date: 2021/12/29                                                          */
/*                                                                           */
/*****************************************************************************/
                                                                               
#ifndef DIO_H                                                           
#define DIO_H                                                           
                                                                               
/*****************************************************************************/
/* Include definitions                                                       */
/*****************************************************************************/
#include "typedefs.h"

/*****************************************************************************/
/* typedefs definitions                                                      */
/*****************************************************************************/
typedef enum {
  kBit0,
  kBit1,
  kBit2,
  kBit3,
  kBit4,
  kBit5,
  kBit6,
  kBit7,
} kBit;

typedef enum {
  kPortB,
  kPortC,
  kPortD,
  kNoMorePorts,
} kportn;

typedef enum {
  kInput,
  kOutput,
} kDirection;
                                                                               
/*****************************************************************************/
/* External macro definitions                                                */
/*****************************************************************************/
                                                                               
                                                                               
/*****************************************************************************/
/* External constant definitions                                             */
/*****************************************************************************/
                                                                               
                                                                               
/*****************************************************************************/
/* Prototype definitions for external access                                 */
/*****************************************************************************/
extern void SetDirection(kportn port, kDirection direction, kBit io, Boolean pullup);
extern void SetOutputValue(kportn port, kBit io, Boolean state);

#endif /* DIO_H */                                                     
                                                                               