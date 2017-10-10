/* -- ARM */

/* -- DATA SECTION */

.data

/* CONTROL VARIABLES */
.balign 4/*return variable*/
mrval: .word 0

/* -- STRINGS */
.balign 4
msprompt: .asciz "Data 1: \n"
.balign 4
msprompt2: .asciz "Data 2: \n"
.balign 4 /* null prompt to fix seg fault */
mnullp: .asciz "\n"


/* -- PROGRAM SECTION */
.text

@ Assumes data is in r0, value in r1
init_chunk:
    push    {r2, lr}
    mov		r2, #0 @index
init_chunk_loop:
	str		r1, [r0, r2]
	add 	r2, r2, #4
	cmp 	r2, #100
	bne 	init_chunk_loop
    pop     {r2, pc}

@ Data address in r0
print_data:
	push    {r2-r3, lr}
    mov		r2, #0 @index
print_data_loop:
	ldr		r3, [r0, r2]
	add 	r2, r2, #4

	@ print the value
	push	{r0, r1}
	ldr 	r0, =format_hex
	mov 	r1, r3
	pop	 	{r0, r1}

	cmp 	r2, #100
	bne 	init_chunk_loop
    pop     {r2-r3, pc}


.global main

/* =============== */
/* -- PROGRAM MAIN */
/* =============== */
main:
	@ Store return value
	ldr 	r1, rval
	str 	lr, [r1]

	@ print intro
	ldr		r0,	sprompt
	bl		printf 

	@ get outta here. 
	ldr 	lr, rval
	ldr 	lr, [lr]
	bx 		lr


/* -- VARIABLE DEFINITIONS (addresses) */
sprompt		: .word msprompt
sprompt2	: .word msprompt2

rval: .word mrval

/* -- EXTERNALS */
.global printf
.global scanf


