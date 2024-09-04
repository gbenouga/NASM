section .data
    prompt1 db 'Enter first number: ', 0
    prompt2 db 'Enter second number: ', 0
    result_msg db 'The sum is: ', 0
    newline db 0Ah, 0    ; Nouvelle ligne pour meilleure lisibilité

section .bss
    num1 resb 4          ; Espace pour stocker le premier nombre
    num2 resb 4          ; Espace pour stocker le deuxième nombre
    result resb 4        ; Espace pour stocker le résultat

section .text
    global _start

_start:
    ; Afficher le prompt pour le premier nombre
    mov eax, 4          ; sys_write
    mov ebx, 1          ; STDOUT
    mov ecx, prompt1
    mov edx, 21         ; Longueur du prompt
    int 0x80

    ; Lire le premier nombre
    mov eax, 3          ; sys_read
    mov ebx, 0          ; STDIN
    mov ecx, num1
    mov edx, 4
    int 0x80

    ; Afficher le prompt pour le deuxième nombre
    mov eax, 4          ; sys_write
    mov ebx, 1          ; STDOUT
    mov ecx, prompt2
    mov edx, 22         ; Longueur du prompt
    int 0x80

    ; Lire le deuxième nombre
    mov eax, 3          ; sys_read
    mov ebx, 0          ; STDIN
    mov ecx, num2
    mov edx, 4
    int 0x80

    ; Convertir les entrées en nombres
    movzx eax, byte [num1]
    sub eax, '0'
    movzx ebx, byte [num2]
    sub ebx, '0'

    ; Additionner les deux nombres
    add eax, ebx

    ; Convertir le résultat en chaîne de caractères
    add eax, '0'
    mov [result], al

    ; Afficher le résultat
    mov eax, 4          ; sys_write
    mov ebx, 1          ; STDOUT
    mov ecx, result_msg
    mov edx, 13
    int 0x80

    mov eax, 4          ; sys_write
    mov ebx, 1          ; STDOUT
    mov ecx, result
    mov edx, 1
    int 0x80

    ; Afficher une nouvelle ligne
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Terminer le programme
    mov eax, 1          ; sys_exit
    xor ebx, ebx
    int 0x80