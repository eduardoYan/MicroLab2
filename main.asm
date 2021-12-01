
; PIC16F887 Configuration Bit Settings

; Assembly source line config statements

#include "p16f887.inc"

; CONFIG1
; __config 0xFFF4
 __CONFIG _CONFIG1, _FOSC_INTRC_NOCLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON & _LVP_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF



RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

UDATA 0X20
    DELAY RES 1

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

START
    BSF STATUS, RP0
    CLRF TRISB
    BSF STATUS, RP1
    CLRF ANSEL
    BCF STATUS, RP1
    BCF STATUS, RP0
    MOVLW 0X00
    MOVWF FSR

LOOP
    NOP
    MOVF FSR,0
    MOVWF PORTB
    ADDLW 0X01
    MOVWF FSR
    MOVLW 0X04
    MOVWF DELAY
    CALL DELAY_40
    GOTO LOOP

DELAY_40
    DECFSZ DELAY,F
    CALL DELAY_40
    RETURN

    END