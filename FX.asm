; FX.asm
;
; Author:                               Younes Boutaleb
; Course:                               CST8216 Spring 2021
; Student Number:                       041019068
; Date:                                 07/19/2021
;
; Purpose:      			To illustrate how to solve an equation such as:
;               			f(x) = 3x +5 for x = 0 to 9, using a LookUp table at $1000
;               			x values will be place in the X_Values array
;               			precalculated f(x) values will be placed into the Results array

LEN     equ     End_Lookup-LookUp       ; Lookup array length
OFFSET  equ     $10

        org     $1000                   ; origin for Lookup array data
LookUp
        db      5, 8, 11, 14, 17, 20, 23, 25, 29, 32
End_Lookup

        org     $1010                   ; origin for X_Values array data
X_Values
        ds     End_Lookup-LookUp
End_X_Values

        org     $1020                   ; origin for Results array data
Results
        ds      End_Lookup-LookUp
End_Results

        org     $2000                    ; program code
        lds     #$2000          `        ; Stack initialization
        ldx     #LookUp                  ; Pointer X points to the beginning of LookUp array
        ldy     #X_Values                ; Pointer X points to the beginning of X_Values array
                                         ; register
                                         ; load register a with $00 (stores the array index)
        ldaa    #$00

;Loop block
Loop    ldab    A,X                      ; load register b with data at index a of Lookup array
        clr     A,X                      ; clear data at index a of Lookup array
        stab    OFFSET,Y                 ; store register b content at memory location stored at register y + OFFSET
        staa    1,Y+                     ; store register b content at memory location stored at register y then increment y
        inca                             ; increment register a
        cmpa    #LEN                     ; compare register a to #LEN
        bne     Loop                     ; go back to Loop block if register a is not equal

        swi                             ; forces program to quit executing in memory
        end


