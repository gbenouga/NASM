section .data
    msg1 db 'Enter first number: ', 0
    msg2 db 'Enter second number: ', 0
    msg3 db 'Enter operation (+,-,*,/): ', 0
    result_msg db 'Result: ', 0
    div_error db 'Error: Division by zero!', 0Ah

section .bss
    num1 resb 4
    num2 resb 4
    operation resb 1
    result resb 4

section .text
    global _start

_start:
    ; Afficher le message pour le premier nombre
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 21
    int 0x80

    ; Lire le premier nombre
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 4
    int 0x80

    ; Afficher le message pour le deuxième nombre
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, 24
    int 0x80

    ; Lire le deuxième nombre
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 0x80

    ; Afficher le message pour l'opération
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, 28
    int 0x80

    ; Lire l'opération
    mov eax, 3
    mov ebx, 0
    mov ecx, operation
    mov edx, 1
    int 0x80

    ; Convertir les entrées en nombres (ASCII à entier)
    movzx eax, byte [num1]
    sub eax, '0'
    movzx ebx, byte [num2]
    sub ebx, '0'

    ; Effectuer l'opération
    cmp byte [operation], '+'
    je add_numbers

    cmp byte [operation], '-'
    je subtract_numbers

    cmp byte [operation], '*'
    je multiply_numbers

    cmp byte [operation], '/'
    je divide_numbers

    jmp end_program

add_numbers:
    add eax, ebx
    jmp show_result

subtract_numbers:
    sub eax, ebx
    jmp show_result

multiply_numbers:
    imul ebx
    jmp show_result

divide_numbers:
    cmp ebx, 0
    je division_error
    xor edx, edx
    div ebx
    jmp show_result

division_error:
    mov eax, 4
    mov ebx, 1
    mov ecx, div_error
    mov edx, 24
    int 0x80
    jmp end_program

show_result:
    ; Convertir le résultat en caractère
    add eax, '0'
    mov [result], al

    ; Afficher le résultat
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 8
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

end_program:
    ; Terminer le programme
    mov eax, 1
    xor ebx, ebx
    int 0x80