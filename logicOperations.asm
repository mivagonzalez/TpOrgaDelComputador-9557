; Tengo un bug en el trabjao que me impidio terminarlo al 100% y no pude encontrar porque, consulte en el campus y envie mails pero no obtuve respuesta. El problema esta entre la conversion a binario punto fijo hecha con
; sscanf y la conversion de nuevo a string con mi rutina transformarAString
; Basicamente sscanf me esta transformando el string en un binario punto fijo con signo, el cual si transformo luego a string no se transforma en el numero con 0s y 1s que deberia. Revise mi funcion de transformacion y deberia
; estar andando bien asique estoy practicamewnte seguro que no se encuentra alli el problema. Luego las operaciones tambien las estoy realizando bien, asique lo unico que se me ocurre es que sscanf no me este devolviendo bien el 
; binario.
; Intente de todas las formas resolverlo pero no pude encontrar donde se esta orignando este.
global 	main
extern 	printf
extern 	gets
extern 	fgets
extern 	fopen
extern 	fclose
extern 	puts

section .data
	msgEfectuandoAnd			        db	'--EFECTUANDO AND--',10,0
	msgEfectuandoOR			        db	'--EFECTUANDO OR--',10,0
	msgEfectuandoXor			        db	'--EFECTUANDO XOR--',10,0
	msgIngresoOperando			        db	'Por favor ingrese el operando de 16 bits',10,0
	msgImprimirOperandoTransfEnBin      db	'--- OPERANDO TRANSFORMADO EN BINARIO : %i ',10,0
	msgImprimirOperandoDOS              db	'--- STRING DEL OPERANDO 2 : %s ',10,0
    msgLeyendo	                        db	"leyendo Registro...",0
	msgImprimirResultadoParcial         db	'El resultado parcial es: %s',10,0
	msgImprimirResultadoFinal			db	'El resultado final es: %s',10,0
	msgImprimirSaltoDeLinea             db	'-----------------------------------------',10,0
	msgInputArchivoInvalido		        db	'El registro leido de archivo logicOperations.text es invalido',10,0
	msgInputArchivoValido		        db	'El registro leido de archivo logicOperations.text es valido, aplicando operacion...',10,0
	msgInputInvalido			        db	'El numero ingresado es invalido',10,0
	msgInputValido			            db	'El numero ingresado es valido',10,0
	msgOperandoNumArchivo		        db	'operando %s operacion %s, verificando...',10,0
    msgAperturaOk                       db "Apertura archivo logicOperations.text ok",0
	msgErrOpen		                    db  "Error en apertura de archivo logicOperations.txt",0

    operandoFormat      db  '%lli',0
    fileName		    db	"logicOperations.txt",0 
	mode			    db	"r",0
    handleFile  	    dq	0
    ; regOperanciones     times	0	db ''
	;  secOperando        times	17 	db ' '
    ;  operacion          times 2   db ''   No pude usar esto porque cuando lo usaba en fgets no me estaba guardando bien los caracteres , me guardaba el operando y la operacion, en secOperando y la operacion en operacion
    ;                                       Es decir la operacion la estaba guardando dos veces. Decidi hacer 2 fgets por separado.



	
section .bss
    stringResultadoFinal            resb    17
    operacionNueva                  resb    2
    secOperando                     resb    17
    mascara  	                    resb	2
    operandoSecNum                  resb    2
    inputTecladoValido              resb    50
    inputArchivoValido              resb    50
	buffer		                    resb	17
    operandoNum                     resb    2
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
    call transformarOperando1EnBinario

    mov		rcx,msgInputValido		
	sub		rsp,32
	call	printf						
	add		rsp,32 
    
    push qword[operandoNum]
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

    mov rcx,1
    mov rsi,operacion
    mov rdi,operacionNueva
    rep movsb

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

    call transformarOperando2EnBinario

    pop qword[operandoNum]

    call    aplicarOperacion

    call    transformarEnString

    mov		rcx,msgImprimirResultadoParcial		
    mov		rdx,stringResultadoFinal	
	sub		rsp,32
	call	printf						
	add		rsp,32
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
    call transformarEnString

    mov		rcx,msgImprimirSaltoDeLinea		
	sub		rsp,32
	call	printf						
	add		rsp,32

    mov		rcx,msgImprimirResultadoFinal		
    mov		rdx,stringResultadoFinal	
	sub		rsp,32
	call	printf						
	add		rsp,32

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
    mov   byte[inputTecladoValido],'S'
finValidarInput:

ret

; --------------------------------------------------------------
validarRegistroArchivo:

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
    mov   byte[inputArchivoValido],'S'
finValidarInputArchivo:

ret

; --------------------------------------------------------------

aplicarOperacion:
    cmp   byte[operacionNueva],'O'
    je    operacionOr 

    cmp   byte[operacionNueva],'N'
    je    operacionAnd       

    cmp   byte[operacionNueva],'X'
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
	
; --------------------------------------------------------------
transformarEnString:

    mov byte[stringResultadoFinal + 16],0
    ; utilizo una mascara que voy multiplicando por 2 para correr el 1 a la izquierda. Me fijo si numero resultante es 0 o distinto de 0
    ; si es distinto de 0 quiere decir que en ese bit hay un uno entonce imprimo un uno, sino imprimo 0

    mov rdi,1
    
    mov rsi,15
    
    mov rbx,[operandoNum]
    
imprimirCaracter:
    cmp rsi,0
    jl  finTransformarEnString

    mov r9, rbx
    AND r9,rdi

    cmp r9,0
    je imprimir0

imprimir1:
    mov byte[stringResultadoFinal + rsi],'1'
    jmp siguienteBit
imprimir0:
    mov byte[stringResultadoFinal + rsi],'0'
siguienteBit:
    dec rsi
    imul rdi,2
    jmp imprimirCaracter

finTransformarEnString:

ret
; --------------------------------------------------------------
transformarOperando1EnBinario:

    mov qword[operandoNum],0
    mov rsi,1
    mov rbx,15
validarBitEnBuffer:    
    cmp rbx,0
    jl  finTransformarOp1EnBinario
    cmp byte[buffer+rbx],'1'
    je  escribirBit1EnOp1
    jmp siguienteBitOp1

escribirBit1EnOp1:

    or qword[operandoNum],rsi

siguienteBitOp1:

    imul rsi,2
    dec  rbx
    jmp validarBitEnBuffer

finTransformarOp1EnBinario:
ret


transformarOperando2EnBinario:
    mov qword[operandoSecNum],0
    mov rdi,1
    mov rsi,15
validarBitEnSecOperando:    
    cmp rsi,0
    jl  finTransformarOp2EnBinario
    cmp byte[secOperando+rsi],'1'
    je  escribirBit1EnOp2
    jmp siguienteBitOp2

escribirBit1EnOp2:
    or qword[operandoSecNum],rdi

siguienteBitOp2:

    imul rdi,2
    dec  rsi
    jmp validarBitEnSecOperando

finTransformarOp2EnBinario:
ret