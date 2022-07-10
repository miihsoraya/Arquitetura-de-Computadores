Codigo SEGMENT
	Assume CS: Codigo;DS:Codigo; ES: Codigo; SS:Codigo
	Org 100H
Entrada: JMP principal

	;DADOS AQUI
	
principal PROC NEAR

		;PROGRAMA AQUI
		CALL principal
		MOV BL,AL
		CALL Letecla
		MOV CL,AL
		ADD BL,CL
		iNT 20H
principal ENDP
letecla proc near
    mov ah,01h
	int 21h
	ret
letecla endp	
Codigo ENDS
		END Entrada