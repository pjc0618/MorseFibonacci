		AREA Myprog, CODE, READONLY
		ENTRY
		EXPORT __main
			
;don't change these addresses!
PCR22 	  EQU 0x4004A058 ;PORTB_PCR22  address
SCGC5 	  EQU 0x40048038 ;SIM_SCGC5    address
PDDR 	  EQU 0x400FF054 ;GPIOB_PDDR   address
PCOR 	  EQU 0x400FF048 ;GPIOB_PCOR   address
PSOR      EQU 0x400FF044 ;GPIOB_PSOR   address

ten		  EQU 0x00000400 ; 1 << 10
eight     EQU 0x00000100 ; 1 << 8
twentytwo EQU 0x00400000 ; 1 << 22

__main
	; Your code goes here!
		MOV   R3, #7
		MOV   R7, #19
		MOV   R1, #0xbeef
		BL    LEDSETUP
		BL    test
		BL    LEDON
		B     forever
		
test
		PUSH   {LR}
		MOV    R0, #0
		BL     MorseDigit
		MOV    R0, #1
		BL     MorseDigit
		MOV    R0, #2
		BL     MorseDigit
		MOV    R0, #3
		BL     MorseDigit
		MOV    R0, #4
		BL     MorseDigit
		MOV    R0, #5
		BL     MorseDigit
		MOV    R0, #6
		BL     MorseDigit
		MOV    R0, #7
		BL     MorseDigit
		MOV    R0, #8
		BL     MorseDigit
		MOV    R0, #9
		BL     MorseDigit
		POP	   {LR}
		BX     LR

		
MorseDigit
		PUSH  {LR}
		;MOV   R1, #50000 ;Set r1 as loop variable
		CMP   R0, #5 ; determine which case to use
		BLE   LT
		BGT   GT
done	NOP
		POP   {LR}
		BX    LR
		
loop
		SUBS  R1, #1
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		BNE    loop
		BX     LR

		
LT
		PUSH  {R1, R2, R3, LR}
		MOV    R1, #5 ;use R1 as a constant for operations
		MOV    R2, R0 ;store number of dots in R2
		SUB    R3, R1, R0 ; store number of dashes in R3
		MOV    R1, #50000 ;Set loop counter
		BL     DOT
		BL     DASH
		POP    {R1, R2, R3, LR}
		B     	done
		
GT
		PUSH   {R1, R2, R3, LR}
		MOV    R1, #5
		SUB    R3, R0, R1
		SUB    R2, R1, R3
		MOV    R1, #50000
		BL     DASH
		BL     DOT
		POP    {R1, R2, R3, LR}
		B     	done
		
DOT
		CMP   R2, #0
		BEQ   fin1
        PUSH  {LR}
        BL    LEDON
		BL    loop
		MOV   R1, #50000
		BL    LEDOFF
		BL    loop
		MOV   R1, #50000
		BL    loop
		MOV   R1, #50000
		SUBS  R2, #1
		POP   {LR}
		B     DOT
fin1	BX     LR
DASH
		CMP   R3, #0
		BEQ   fin
		PUSH  {LR}
        SUBS  R3, #1
        BL    LEDON
		BL    loop
		MOV   R1, #50000
		BL    loop
		MOV   R1, #50000
		BL    loop
		MOV   R1, #50000
		BL    LEDOFF
		BL    loop
		MOV   R1, #50000
		POP   {LR}
		B     DASH
fin		BX    LR
fib		
	; Your code goes here!



		
; Call this function first to set up the LED
LEDSETUP
				PUSH  {R4, R5} ; To preserve R4 and R5
				LDR   R4, =ten ; Load the value 1 << 10
				LDR		R5, =SCGC5
				STR		R4, [R5]
				
				LDR   R4, =eight
				LDR   R5, =PCR22
				STR   R4, [R5]
				
				LDR   R4, =twentytwo
				LDR   R5, =PDDR
				STR   R4, [R5]
				POP   {R4, R5}
				BX    LR
				
; The functions below are for you to use freely      
LEDON				
				PUSH  {R4, R5}
				LDR   R4, =twentytwo
				LDR   R5, =PCOR
				STR   R4, [R5]
				POP   {R4, R5}
				BX    LR
				
LEDOFF				
				PUSH  {R4, R5}
				LDR   R4, =twentytwo
				LDR   R5, =PSOR
				STR   R4, [R5]
				POP   {R4, R5}
				BX    LR
				
forever
			B		forever						; wait here forever	
			END
 				
