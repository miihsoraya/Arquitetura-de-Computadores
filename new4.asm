Codigo SEGMENT
	Assume CS: Codigo;DS:Codigo; ES: Codigo; SS:Codigo
	Org 100H
Entrada: JMP principal

	;DADOS AQUI
	VAR DB 'NUMERO 1:  $' ;simbolo $ é fim de string
	pula db 0ah,0ah,0dh,'$'
	VAR1 DB 'NUMERO 2:  $' ;s4imboloimbolo $ é fim de string
	VAR3 DB 'RESULTADO:  $' ;s4imboloimbolo $ é fim de string

principal PROC NEAR

		;PROGRAMA AQUI
		;CALL principal
		
		MOV DX, OFFSET VAR
		call print
		call letecla
		MOV BL,AL
		
		MOV DX, OFFSET pula
		call print
		
		MOV DX, OFFSET VAR1
		call print; PRINTAR A SEGUINTE VARIAVEL
		CALL letecla ;ESCREVER ALGO
		MOV CL,AL
		
		MOV DX, OFFSET pula ;CHAMA O COMANDO
		call print ;PRINTA PULANDO A LINHA
		
		MOV DX, OFFSET VAR3 ;CHAMA A VAR
		call print ;PRINTA O Q TEM ESCRITO
		
		
		ADD BL,CL	;COLOCA EM BL
		
		mov DL,BL ;DESLOCA BL ONDE ESTAVA PARA 'DL'
		sub DL,30H ;FAZ APARECER O RESULTADO NORMALMENTE, SUBTRAI 30H
		call mostraChar ;MOSTAR RESULTADO
		
		INT 20H
		
principal ENDP

letecla proc near
    mov ah,01h
	int 21h
	ret
letecla endp
	
print proc near
	mov ah, 09h	
	int 21h
	ret
	print endp
	
mostraChar proc near
	mov ah, 02h
	int 21h
	ret
	mostraChar endp
	
	
Codigo ENDS
		END Entrada