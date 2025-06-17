.code16
.section ".text", "ax" # section name, attributes ( allocatablem executable )

# real mode ( 64 kB )
# physical Address = (segment register value * 16) + Offset 
# Offsset <= 64kB
# specific segment registers for code ( %cs ), data ( %ds ), string operands ( extra segment (%es) )

# define start symbol for linker
.globl	_start

_start:
	# setup segment registers
	# copy code segment
	mov 	%cs, %ax
	# data segement = code segment
	mov 	%ax, %ds
	# extra segment register
	mov 	%ax, %es
	# stack pointer = code segment 
	mov		%ax, %ss

	# zero stack pointer
	xorw	%sp, %sp
	sti
	cld
	mov	$hello_world_msg, %si

msg_loop:
	lodsb # load 
	andb	%al, %al
	jz	die
	movb	$0xe, %ah
	movw	$7, %bx
	int	$0x10
	jmp	msg_loop

die:
	# Allow the user to press a key, then reboot
	xorw	%ax, %ax
	int	$0x16
	cld

hello_world_msg:
	.ascii	"Hello World.\r\n"
	.ascii	"\n"
	.ascii	"We are done...\r\n"
	.byte	0






