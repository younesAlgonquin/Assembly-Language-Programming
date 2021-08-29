; Counter_$0-$F.asm
;
; Author:                                       Younes Boutaleb
; Course:                                       CST8216 Processor Architecture
; Student Number:                               041019068
; Date:                                         07/14/2021

#include C:\68hcs12\registers.inc


; Program Constants

STACK           equ     $2000

; Delay Subroutine Value

DELAY_VALUE     equ     250                     ; Delay value (base 10) 0 - 255 ms
                                                ; 125 = 1/8 second, 250 = 1/4 second
; End of Count Value

END_COUNT       equ     $F                      ; Last value of Count

; Start of Count Value

START_COUNT     equ     $0                      ; First value of Count

                org     $2000                   ; program code
Start           lds     #STACK                  ; stack location


; Configure the Ports

                jsr     Config_SWs_and_LEDs     ;implement the Config_SWs_and_LEDs.asm library

; Continually Count $0 - $F...$0 - $F

Loop         	ldab    START_COUNT             ;load register b with $0

; Flash LED

Back         	stab    portb                   ;appropruate PB Leds ON
                ldaa    #250                    ;250 ms delay
                jsr     Delay_ms                ;implement the Delay_ms.asm library


                incb                            ;increment register b
                cmpb    #END_COUNT              ;compare register b value to $F
                bls     Back                    ;brach if register b value lower or same
                bra     Loop                    ;brach if register b value is higher

                
; Library Files
#include C:\68HCS12\Lib\Delay_ms.asm
#include C:\68HCS12\Lib\Config_SWs_and_LEDs.asm

                end