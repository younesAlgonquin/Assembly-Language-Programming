; BIG_E_Reverse_Sorted.asm
;
; Author(s):                                    Younes Boutaleb
; Student Number(s):                            041019068
; Date:                                         08/11/2021

; Purpose                                       Sort a big Endian data array


OFFSET  equ     2


        org     $1000
Little_Endian                                   ; Array of 16 bit Little Endian words
        dw      $1234, $2888, $AA55, $00FF, $FF00, $55AA, $0101,$FF00
End_Little_Endian
                                		; Destination Array goes starting here
                                		; where ds.w reserve a Word (16 bytes)
                                		; and LEN of the array is dynamically
                                		; calculated as taught in class, keeping in mind
                                		; that the ds statement should reserve bytes
                                		; of memory, not words of memory.

Big_Endian                                      ; Dynamically allocate memory to the array equal to Little_Endian array size
        ds        End_Little_Endian-Little_Endian

End_Big_Endian
Reverse
        ds        End_Little_Endian-Little_Endian
End_Reverse

        org     $2000                           ; Program code
        lds     #$2000                          ; Stack initialization

;Å--- Start of convert to Big_Endian code Å---

        ldx     #Little_Endian                  ; Pointer X points to the beginning of Little_Endian array
        ldy     #Big_Endian                     ; Pointer X points to the beginning of Big_Endian array
Read    ldd     OFFSET,x+                       ; load register D with a word pointed to by X then increment X to the next word
        EXG     a,b                             ; Exchange registers A and B data
        std     OFFSET,y+                       ; Store new data at register D at the position pointed to by pointer Y

        cpx     #End_Little_Endian              ; Move to the next word if pointer X is still within the array
        blo     Read




;Å--- Start of Copy and Reverse Big Endian Array Code Å---

        ldx     #Reverse                        ; Pointer X points to the beginning of array that will store reversed array
        ldy     #End_Big_Endian-1               ; Pointer Y points to the end of the array to be reversed
Loop    ldaa    1,y-                            ; Register A Take the last element of the array
        staa    1,x+                            ; and store it in the first memory location of the new memory space
        cpx     #End_Reverse                    ; Move to the next word if pointer X is still within the array
        blo     Loop


        
;Å--- Start of sort Array codeÅ---



   	ldy    	#Reverse+1                      ; Pointer Y points to the beginning of array to be sorted
ToRight	tfr     y,x                             ; Pointer X points to the same location as Y
	iny                                     ; Pointer Y moves to the next memory location

	ldaa    0,x                             ; Register A Take data pointed to by X
ToLeft	cmpa	1,-x                            ; compare it with the previous memory location data
	blo 	Sort                           ; Go to block of code back1 if its lower
	inx                                     ; If not X moves back to its previous location.
	bra 	Store                           ; Jump to block of code Back4.


Sort	ldab    0,x                             ; Overwrite the lower value by the previous bigger value.
	stab	1,x
	cpx 	#Reverse                        ; Move back to the previous memory location if its within the array
	bhi  	ToLeft

Store   staa    0,x                             ; Store current data in register A at beginnig of the array or after the first lower value.
        cpy     #End_Reverse                    ; Move to the next memory location if Y still within the array
        blo     ToRight

        swi                                     ; forces program to quit executing in memory
        end