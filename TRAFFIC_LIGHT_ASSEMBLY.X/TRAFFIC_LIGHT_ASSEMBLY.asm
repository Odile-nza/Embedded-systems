; PIC16F877A Configuration Bit Settings

; Assembly source line config statements

#include "p16f877a.inc"

; CONFIG
; __config 0xFFFB
 __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _BOREN_ON & _LVP_ON & _CPD_OFF & _WRT_OFF & _CP_OFF

 STATUS equ 03h;seelcting bank
 RP0 equ 05
 RP1 equ 06
 PORTB equ 06h;BANK0
 TRISB equ 86h;BANK1
 COUNTER equ 20h
 org 00h
 clrw
 
 ;selecting BANK0
 BCF STATUS,RP0; RP0=0
 BCF STATUS,RP1; RP1=0
 CLRF PORTB; initialise PORTB
 
; switch to bank 1 for TRISB register
 BSF STATUS,RP0; RP0 =1

 MOVLW 0x00; clear W register
 MOVWF TRISB; set PORTB as output
 
 ;back to BANK0 for working with portB
 BCF STATUS,RP0; RP0=0
 BCF STATUS,RP1; RP1=0
 
 ; turns on all pins on PORTB
 SART MOVLW 0x02
      MOVWF PORTB; Turn on all pins on PORTB
      ;delay
      
      MOVLW 0xff;decimall 255
      MOVWF COUNTER ; set counter1 to oxff load the counter with 255
LOOP1 DECFSZ COUNTER
      GOTO LOOP1 ;if counter is zero then carry on
      
      CLRF PORTB
      MOVLW 0x04
      MOVWF PORTB; Turn OFF all pins on PORTB
      ;delay
      
      MOVLW 0xff
      MOVWF COUNTER ; set counter1 to oxff
      
LOOP2 DECFSZ COUNTER
      GOTO LOOP2      ;if counter is zero then carry on  
      
      CLRF PORTB
      MOVLW 0x08
      MOVWF PORTB; Turn OFF all pins on PORTB
      
      MOVLW 0xff;decimall 255
      MOVWF COUNTER ; set counter1 to oxff load the counter with 255
LOOP3 DECFSZ COUNTER
      GOTO LOOP3 ;if counter is zero then carry on
      
      
      GOTO SART
END	