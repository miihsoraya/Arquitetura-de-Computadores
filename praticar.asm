Codigo SEGMENT

 Assume cs:codigo; ds:codigo; es:codigo; ss:codigo
 org 100H

Entrada: JMP Programa

   VAR DB 4,?,4 DUP(0)
   msg1 db 'Primeiro Numero: ','$' 
   msg2 db  0AH,0DH,'Segundo Numero: ','$'
   msgt db  0AH, 0DH,'Total: $' 
   VAR1 DB 4,?,4 DUP(0)   
   RESULT DB 5,?,5 DUP(0)
   
   Programa proc near

   ;Leitura do primeiro numero
   MOV DX, OFFSET msg1
   CALL mostramsg;
   MOV DX, OFFSET VAR
   CALL lertecla

   ;Leitura do segundo numero
   MOV DX, OFFSET msg2
   CALL mostramsg
   MOV DX, OFFSET VAR1
   CALL lertecla
   
   MOV AL, (VAR+1*2)
   MOV AH, (VAR1+1*2)
   CMP AL, AH 
   JE sinaisIguais; Se são iguais manda para sinaisIguais 
   JNE sinaisDiferentes; Se são diferentes manda para sinaisDiferentes

    sinaisIguais:
		JMP SOMAS
	
   sinaisDiferentes:
      JMP SUBIS

   SOMAS:
    CALL SOMA ;chamada da função subtração
   INT 20H ; encerramento do programa
   
   SUBIS:
    CALL SUBI ;chamada da função subtração
   INT 20H ; encerramento do programa
Programa ENDP
 
   SOMA proc near ;funcao de somar
      MOV AH, VAR+3
      MOV AL, (VAR+2*2)
      MOV BL, AL
      MOV BH,AH

      MOV AH,VAR1+3
      MOV AL, (VAR1+2*2)
      MOV CL,AL
      MOV CH,AH
     
      ADD BL,CL
      MOV AH,0
      MOV AL,BL
      AAA
      MOV DX,AX
      OR DX, 3030H
      MOV RESULT+4,DL
      MOV BL,DH
      ADD BH,CH
      MOV AH,0
      MOV AL,BH
      AAA
      MOV DX,AX
      OR DX,3030H
      MOV RESULT+3,DL
      MOV CH,DH
      MOV AH,0
      ADD BL,RESULT+3
      MOV AL,BL
      AAA
      MOV DX,AX
      OR DX,3030H
      MOV RESULT+3,DL
      MOV RESULT+2,CH
      MOV AH,(VAR+1*2)
      CMP AH,'+';
      JE positivo
      JNE negativo

      positivo:
        MOV RESULT+1,'+'
        JMP imprime
      negativo:
         MOV RESULT+1,'-'
         JMP imprime

      imprime:
	      MOV DX, OFFSET msgt
	      CALL mostramsg 
	      MOV DL,RESULT+1; Coloca para mostrar o sinal
	      CALL mostrarchar
	      MOV DL, RESULT+2;Coloca para mostrar centena
	      CALL mostrarchar
	      MOV DL,RESULT+3;Coloca para mostrar dezena
	      CALL mostrarchar
	      MOV DL, RESULT+4;Coloca para mostrar unidade
	      CALL mostrarchar
	      RET
   SOMA ENDP
  
   SUBI proc near ;funcao de subtrair
      MOV AH,VAR+3
      MOV AL,(VAR+2*2); multiplica por *2 por ser um valor de dois bits
      AAD
      MOV BL,AL
      MOV AH,VAR1+3
      MOV AL,(VAR1+2*2)
      AAD
      MOV CL,AL
      CMP BL,CL; compara os valores
      JG ME; se o maior for o da esquerda vai pra me
      JLE MD; se for o da direita vai pra md
      
     ME:
      SUB BL,CL ; subtrai de forma normal
      MOV AL,BL
      MOV AH,0
      AAM
      OR AX,3030H
      MOV RESULT+1, '+'; coloca o + pois é uma subtração de maior com menor
      MOV RESULT+4,AL
      MOV RESULT+3,AH  
      JMP final; pula pra impressão 
      
     MD:
      SUB CL,BL ; subtrai de forma inversa aos valores sendo passados
      MOV AL,CL ;move o resultado 
      MOV AH,0
      AAM ; ajusta 
      OR AX,3030H ; transforma em hexadecimal
      MOV RESULT+1, '-' ; coloca o - por ser uma subtração do menor com um maior  
      MOV RESULT+4,AL
      MOV RESULT+3,AH  
      JMP final
            

      final:
       MOV DX, OFFSET msgt
       CALL mostramsg 
       MOV DL,RESULT+1 ; Coloca para mostrar o sinal
       CALL mostrarchar
       MOV DL,RESULT+3;Coloca para mostrar dezena
       CALL mostrarchar
       MOV DL, RESULT+4;Coloca para mostrar unidade
       CALL mostrarchar
       RET

   SUBI ENDP


   lertecla proc near ;funcao de ler tecla
   MOV AH, 0AH
   INT 21h
   ret
   lertecla endp
   
   mostrarchar proc near ;funcao de printar char
   mov AH, 02h
   int 21h
   ret
   mostrarchar endp
   
   mostramsg proc near ;funcao de printar mensagem
   mov ah,09
   int 21h 
   ret
   mostramsg endp  
   
   Codigo ENDS
   END Entrada