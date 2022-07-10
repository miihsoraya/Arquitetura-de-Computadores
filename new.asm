Codigo SEGMENT ;SEGMENT - marcador de inicio de segmento

	ASSUME CS:Codigo; DS:Codigo; ES:Codigo; SS:Codigo
	Org 100H 
	
Entrada: JMP Nomeprog                   ;Pula para o Nomeprog
                                        ;Entrada : rotulo (label)
	
	VAR db 'NUMERO 1 : $'
	pula db 0AH,0ah,0DH, '$'
	VAR2 db 'NUMERO 2 : $'
	VAR3 db 'RESULTADO: $'

		
Nomeprog PROC NEAR                      ;NEAR quando o procedimento (rotina) esta dentro do SEGMENT
                                        ;PROC - Marcam o início uma procedimento (rotina).
		
        ;Mostra mensagem
        MOV DX, OFFSET VAR              ;Referencia string msg no registrador DX
        CALL PRINT              	;Chama interrupção 09h (printa string referenciada em DX)
        CALL Letecla                    ;Chama interrupção 01h (ler caracter do teclado e guarda em AL)
        MOV CH, AL                      ;Guarda caracter em CH
        
	CALL Letecla                   	;Chama interrupção 01h (ler caracter do teclado e guarda em AL)
        MOV CL, AL                      ;Guarda caracter em CL


        ;Pula linha e Mostra mensagem
        MOV DX, OFFSET pula        	;Referencia string pulalinha no registrador DX
        CALL PRINT             		;Chama interupção 09h (printa string referenciada em DX)
        
	MOV DX, OFFSET VAR2             ;Referencia string msg2 no registrador DX
        CALL PRINT              	;Chama interupção 09h (printa string referenciada em DX)



        ;Ler o segundo numero e coloca em BX
        CALL Letecla                   ;Chama interupção 01h (ler caracter do teclado e guarda em AL)
        MOV BH, AL                      ;Guarda caracter em BH
        CALL Letecla                   ;Chama interupção 01h (ler caracter do teclado e guarda em AL)
        MOV BL, AL                      ;Guarda caracter em BL

        

        ;tira o 3030 de ascii para decimal
        ;mas cada digito fica separado no registrador
        AND BX, 0F0FH                   ;tira 3030H de BX
        AND CX, 0F0FH                   ;tira 3030H de CX


        ;ajustado no registrador AX por um valor BCD descompactado.
        MOV AX, BX                      ;Coloca o valor de BX em AX
        AAD                             ;Converte o valor de AX em BCD descompactado
        MOV BX, AX                      ;guarda AX em BX

        MOV AX, CX                      ;Coloca o valor de CX em AX
        AAD                             ;Converte o valor de AX em BCD descompactado
        MOV CX, AX                      ;guarda AX em CX


        
        ;Soma os numeros em hexadecimal
        ADD CX, BX                      ;Somando BX e CX 

        
        ;ajuste do conteúdo do AX para criar dois dígitos descompactados (base 10).
        ;Primeiro digito
        MOV AX, CX                      ;Coloca o valor de CX em AX
        AAM                             ;criar um par de valores BCD descompactados (base 10), AH = AL/10 || AL = AL mod 10
        MOV CL, AL                      ;Salva AL em CL
        
        ;Segundo e Terceiro digito
        MOV AL, AH                      ;Coloca AH (Resto da divisão) em AL
        AAM                             ;criar um par de valores BCD descompactados (base 10), AH = AL/10 || AL = AL mod 10
        MOV CH, AL                      ;Salva AL em CH
        MOV BL, AH                      ;Salva AH em BL

        ;Adiciona 3030H para ajustar na tabela ascii
	ADD BX, 3030H                   ;Adiciona 3030h para ficar compativel com ascii
	ADD CX, 3030H                   ;Adiciona 3030h para ficar compativel com ascii


        ;Pula linha e Mostra mensagem
        MOV DX, OFFSET pula        	;Referencia string pulalinha no registrador DX
        CALL print              	;Chama interupção 09h (printa string referenciada em DX) 
        MOV DX, OFFSET VAR3             ;Referencia string msg3 no registrador DX
        CALL print              	;Chama interrupção 09h (printa string referenciada em DX)

        
        ;mostra resultado na tela
	MOV DL, BL                     ;Colocando primeiro numero em BL
        CALL Mostrarchar               ;Chama interupção 02h (printa caracter(ASCII) que esta no registrador DL)
        MOV DL, CH                     ;Colocando segundo numero em BL
	CALL Mostrarchar               ;Chama interrupção 02h (printa caracter(ASCII) que esta no registrador DL)
	MOV DL, CL                     ;Colocando terceiro numero em BL
    	CALL Mostrarchar               ;Chama interrupção 02h (printa caracter(ASCII) que esta no registrador DL)
		
	
	INT 20H                        ;Encerra o programa
		
Nomeprog ENDP                          ;ENDP - Marca o fim de uma procedimento (rotina).

Letecla PROC NEAR

        ;Chama interrupção 01h (ler caracter do teclado e echoa na tela e guarda em AL)
	MOV AH, 01H
	INT 21H                        ;INT - indica interupção || INT 21 - interupção 21 contém os serviços do DOS.
	RET                            ;RET - Retorno de uma chamada de rotina

Letecla ENDP
	
Mostrarchar PROC NEAR

	;Chama interrupção 02h (printa caracter(ASCII) que esta no registrador DL)
    	MOV AH, 02H
	INT 21H
	RET

Mostrarchar ENDP

PRINT PROC NEAR

        ;Chama interrupção 09h (printa string referenciada em DX)
	MOV AH, 09
	INT 21H
	RET

PRINT ENDP


	
Codigo ENDS                             ;ENDS - Marcam o fim de um segmento.
END Entrada                             ;END - Marcam o