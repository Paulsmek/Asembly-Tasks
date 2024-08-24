%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here

	; Rezolvarea taskului consta in parcurgerea vectorului cu
	; un for si de a codifica conform cerintei
	
    xor eax, eax ; eax e 0, cu care "parcurg" stringul
loop_start:
	cmp eax, ecx  ; conditia pentru loop
  	jge loop_end  
  	mov bl, byte [esi+eax] ; byte-ul din input string
  	; verific daca este intre A si Z
  	cmp bl, 'A'
   	jl move_on
  	cmp bl, 'Z'
   	jg move_on 
   	
   	; shiftez bitul
	add bl, dl 
   	
   	; daca e mai mic sau egal cu Z e bine
   	cmp bl, 'Z'
   	jle add_string
  	sub bl, 26 ; merg din nou de la A
    
add_string:
   	; pun bitul in string
   	mov byte [edi+eax], bl
    
move_on:
   	inc eax       ; adun la eax
  	jmp loop_start
loop_end:


    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
