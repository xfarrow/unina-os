# Boot text
mov ah, 0x0e
mov al, 'U'
int 0x10
mov ah, 0x0e
mov al, 'n'
int 0x10
mov ah, 0x0e
mov al, 'i'
int 0x10
mov ah, 0x0e
mov al, 'n'
int 0x10
mov ah, 0x0e
mov al, 'a'
int 0x10
mov ah, 0x0e
mov al, '-'
int 0x10
mov ah, 0x0e
mov al, 'O'
int 0x10
mov ah, 0x0e
mov al, 'S'
int 0x10
# print new line
mov ah, 0x0e
mov al, 10
int 0x10
mov ah, 0x0e
mov al, 13
int 0x10

mov ah, 0x0e
mov bx, Description_text + 0x7c00
Print_description:
  mov al , [bx]
  cmp al, 0
    je exit_description
  int 0x10
  inc bx
  jmp Print_description

exit_description:

# prints the alphabet
mov ah, 0xe
mov al, 'A' - 1
print_alphabet:
  inc al
  cmp al, 'Z' + 1
  je exit_printing_alphabet
  int 0x10
  jmp print_alphabet
exit_printing_alphabet:

Description_text:
  db "The only thing that this OS does is printing the alphabet. Wow."
  db 10
  db 13
  db 0

# bootable sector
jmp $
times 510-($-$$) db 0
db 0x55, 0xaa
