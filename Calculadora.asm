Codigo SEGMENT

 Assume cs:codigo; ds:codigo; es:codigo; ss:codigo
 
 Org 100H
 .386

Entrada: JMP Program
	 ; Michele Soraya
   msg: db      '1-Adicao',0dh,0ah,'2-Subtracao',0dh,0ah,'3-Multiplicacao', '$'
   msg2: db      0dh,0ah,"primeiro numero : $"
   msg3: db      0dh,0ah,"segundo numero : $"
   msg4: db      0dh,0ah,"Choice Error $" 
   msg5: db      0dh,0ah,"Resultado : $" 
   msg6: db       0dh,0ah, "SAINDOOOOO $"
   
Program Proc Near
	
	start:  mov ah,9
        mov dx, OFFSET msg ;first we will display hte first message from which he can choose the operation using int 21h
        int 21h
        mov ah,0                       
        int 16h  ;then we will use int 16h to read a key press, to know the operation he choosed
        cmp al,31h ;the keypress will be stored in al so, we will comapre to 1 addition ..........
        je Addition
        cmp al,32h
        je Subtract
        cmp al,33h
        je Multiply
		mov AH,09
        mov dx, OFFSET msg4
        CALL printMensagem
        mov ah,0
        int 16h
        jmp start
        
Addition:   mov ah,09h  ;then let us handle the case of addition operation
            mov dx, OFFSET msg2  ;first we will display this message enter first no also using int 21h
            int 21h
            mov cx,0 ;we will call InputNo to handle our input as we will take each number seprately
            call InputNo  ;first we will move to cx 0 because we will increment on it later in InputNo
            push dx
            mov ah,9
            mov dx, OFFSET msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            add dx,bx
            push dx 
            mov ah,9
            mov dx, OFFSET msg5
            int 21h
            mov cx,10000
            pop dx
            call View
            jmp sair
            
InputNo:    mov ah,0
            int 16h ;then we will use int 16h to read a key press     
            mov dx,0  
            mov bx,1 
            cmp al,0dh ;the keypress will be stored in al so, we will comapre to  0d which represent the enter key, to know wheter he finished entering the number or not 
            je FormNo ;if it's the enter key then this mean we already have our number stored in the stack, so we will return it back using FormNo
            sub ax,30h ;we will subtract 30 from the the value of ax to convert the value of key press from ascii to decimal
            call ViewNo ;then call ViewNo to view the key we pressed on the screen
            mov ah,0 ;we will mov 0 to ah before we push ax to the stack bec we only need the value in al
            push ax  ;push the contents of ax to the stack
            inc cx   ;we will add 1 to cx as this represent the counter for the number of digit
            jmp InputNo ;then we will jump back to input number to either take another number or press enter          
   

;we took each number separatly so we need to form our number and store in one bit for example if our number 235
FormNo:     pop ax  
            push dx      
            mul bx
            pop dx
            add dx,ax
            mov ax,bx       
            mov bx,10
            push dx
            mul bx
            pop dx
            mov bx,ax
            dec cx
            cmp cx,0
            jne FormNo
            ret   

View:  mov ax,dx
       mov dx,0
       div cx 
       call ViewNo
       mov bx,dx 
       mov dx,0
       mov ax,cx 
       mov cx,10
       div cx
       mov dx,bx 
       mov cx,ax
       cmp ax,0
       jne View
       ret


ViewNo:    push ax ;we will push ax and dx to the stack because we will change there values while viewing then we will pop them back from
           push dx ;the stack we will do these so, we don't affect their contents
           mov dx,ax ;we will mov the value to dx as interrupt 21h expect that the output is stored in it
           add dl,30h ;add 30 to its value to convert it back to ascii
           mov ah,2
           int 21h
           pop dx  
           pop ax
           ret
      
sair:   mov dx,OFFSET msg6
        mov ah, 09h
        int 21h  

        mov ah, 0
        int 16h
        ret
                       
Multiply:   mov ah,09h
            mov dx, OFFSET msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, OFFSET msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            mov ax,dx
            mul bx 
            mov dx,ax
            push dx 
            mov ah,9
            mov dx, OFFSET msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp sair


Subtract:   mov ah,09h
            mov dx, OFFSET msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, OFFSET msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            sub bx,dx
            mov dx,bx
            push dx 
            mov ah,9
            mov dx, OFFSET msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp sair
   INT 20H         ;encerramento do programa
Program ENDP
	
   leTecla Proc Near ;rotina/função que recebe a entrada do teclado e a coloca numa variavel referenciada por DX
	   MOV AH, 0AH
	   INT 21h
	   ret
   leTecla endp
   
   leChar Proc Near ;rotina/função que recebe a entrada do teclado e a coloca numa variavel referenciada por DX
	   MOV AH, 01h
	   INT 21h
	   ret
   leChar endp

   printChar Proc Near ;rotina/função que printa um Char referenciado em DL na tela
	   mov AH,02h
	   int 21h
	   ret
   printChar endp
  
   
   printMensagem Proc Near ;rotina/função que printa uma string referenciada em DX na tela
	   mov AH,09
	   int 21h 
	   ret
   printMensagem endp  
	
   Codigo ENDS
END Entrada
