/* -- ARM */

/* -- DATA SECTION */

.data

/* CONTROL VARIABLES */
.balign 4/*return variable*/
rval: .word 0
data1: .space 100
data2: .space 100
input: .word 0
trash: .word 0

/* -- STRINGS */
.balign 4
sprompt: .asciz "0x00000000: \n"
sprompt2: .asciz "0x00000064: \n"
testp: .asciz "Init Chunk %d\n"
pr_cpdata: .asciz "COPYDATA\n"
pr_srcadr: .asciz "source_address: "
pr_dstadr: .asciz "dest_address: "
pr_length: .asciz "length: "
format_hex: .asciz "%x"
format_hex_n: .asciz "%x\n"
format_str: .asciz "%"
carat: .asciz "> "
endl: .asciz "\n"


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

@Print the prompts
user_prompt:
	push 	{r0, lr}

	@ print intro data1
	ldr		r0,	=sprompt
	bl		printf 
	ldr 	r0, =data1
	bl		print_data 
	ldr		r0,	=endl
	bl		printf 

	@ print intro data2
	ldr		r0,	=sprompt2
	bl		printf 
	ldr 	r0, =data2
	bl		print_data 
	ldr		r0,	=endl
	bl		printf 

	ldr		r0,	=pr_cpdata
	bl		printf 

    pop     {r0, pc}

@ flushes the input
flush: 
	push 	{r0, r1, lr}
	ldr 	r0, =format_str
	ldr 	r1, =trash
    pop     {r0, r1, pc}


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

	@ prompt stuff
	bl 		user_prompt

	ldr 	r0, =pr_srcadr
	bl 		printf
	ldr 	r0, =format_hex
	ldr  	r1, =input
	bl 		scanf

	ldr 	r0, =format_hex_n
	ldr  	r1, =input
	ldr  	r1, [r1]
	bl 		printf

	ldr 	r0, =pr_dstadr 
	bl 		printf
	ldr 	r0, =format_hex
	ldr  	r1, =input
	bl 		scanf

	ldr 	r0, =pr_length
	bl 		printf
	ldr 	r0, =format_hex
	ldr  	r1, =input
	bl 		scanf





	@ get outta here. 
	ldr 	lr, =rval
	ldr 	lr, [lr]
	bx 		lr


/* -- VARIABLE DEFINITIONS (addresses) */

/* -- EXTERNALS */
.global printf
.global scanf


