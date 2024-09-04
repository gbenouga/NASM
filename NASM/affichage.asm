section .data
    message db 'Hello, World!', 0Ah  ; Le texte à afficher suivi d'un saut de ligne
    len equ $ - message               ; Calculer la longueur du message

section .text
    global _start

_start:
    ; Écrire le message sur la sortie standard (stdout)
    mov eax, 4          ; Syscall numéro 4 (sys_write)
    mov ebx, 1          ; Descripteur de fichier 1 (stdout)
    mov ecx, message    ; Adresse du message
    mov edx, len        ; Longueur du message
    int 0x80            ; Appeler le noyau

    ; Terminer le programme
    mov eax, 1          ; Syscall numéro 1 (sys_exit)
    xor ebx, ebx        ; Code de sortie 0
    int 0x80            ; Appeler le noyau