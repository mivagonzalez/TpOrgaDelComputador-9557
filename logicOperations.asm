;EJEMPLO CLASE
global 	main
extern 	printf
extern 	gets
extern 	fgets
extern 	fopen
extern 	fclose
extern 	puts
extern  sscanf
extern itoa
extern atoi

section .data
	msgIngresoOperando			        db	'Por favor ingrese el operando de 16 bits',10,0
    msgLeyendo	                        db	"leyendo Registro...",0
	msgImprimirElementoFinal			db	'%c',0
	msgImprimirResultadoParcial         db	'el resultado parcial es: ',10,0
	msgImprimirSaltoDeLinea             db	10,'-------------------------',10,0
	msgInputArchivoInvalido		        db	'el registro leido de archivo logicOperations.text es invalido',10,0
	msgInputArchivoValido		        db	'el registro leido de archivo logicOperations.text es valido, aplicando operacion...',10,0
	msgImprimirResultadoFinal			db	'el resultado final es: ',0
	msgInputInvalido			        db	'el numero ingresado es invalido',10,0
	msgInputValido			            db	'el numero ingresado es valido',10,0
	msgOperandoNumArchivo		        db	'operando %s operacion %s, verificando...',10,0
    msgAperturaOk                       db "Apertura archivo logicOperations.text ok",0
	msgErrOpen		                    db  "Error en apertura de archivo logicOperations.txt",0

    operandoFormat      db  '%lli',0
    fileName		    db	"logicOperations.txt",0 
	mode			    db	"r",0
    handleFile  	    dq	0
    ; regOperanciones     times	0	db ''
	;  secOperando        times	17 	db ' '
    ;  operacion          times 2   db ''   No pude uasr esto porque cuando lo usaba en fgets no me estaba guardando bien los caracteres y no pude descubrir porque



	
section .bss
    mascara  	                    resb	2
    inputTecladoValido              resb    50
    inputArchivoValido              resb    50
	buffer		                    resb	17
    operandoNum                     resb    2
    operandoSecNum                  resb    2
    secOperando                     resb    17
    operacion                       resb    2   

section .text
main:

	sub  rsp,28h

abrirArchivo:
    mov		rcx,fileName ;RCX
    mov     rdx,mode ;RDX
    sub     rsp,32
    call	fopen
    add     rsp,32

    cmp     rax,0
    jle     errorOpen
    mov     [handleFile],rax

    mov     rcx,msgAperturaOk
    sub		rsp,32
    call    puts
	add		rsp,32

ingresarOperando:    
	mov		rcx,msgIngresoOperando		
	sub		rsp,32
	call	printf						
	add		rsp,32

	mov		rcx,buffer					
	sub		rsp,32
	call	gets
	add		rsp,32

	call validarOperandoInput
    cmp byte[inputTecladoValido],'N'
    je  inputInvalido    
    
    mov		rcx,msgInputValido		
	sub		rsp,32
	call	printf						
	add		rsp,32 
    
leerRegsitro:
    mov     rcx,secOperando
    mov     rdx,17              
    mov     r8,[handleFile]  
   	sub		rsp,32
    call    fgets               
    add		rsp,32
    
    cmp     rax,0
    jle     imprimirResultado
    
    mov     rcx,operacion
    mov     rdx,2
    mov     r8,[handleFile]  
   	sub		rsp,32
    call    fgets
    add		rsp,32

    cmp     rax,0
    jle     imprimirResultado

    mov     rcx,msgLeyendo
    sub		rsp,32
    call    puts   
	add		rsp,32

    mov     rcx, msgOperandoNumArchivo
    mov     rdx, secOperando
    mov     r8, operacion
	sub		rsp,32
	call	printf						
	add		rsp,32

	;Valido registro
	call	validarRegistroArchivo
    cmp		byte[inputArchivoValido],'N'
    je		inputArchivoInvalido

    mov     rcx, msgInputArchivoValido
	sub		rsp,32
	call	printf						
	add		rsp,32

    call    aplicarOperacion
    mov     rcx,msgImprimirResultadoParcial
    mov     rdx,[operandoNum]
    sub     rsp,32
    call    printf
    add     rsp,32

    call    transformarEnString

    jmp     leerRegsitro


inputArchivoInvalido:
    mov		rcx,msgInputArchivoInvalido		
	sub		rsp,32
	call	printf						
	add		rsp,32    
    jmp     leerRegsitro

errorOpen:
    mov     rcx,msgErrOpen
    sub		rsp,32
    call    puts
	add		rsp,32
	;Cierro archivo Listado
	mov		rcx,[handleFile]  
    sub		rsp,32
	call	fclose							
	add		rsp,32              	
	jmp		fin

inputInvalido:
    mov		rcx,msgInputInvalido		
	sub		rsp,32
	call	printf						
	add		rsp,32    
    jmp     closeFiles
imprimirResultado:
    mov		rcx,msgImprimirResultadoFinal		
	sub		rsp,32
	call	printf						
	add		rsp,32  
    call transformarEnString
closeFiles:
    ;CIERRO archivo
    mov     rcx,[handleFile]
    sub		rsp,32
    call    fclose
	add		rsp,32

fin:
    add  rsp,28h
    ret

; ;------------------------------------------------------------
; ;  RUTINAS INTERNAS
; ;------------------------------------------------------------

validarOperandoInput:
;------------------------------------------------------------	
    mov   byte[inputTecladoValido],'N'
    mov   rsi,0
    mov   r9,0

siguienteBitInput:
    cmp   byte[buffer + rsi],0
    je    valLongInput

    cmp   byte[buffer + rsi],'0'
    jl    finValidarInput  
    
    cmp   byte[buffer + rsi],'1'
    jg    finValidarInput
    inc   rsi
    inc   r9
    jmp   siguienteBitInput

valLongInput:
    cmp   r9,16
    jl    finValidarInput
    jg    finValidarInput
valFisOk:           
    
    mov     rcx, buffer 
    mov     rdx, operandoFormat
    mov     r8, operandoNum
	call	sscanf


    cmp     rax,1
    jl      finValidarInput
    mov   byte[inputTecladoValido],'S'
finValidarInput:

ret

validarRegistroArchivo:
;------------------------------------------------------------	
    mov   byte[inputArchivoValido],'N'
    mov   rsi,0
    mov   r9,0

siguienteBitArchivo:
    cmp   byte[secOperando + rsi],0
    je    valLongInputArchivo

    cmp   byte[secOperando + rsi],'0'
    jl    finValidarInputArchivo  
    
    cmp   byte[secOperando + rsi],'1'
    jg    finValidarInputArchivo
    inc   rsi
    inc   r9
    jmp   siguienteBitArchivo

valLongInputArchivo:


    cmp   r9,16
    jl    finValidarInputArchivo
    jg    finValidarInputArchivo

valOperacionArchivo:    
    cmp   byte[operacion],'O'
    je    operacionArchivoOk       
    cmp   byte[operacion],'N'
    je    operacionArchivoOk       
    cmp   byte[operacion],'X'
    je    operacionArchivoOk
    jmp   finValidarInputArchivo

operacionArchivoOk:

    mov     rcx, secOperando 
    mov     rdx, operandoFormat
    mov     r8, operandoSecNum 
	sub		rsp,32
	call	sscanf
	add		rsp,32 
    cmp     rax,1
    jl      finValidarInputArchivo

    mov   byte[inputArchivoValido],'S'
finValidarInputArchivo:

ret


aplicarOperacion:

    cmp   byte[operacion],'O'
    je    operacionOr 

    cmp   byte[operacion],'N'
    je    operacionAnd       

    cmp   byte[operacion],'X'
    je    operacionXor

operacionAnd:
    mov rcx,[operandoSecNum]
    mov rbx,[operandoNum]
    AND rbx,rcx
    jmp finAplicarOperacion
operacionXor:
    mov rcx,[operandoSecNum]
    mov rbx,[operandoNum]
    XOR rbx,rcx
    jmp finAplicarOperacion

operacionOr:
    mov rcx,[operandoSecNum]
    mov rbx,[operandoNum]
    OR rbx,rcx

finAplicarOperacion:
    mov [operandoNum],rbx
ret
	
transformarEnString:
    ; utilizo una mascara que voy multiplicando por 2 para correr el 1 a la izquierda. Me fijo si numero resultante es 0 o distinto de 0
    ; si es distinto de 0 quiere decir que en ese bit hay un uno entonce imprimo un uno, sino imprimo 0
    mov rdi,1
    mov rsi,0
    
    mov rbx,[operandoNum]
imprimirCaracter:
    cmp rsi,16
    je  finTransformarEnString

    mov r9, rbx
    AND r9,rdi
    cmp r9,0
    je imprimir0

imprimir1:
    mov rcx,msgImprimirElementoFinal
    mov rdx,'1'
    sub rsp,32
    call printf
    add rsp,32
    jmp siguienteBit
imprimir0:
    mov rcx,msgImprimirElementoFinal
    mov rdx,'0'
    sub rsp,32
    call printf
    add rsp,32
siguienteBit:
    inc rsi
    imul rdi,2
    jmp imprimirCaracter
finTransformarEnString:
    mov rcx,msgImprimirSaltoDeLinea
    sub rsp,32
    call printf
    add rsp,32
ret