%include "../include/io.mac"

    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;
struc avg
	.quo resw 1
	.remain resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    
    ; Pentru fiecare prio posibil (for de la 1 la 5)
    ; calculez suma de time si numarul de elemente, apoi
    ; fac impartirea .
    ; Voi parcurge de 2 ori vectorul, o data pentru suma si a doua 
    ; pentru elemente, ceea ce nu este prea bine din punct de vedere al 
    ; timpului de executie
	
	xor esi,esi ; esi e 0 pentru loop
	inc esi
	
	; loop de la 1 la 5 pentru fiecare prio
loop1_start:
	cmp esi, 5 ; conditia de loop
	jg loop1_end
		
	xor edx,edx
	xor edi,edi ; suma de timp pentru prio curent

	; parcurg elementele din vectorul de structuri
loop2_start:
 	cmp edx, ebx  ; conditia de loop
 	je loop2_end
 	push ebx
 	xor ebx,ebx
	mov ebx , edx
	imul ebx, proc_size
	add ebx, ecx
	
	push ecx
	mov ecx, esi
	mov ch, byte[ebx + proc.prio] ; prio-ul elementului curent din vector
	
	; compar prio-ul curent cu cel de care am nevoie
	cmp ch,cl
	jg move2_on
	cmp ch,cl
	jl move2_on
	xor ecx,ecx
	mov cx, word[ebx + proc.time] ; daca am nevoie de el adun 
	add di, cx
	
move2_on:
	pop ecx
	pop ebx
	inc edx ; adun la edx pentru loop
	jmp loop2_start
	
loop2_end:
	push eax
	mov eax, edi ; suma de timp o voi pastra in eax
	
	xor edx,edx
	xor edi,edi ; acum in edi voi numara elementele cu prio-ul meu

	; parcurg din nou vectorul
loop3_start:
 	cmp edx, ebx ; conditia de loop
 	je loop3_end
 	push ebx
 	xor ebx,ebx
	mov ebx , edx
	imul ebx, proc_size
	add ebx, ecx
	
	push ecx
	mov ecx, esi
	mov ch, byte[ebx + proc.prio] ; prio-ul elementului curent din vector
	
	; compar prio-ul curent cu cel de care am nevoie
	cmp ch,cl
	jg move3_on
	cmp ch,cl
	jl move3_on
	inc edi ; maresc numarul de elemente daca este bun
	
move3_on:
	pop ecx
	pop ebx
	inc edx ; adun la edx pentru loop
	jmp loop3_start
	
loop3_end:
	; cazul cu impartirea la 0
	cmp edi, 0
	je skipperinio
	
	; pregatesc impartirea 
	push ecx
	push edx
	mov ecx,edi
	xor edx,edx
	div cx
	
	; in eax am catul si in edx restul
	mov ecx,eax ; pastrez in ecx restul 
	mov eax, [ebp + 16] ; "refac" eax ca la inceput (proc_avg)
	push ebx
	mov ebx,esi
	dec ebx
	mov word[eax + ebx*4 + avg.quo], cx ; adaug catul
	mov word[eax + ebx*4 + avg.remain], dx ; adaug restul
	pop ebx
	pop edx
	pop ecx
	pop eax
	jmp move1_on
	

skipperinio:
	; cazul cu impartire la 0
	push ebx
	mov ebx,esi
	dec ebx
	mov eax, [ebp + 16]
	
	; adaug 0 la ambele
	mov word[eax + ebx*4 + avg.quo], 0
	mov word[eax + ebx*4 + avg.remain], 0
	pop ebx	
	pop eax
move1_on:
	inc esi ; conditia de loop
	jmp loop1_start
	
loop1_end:

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
