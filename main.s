/* -- ARM */

/* -- DATA SECTION */

.data

/* CONTROL VARIABLES */
.balign 4/*return variable*/
rval: .word 0
data1: .space 100
data2: .space 100

/* -- STRINGS */
.balign 4
sprompt: .asciz "Data 1: \n"
sprompt2: .asciz "Data 2: \n"
testp: .asciz "Init Chunk %d\n"
format_hex: .asciz "%x"
prompt_carat: .asciz "> "
prompt_endl: .asciz "\n"
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
	push	{r0-r2}
	ldr 	r0, =format_hex
	mov 	r1, r3
	bl 		printf
	pop	 	{r0-r2}

	cmp 	r2, #100
	bne 	print_data_loop
    pop     {r2-r3, pc}


.global main

/* =============== */
/* -- PROGRAM MAIN */
/* =============== */
main:
	@ Store return value
	ldr 	r1, =rval
	str 	lr, [r1]

	ldr		r0,	=data1
	ldr 	r1, =0xAAAAAAAA
	bl		init_chunk 

	ldr		r0,	=data2
	ldr 	r1, =0xBBBBBBBB
	bl		init_chunk

	@ print intro
	ldr		r0,	=sprompt
	bl		printf 
	ldr 	r0, =data1
	bl		print_data 

	@ print intro
	ldr		r0,	=sprompt2
	bl		printf 
	ldr 	r0, =data2
	bl		print_data 


	@ get outta here. 
	ldr 	lr, =rval
	ldr 	lr, [lr]
	bx 		lr


/* -- VARIABLE DEFINITIONS (addresses) */

/* -- EXTERNALS */
.global printf
.global scanf


