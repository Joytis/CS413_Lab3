/* -- ARM */

/* -- DATA SECTION */

.data

/* CONTROL VARIABLES */
.balign 4 /* price of a soda */
mprice: .word 		55
.balign 4/*return variable*/
mrval: .word			0
.balign 4/*input variable*/
minput: .word		0

/* -- COIN VALUES */
.balign 4 /* penny */
mpenny: .word 		1
.balign 4 /* nickel */
mnickel: .word 		5
.balign 4 /* dime */
mdime: .word 		10
.balign 4 /* quarter */
mquarter: .word 		25
.balign 4 /* 50c piece */
mfcp: .word 			50
.balign 4 /* dollar */
mdollar: .word  		100
.balign 4 /* slug(?) */
mslug: .word 		0

/* -- STRINGS */
.balign  4 /* input format for scanf */
minputformat: .asciz "%s"
.balign  4 /* Prompt */
mprompt: .asciz "Enter coin or select return.\n"
.balign 4
msprompt: .asciz "Data 1: \n"
.balign 4
msprompt2: .asciz "Data 2: \n"
.balign 4 /* total  prompt */
mtprompt: .asciz "Total is %d cents.\n\n"
.balign 4 /* returning  prompt */
mretprompt: .asciz "Returning all change!\n"
.balign 4 /* returning  prompt */
mpcarat: .asciz "> "
.balign 4 /* coke  prompt */
mscoke: .asciz "Selection is Coke\n"
.balign 4 /* spr  prompt */
mssprite: .asciz "Selection is Sprite\n"
.balign 4 /* dp  prompt */
msdp: .asciz "Selection is Dr. Pepper\n"
.balign 4 /* dcoke  prompt */
msdietcoke: .asciz "Selection is Diet Coke\n"
.balign 4 /* my  prompt */
msmy: .asciz "Selection is Mellow Yellow\n"
.balign 4 /* change  prompt */
mchange: .asciz "Returning %d cents as change!\n"
.balign 4 /* change  prompt */
moutchoice: .asciz "The machine is out of this selection!\n"

.balign 4 /* null prompt to fix seg fault */
mnullp: .asciz "\n"


/* -- PROGRAM SECTION */
.text
.global main

/* =============== */
/* -- PROGRAM MAIN */
/* =============== */
main:
	/* print out intro message */
	ldr		r0,	sprompt
	bl		printf 

	bx 		lr


/* -- VARIABLE DEFINITIONS (addresses) */
price		: .word mprice
rval			: .word mrval
input		: .word minput

penny	 	: .word mpenny
nickel	 	: .word mnickel
dime 		: .word mdime 		
quarter		: .word mquarter
fcp	 		: .word mfcp 			
dollar 		: .word mdollar 		
slug 		: .word mslug

inputformat 	: .word minputformat
sprompt		: .word msprompt
prompt 		: .word mprompt
tprompt 		: .word mtprompt
retprompt	: .word mretprompt
pcarat 		: .word mpcarat
pchange 	: .word mchange
outchoice	: .word moutchoice
nullp		: .word mnullp

scoke		: .word mscoke
ssprite		: .word mssprite
sdp			: .word msdp
sdietcoke	: .word msdietcoke
smy		: .word msmy

/* -- EXTERNALS */
.global printf
.global scanf


