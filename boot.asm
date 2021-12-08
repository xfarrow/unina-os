;
; REGION
; Boot text (Unina-OS) 
;
;
mov ah, 0x0e ; 0x0e must be in the ah in order to be able to print

mov al, 'U'
int 0x10 ; interrupt which triggers an output on screen of the value stored in al register

mov al, 'n'
int 0x10

mov al, 'i'
int 0x10

mov al, 'n'
int 0x10

mov al, 'a'
int 0x10

mov al, '-'
int 0x10

mov al, 'O'
int 0x10

mov al, 'S'
int 0x10

mov al, 10 ; new line
int 0x10

mov al, 13 ; carriage return
int 0x10


;
; REGION
; Prints unina-os description (stored from address Description_text)
;
;
mov ah, 0x0e
mov bx, Description_text + 0x7c00 ; the offset is always 0x7c00 I don't know why. bx contains the value of the pointer
Print_description:
  mov al , [bx] ; mov in al the value pointed by bx (in C it'd be al = *bx)
  cmp al, 0 ; check if we have reached the end of the string
    je exit_description
  int 0x10
  inc bx ; add 1 to the value of the pointer bx so it points to the next character
  jmp Print_description

Description_text:
  db "The only thing that this OS does is printing the alphabet. Wow."
  db 10 ; new line
  db 13 ; carriage return
  db 0  ; end of string

;
; Data and code are the same thing, so Description_text code block just places
; (thanks to the db instruction) arbitrary data in memory. Print_description
; will read this data byte by byte.
; You can view this by imaging the memory like an array where the entire program
; gets loaded and some parts are data and others are code.
;

exit_description:

;
; REGION
; prints the alphabet
;
;
mov ah, 0xe
mov al, 'A' - 1
print_alphabet:
  inc al
  cmp al, 'Z' + 1
  je exit_printing_alphabet
  int 0x10
  jmp print_alphabet
exit_printing_alphabet:

;
; REGION
; Simple stack operations
;
;
mov bp, 0x8000 ; base pointer (tail)
mov sp, 0x8000  ; stack pointer, same as tail since it's empty
mov bh, 'A' 
push bx  ; push onto stack register B

mov bh, 'B'

; print 'B' while 'A' being on stack
mov al, 10 ; new line
int 0x10
int 0x10
mov al, 13 ; carriage return
int 0x10

mov al, bh
mov ah, 0x0e
int 0x10

pop bx

; print value stored on stack
mov al, bh
mov ah, 0x0e
int 0x10

;
; REGION
; Procedure
;
;
call Procedure ; the stack gets managed automatically thanks to pusha and popa
mov ah, 0x0e 
mov al, 'y'
int 0x10
jmp Exit

Procedure: ; prints 5 times 'x'
  mov ah, 0x0e 
  mov al, 'x'
  int 0x10 
  int 0x10 
  int 0x10 
  int 0x10 
  int 0x10
  ret

Exit: 
mov ah, 0x0e 
mov al, 'k'
int 0x10



;
; REGION
; Bootable sector
;
;
jmp $ ; useless, jumps on the next instruction
times 510-($-$$) db 0
db 0x55, 0xaa
