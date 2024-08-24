section .data

section .text
    global bonus

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    
    ; Ma ocup din nou de linii si coloane pe cazuri ca in task4
    ; Programul funcioneaza similar, singura diferenta este
    ; datorata impartirii in 2 int-uri (board)
    ; Astfel, pentru fiecare caz vad daca pun 1 in partea de sus
    ; sau de jos, calculand indicele si shiftand la stanga 1 pentru 
    ; a-i gasi locul potrivit 
coloana_1:      
    xor esi,esi
	mov esi, ebx
	dec esi
	cmp esi,0
	jge coloana_buna_1
coloana_2:
	xor esi,esi
	mov esi, ebx
	inc esi
	cmp esi,7
	jle coloana_buna_2
	jmp col2_final
	
coloana_buna_1:

linie_11:
	xor edi,edi
	mov edi,eax
	dec edi
	cmp edi, 0
	jge linie_buna_11
	
linie_12:	
	xor edi,edi
	mov edi,eax
	inc edi
	cmp edi, 7
	jle linie_buna_12
	jmp col1_final
	
linie_buna_11:
	; cazurile pentru memorare
	cmp edi,4
	jge board_0_11 ; cazul in care pun pe partea de sus
	jl board_1_11 ; cazul in care pun in partea de jos

board_0_11:
	; partea de sus 
	push eax
	mov eax,edi
	sub eax,4 ; calculul pentru indice
	add eax,ecx
	push ebx
	mov ebx,1
	push ecx
	mov ecx,esi
	shl ebx,cl ; shiftez la stanga pentru a adauga 1 in board
	add [eax], ebx ; adun pentru a obtine cei 2 de 1(daca e cazul)
	pop ecx
	pop ebx
	pop eax
	jmp linie_12

board_1_11:
	; partea de jos
	push eax
	mov eax,4
	add eax,edi ; calculul pentru indice
	add eax,ecx
	push ebx
	mov ebx,1
	push ecx
 	mov ecx,esi
	shl ebx,cl ; shiftez la stanga pentru a adauga 1 in board 
	add [eax], ebx ; adun pentru a obtine cei 2 de 1(daca e cazul)
	pop ecx
	pop ebx
	pop eax
	jmp linie_12

		
linie_buna_12:
	; cazurile pentru memorare
	cmp edi,4
	jge board_0_12 ; partea de sus
	jl board_1_12 ; partea de jos

board_0_12:
	; partea de sus
	push eax
	mov eax,edi
	sub eax,4 ; calculul pentru indice
	add eax,ecx
	push ebx
	mov ebx,1
	push ecx
	mov ecx,esi
	shl ebx,cl ; shiftarea la stanga
	add [eax], ebx ; adun pentru 1 in board
	pop ecx
	pop ebx
	pop eax
	jmp col1_final

board_1_12:
	; partea de jos
	push eax
	mov eax,4
	add eax,edi ; calculul pentru indice
	add eax,ecx
	push ebx
	mov ebx,1
	push ecx
	mov ecx,esi
	shl ebx,cl ; shiftarea la stanga 
	add [eax], ebx ; adun pentru 1 in board
	pop ecx
	pop ebx
	pop eax


col1_final:
	jmp coloana_2
		
coloana_buna_2:

linie_21:
	xor edi,edi
	mov edi,eax
	dec edi
	cmp edi, 0
	jge linie_buna_21
	
linie_22:	
	xor edi,edi
	mov edi,eax
	inc edi
	cmp edi, 7
	jle linie_buna_22
	jmp col2_final
	
linie_buna_21:
	cmp edi,4
	jge board_0_21 ; sus
	jl board_1_21 ; jos

board_0_21:
	; sus
	push eax
	mov eax,edi
	sub eax,4 ; indicele
	add eax,ecx
	push ebx
	mov ebx,1
	push ecx
	mov ecx,esi
	shl ebx,cl ; shiftarea
	add [eax], ebx ; adun 1 la board
	pop ecx
	pop ebx
	pop eax
	jmp linie_22

board_1_21:
	; jos
	push eax
	mov eax,4
	add eax,edi ; indicele
	add eax,ecx
	push ebx
	mov ebx,1
	push ecx
	mov ecx,esi
	shl ebx,cl ; shiftarea
	add [eax], ebx ; adun 1 la board
	pop ecx
	pop ebx
	pop eax
	jmp linie_22
		
linie_buna_22:	
	cmp edi,4
	jge board_0_22 ; sus
	jl board_1_22 ; jos

board_0_22:
	; sus
	push eax
	mov eax,edi
	sub eax,4 ; indicele
	add eax,ecx
	push ebx
	mov ebx,1
	push ecx
	mov ecx,esi
	shl ebx,cl ; shiftarea
	add [eax], ebx ; adun 1 la board
	pop ecx
	pop ebx
	pop eax
	jmp col2_final

board_1_22:
	; jos
	push eax
	mov eax,4
	add eax,edi ; indicele
	add eax,ecx
	push ebx
	mov ebx,1
	push ecx
	mov ecx,esi
	shl ebx,cl ; shiftarea
	add [eax], ebx ; adun 1 la board
	pop ecx
	pop ebx
	pop eax

col2_final:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
