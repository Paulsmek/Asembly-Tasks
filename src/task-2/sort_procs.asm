%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
	
	; Rezolvarea taskului 2 exercitiul 1 consta in aplicarea
	; unui bubble sort pe vectorul de structuri conform 
	; conditiilor de soratare (prio, time, pid) in ordine
	
	xor ecx,ecx ; ecx e 0 pentru primul loop
		
loop1_start:
	xor esi,esi
	mov esi, eax
	sub esi, 1
	cmp ecx, esi ; loop de la 0 la n-1 (n = length)  
 	jge loop1_end
  
 	xor ebx,ebx ; ebx e 0 pentru al doilea loop  	
loop2_start:
	xor esi,esi
	mov esi, eax
	sub esi, ecx 
	sub esi, 1
 	cmp ebx, esi ; loop de la 0 la n-i-1 (n = length, i = ecx)
 	jge loop2_end

calc_prio:	
	; compar prio
	xor edi,edi
	mov edi , ebx
	imul edi, proc_size
	add edi, edx
	push ebx
	mov bl, byte[edi + proc.prio] ; primul prio
	mov bh, byte[edi + proc_size + proc.prio] ; al doilea prio
	
	; compar pentru cazurile de prio
	cmp bl, bh
	jl move2_on
	cmp bl, bh
	jg mai_mare_swapp
	cmp bl, bh
	je calc_time
	
calc_time:
	; compar time 
	mov bx, word[edi + proc.time] ; primul time
	mov si, word[edi + proc_size + proc.time] ; al doilea time
	
	; compart pentru cazurile de time
	cmp bx, si
	jl move2_on
	cmp bx, si
	jg mai_mare_swapp
	cmp bx, si
	je calc_pid
	
calc_pid:
	; compar pid
	mov bx, word[edi + proc.pid] ; primul pid
	mov si, word[edi + proc_size + proc.pid] ; al doilea pid
	
	; compar pentru cazurile de pid
	cmp bx, si
	jle move2_on
	cmp bx, si
	jg mai_mare_swapp
	
mai_mare_swapp:
	; fac swapp in cazul in care elementele nu sunt ordonate
	
	; swapp de prio
	mov bl, byte[edi + proc.prio] 
	mov bh, byte[edi + proc_size + proc.prio]
	mov byte[edi + proc.prio], bh
	mov byte[edi + proc_size + proc.prio], bl
	
	; swapp de pid
	push ecx
	mov bx, word[edi + proc.pid] 
	mov cx, word[edi + proc_size + proc.pid]
	mov word[edi + proc.pid], cx
	mov word[edi + proc_size + proc.pid], bx
	
	; swapp de time
	mov bx, word[edi + proc.time] 
	mov cx, word[edi + proc_size + proc.time]
	mov word[edi + proc.time], cx
	mov word[edi + proc_size + proc.time], bx
	pop ecx
	
move2_on:
	pop ebx
	inc ebx     ; adun la ebx pentru loop
	jmp loop2_start

loop2_end: 
 	 
move1_on:
   	inc ecx       ; adun la ecx pentru loop
  	jmp loop1_start
 	
loop1_end:

  


    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
