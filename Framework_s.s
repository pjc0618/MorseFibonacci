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
		MOV   R0, #8
		MOV   R9, #50000
		BL    LEDSETUP
		CMP   R0, #5
		BEQ   B5
		BLT   LT
		BGT   GT
		B     forever

loop
		SUBS  R9, #1
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
		BNE   loop
		BX    LR
B5
		MOV   R6, #5
		MOV   R8, #0
		BL    DOT
		B     forever
		
LT
		PUSH   {R5}
		MOV    R5, #5
		MOV    R6, R0
		SUB    R8, R5, R0
		BL     DOT
		BL     DASH
		POP    {R5}
		B      forever
		
GT
		PUSH    {R5}
		MOV    R5, #5
		SUB    R8, R0, R5
		SUB    R6, R5, R8
		BL     DASH
		BL     DOT
		POP    {R5}
		B     forever
		
DOT
		CMP   R6, #0
		BEQ   fin1
        PUSH  {LR}
        BL    LEDON
		BL    loop
		MOV   R9, #50000
		BL    LEDOFF
		BL    loop
		MOV   R9, #50000
		BL    loop
		POP   {LR}
		MOV   R9, #50000
		SUBS  R6, #1
		B     DOT
fin1	BX    LR
DASH
		CMP   R8, #0
		BEQ   fin
		PUSH  {LR}
        SUBS  R8, #1
        BL    LEDON
		BL    loop
		MOV   R9, #50000
		BL    loop
		MOV   R9, #50000
		BL    loop
		MOV   R9, #50000
		BL    LEDOFF
		BL    loop
		MOV   R9, #50000
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
 				
