; Flash_PB0.asm
;
; Author:                               D. Haley
; Course:                               CST8216 Fall 2020
; S/N:                                  Faculty
; Date:                                 30 Oct 2020
;
; Modified by:                          Younes Boutaleb
; Student Number:                       041019068
; Date:                                 07/14/2021
;
; Purpose                               To Flash PB0 LED on Dragon 12+ Trainer

#include C:\68HCS12\registers.inc

; Program Constants
STACK   equ     $2000
PB0ON   equ     %00000001               ; 1 turns on LED, 0 turns off LED
PB0OFF  equ     %00000000               ; 1 turns on LED, 0 turns off LED


        org     $2000                   ; program code
Start   lds     #STACK                  ; stack location

; Configure the Ports
        jsr     Config_SWs_and_LEDs     ; implement the Config_SWs_and_LEDs.asm library

; Continually Flash LED

Back    ldaa    #PB0ON                  ;load register a with %00000001
        staa    portb                   ; PB0 ON
        ldaa    #250                    ; 250 ms delay
        jsr     Delay_ms                ; implement the Config_SWs_and_LEDs.asm library
        ldaa    #PB0OFF                 ; load register a with %00000000
        staa    portb                   ; PB0 OFF
        ldaa    #250                    ; 250 ms delay
        jsr     Delay_ms                ; implement the Delay_ms.asm library
        bra     Back                    ; endless loop

; Library Files

#include C:\68HCS12\Lib\Delay_ms.asm
#include C:\68HCS12\Lib\Config_SWs_and_LEDs.asm
        end