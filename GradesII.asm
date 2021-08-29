; GradesII.asm
;
; Author:                               Younes Boutaleb
; Course:                               CST8216 Spring 2021
; Student Number:                       041019068
; Date:                                 07/19/2021
;
; Purpose:                              To Tally up the number of As, Bs, Cs, Ds and Fs
;                                       in a Grades Array as per 21S Flowchart for GradesII
;                                       which uses a Switch-Case approach

LEN     equ     End_Grades-Grades       ; Grades array length

        org     $1000                   ; origin for program data
Num_As: ds      1                       ; Number of 'A' in the file will be stored at memory location Num_As
Num_Bs: ds      1                       ; Number of 'B' in the file will be stored at memory location Num_Bs
Num_Cs: ds      1                       ; Number of 'C' in the file will be stored at memory location Num_Cs
Num_Ds: ds      1                       ; Number of 'D' in the file will be stored at memory location Num_Ds
Num_Fs: ds      1                       ; Number of 'F' in the file will be stored at memory location Num_Fs


        
        org     $1020                   ; file's data
        
Grades
#include Grades.txt                     ; Grades file supplied for assignment
End_Grades

; Expected Result
;              $103A $103B $103C $103D $103E  $103F
;                 5     3     2    3    NAP      3

; as shown in the sumulator



        org     $2000                    ; program code
        lds     #$2000          `        ; Stack initialization
        ldx     #Grades                  ; Pointer X points to the beginning of Grades array
        ldy     #$103A                   ; Pointer Y points to memory where the resulys will be stored
        ldab    #$00                     ; load register b with $00 (counter to count the number of iterations)



        
;Read block
Read    ldaa    1,x+                     ; load register a with data pointed to by X then increment X
        cmpa    #$41                     ; compare register a value to A charachter
        beq     Inc_As                   ; brach if register a value is equal
        cmpa    #$42                     ; compare register a value to B charachter
        beq     Inc_Bs                   ; brach if register a value is equal
        cmpa    #$43                     ; compare register a value to C charachter
        beq     Inc_Cs                   ; brach if register a value is equal
        cmpa    #$44                     ; compare register a value to D charachter
        beq     Inc_Ds                   ; brach if register a value is equal
        cmpa    #$46                     ; compare register a value to F charachter
        beq     Inc_Fs                   ; brach if register a value is equal

Inc_As  inc     Num_As                   ; Increment content of memory locatiom Num_As
        bra     Check                    ; go to Check block
Inc_Bs  inc     Num_Bs                   ; Increment content of memory locatiom Num_Bs
        bra     Check                    ; go to Check block
Inc_Cs  inc     Num_Cs                   ; Increment content of memory locatiom Num_Cs
        bra     Check                    ; go to Check block
Inc_Ds  inc     Num_Ds                   ; Increment content of memory locatiom Num_Ds
        bra     Check                    ; go to Check block
Inc_Fs  inc     Num_Fs                   ; Increment content of memory locatiom Num_Fs
        bra     Check                    ; go to Check block

;Check block
Check   incb                             ; Increment register b
        cmpb    #LEN                     ; compare register b to #LEN
        bne     Read                     ; go back to read block if register b is not equal

;Continue after breaking the loops
        ldaa    Num_As                    ; load register a with content of Num_As
        staa    1,y+                      ; store register a content at memory pointed by y then increment y
        ldaa    Num_Bs                    ; load register a with content of Num_Bs
        staa    1,y+                      ; store register a content at memory pointed by y then increment y
        ldaa    Num_Cs                    ; load register a with content of Num_Cs
        staa    1,y+                      ; store register a content at memory pointed by y then increment y
        ldaa    Num_Ds                    ; load register a with content of Num_Ds
        staa    2,y+                      ; store register a content at memory pointed by y then increment y
        ldaa    Num_Fs                    ; load register a with content of Num_Fs
        staa    1,y+
        
        clr     Num_As                    ; clear memory location Num_As
        clr     Num_Bs                    ; clear memory location Num_Bs
        clr     Num_Cs                    ; clear memory location Num_Cs
        clr     Num_Ds                    ; clear memory location Num_Ds
        clr     Num_Fs                    ; clear memory location Num_Fs


        swi                               ; forces program to quit executing in memory
        end