section .bss
    firstElement resd 1
    d resd 1
    n resd 1
    m resd 1
    ap resd 100       ; Reserve space for up to 100 elements
    closestLow resd 1
    closestHigh resd 1

section .text
    global _start

_start:
    ; Input firstElement
    mov eax, 4                  ; syscall: sys_write
    mov ebx, 1                  ; file descriptor: stdout
    mov ecx, msg1               ; message to write
    mov edx, len_msg1           ; message length
    int 0x80

    call read_int               ; read firstElement
    mov [firstElement], eax

    ; Input d
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len_msg2
    int 0x80

    call read_int
    mov [d], eax

    ; Input n
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len_msg3
    int 0x80

    call read_int
    mov [n], eax

    ; Input m
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, len_msg4
    int 0x80

    call read_int
    mov [m], eax

    ; Calculate AP
    mov ecx, 0                  ; i = 0
    mov eax, [firstElement]     ; eax = firstElement

calculate_ap:
    cmp ecx, [n]
    jge find_closest            ; if i >= n, jump to find_closest
    mov ebx, [d]
    imul ebx, ecx               ; ebx = i * d
    add eax, ebx                ; eax = firstElement + i * d
    mov [ap + ecx * 4], eax     ; store ap[i]
    inc ecx                     ; i++
    jmp calculate_ap

find_closest:
    mov ecx, 0                  ; reset i
    mov eax, [ap]               ; set closestLow to ap[0]
    mov [closestLow], eax
    mov [closestHigh], eax

check_closest:
    cmp ecx, [n]
    jge print_results            ; if i >= n, jump to print_results
    mov eax, [ap + ecx * 4]
    cmp eax, [m]
    jg set_high                  ; if ap[i] > m, set high
    mov [closestLow], eax        ; update closestLow
    inc ecx                      ; i++
    jmp check_closest

set_high:
    mov [closestHigh], eax       ; update closestHigh
    jmp print_results

print_results:
    ; Output closestLow and closestHigh
    ; Print closestLow
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, len_result_msg
    int 0x80

    ; Printing the closestLow and closestHigh will require additional code
    ; This is a placeholder for demonstration.

    ; Exit program
    mov eax, 1                  ; syscall: sys_exit
    xor ebx, ebx                ; return 0
    int 0x80

read_int:
    ; Implement reading an integer from stdin here
    ; This is a placeholder function.
    ret

section .data
msg1 db 'Enter the first element: ', 0
len_msg1 equ $ - msg1
msg2 db 'Enter d: ', 0
len_msg2 equ $ - msg2
msg3 db 'Enter n: ', 0
len_msg3 equ $ - msg3
msg4 db 'Enter m: ', 0
len_msg4 equ $ - msg4
result_msg db 'Closest elements: ', 0
len_result_msg equ $ - result_msg
