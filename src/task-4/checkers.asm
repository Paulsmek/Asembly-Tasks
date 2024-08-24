
section .data

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    
    ; Voi trata fiecare caz in parte, adica
    ; modific coloana si apoi linia , deci am 4 cazuri
    
coloana_1:
	; coloana cu y-1
    xor esi,esi
	mov esi, ebx
	dec esi
	cmp esi,0
	jge coloana_buna_1 ; coloana se afla in dimensiuni
	; nu verific partea superioara deoarece scad dintr-o colana valabila
	
coloana_2:
	; coloana cu y+1
	xor esi,esi
	mov esi, ebx
	inc esi
	cmp esi,7
	jle coloana_buna_2 ; coloana se afla in dimensiuni
	jmp col2_final
	; nu verific partea inferioara deoarece cresc dintr-o colana valabila
	
coloana_buna_1:
	; cazul in care coloana 1 e buna 
	; ma ocup de cele doua linii posibile din acest caz
	
linie_11:
	; linia cu x-1
	xor edi,edi
	mov edi,eax
	dec edi
	cmp edi, 0 ; linia se afla in dimensiuni
	jge linie_buna_11
	
linie_12:
	; linia cu x+1	
	xor edi,edi
	mov edi,eax
	inc edi
	cmp edi, 7 ; linia se afla in dimensiuni
	jle linie_buna_12
	jmp col1_final ; nu e nicio linie valabila deci trec la urmatoarea coloana
	
linie_buna_11:
	; linia 1 coloana 1 buna, adaug in matrice 1
	push eax
	xor eax,eax
	mov eax,edi
	imul eax,8
	add eax,ecx
	mov byte[eax + esi], 1
	pop eax
	jmp linie_12
		
linie_buna_12:
	; linia 2 coloana 1 buna, adaug in matrice 1
	push eax
	xor eax,eax
	mov eax,edi
	imul eax,8
	add eax,ecx	
	mov byte[eax + esi], 1
	pop eax
col1_final:
	jmp coloana_2 ; trec la coloana 2
		
coloana_buna_2:
	; cazul in care coloana 2 e buna 
	; ma ocup de cele doua linii posibile din acest caz
	
linie_21:
	; linia cu x-1
	xor edi,edi
	mov edi,eax
	dec edi
	cmp edi, 0 ; linia se afla in dimensiuni
	jge linie_buna_21
	
linie_22:	
 	; linia cu x+1
	xor edi,edi
	mov edi,eax
	inc edi
	cmp edi, 7 ; linia se afla in dimensiuni
	jle linie_buna_22
	jmp col2_final ; nu e nicio linie valabila deci trec la sfarsit
	
linie_buna_21:
	; linia 1 coloana 2 buna, adaug in matrice 1
	push eax
	xor eax,eax
	mov eax,edi
	imul eax,8
	add eax,ecx
	mov byte[eax + esi], 1
	pop eax
	jmp linie_22
		
linie_buna_22:
	; linia 2 coloana 2 buna, adaug in matrice 1
	push eax
	xor eax,eax
	mov eax,edi
	imul eax,8
	add eax,ecx
	mov byte[eax + esi], 1
	pop eax
col2_final:

		
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
