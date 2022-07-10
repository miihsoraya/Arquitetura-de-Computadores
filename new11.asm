Codigo SEGMENT
	Assume CS: Codigo;DS:Codigo; ES: Codigo; SS:Codigo
	Org 100H
Entrada: JMP Nomeprog

	;DADOS AQUI
	
Nomeprog PROC NEAR

		;PROGRAMA AQUI
		
		mov ax,9999
		mov bx,8888
		mov ax,cx ;cx=ax
		mov cx,bx ;bx=cx isso é bx=ax
		mov bx,ax ;ax=bx isso é ax=bx
		
		INT 20H
Nomeprog ENDP
Codigo ENDS
		END Entrada