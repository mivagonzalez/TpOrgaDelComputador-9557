;EJEMPLO CLASE
global 	main
extern 	printf
extern 	gets
extern 	fgets
extern 	fopen
extern 	fclose
extern 	puts
extern  sscanf

section .data
    string                              db  '1234567891000000',0
	msgIngresoOperando			        db	'Por favor ingrese el operando de 16 bits',10,0
    msgLeyendo	                        db	"leyendo Registro...",0
	msgImprimirElemento			        db	'el numero ingresado es %s',10,0
	msgImprimirResultadoParcial         db	'el resultado parcial es %i',10,0
	msgInputArchivoInvalido		        db	'el registro leido de archivo logicOperations.text es invalido',10,0
	msgInputArchivoValido		        db	'el registro leido de archivo logicOperations.text es valido',10,0
	msgInputInvalido			        db	'el numero ingresado es invalido',10,0
	msgInputValido			            db	'el numero ingresado es valido',10,0
	msgOperandoNum			            db	'el numero ingresado dspues de convertir es  %i',10,0
	msgOperandoNumArchivo		        db	'operando %s operacion %s, aplicando...',10,0
	msgOperandoNumConvertidoArchivo		db	'operando despues de ser convertido %i ',10,0
    msgAperturaOk                       db "Apertura archivo logicOperations.text ok",0
	msgErrOpen		                    db  "Error en apertura de archivo logicOperations.txt",0

    operandoFormat  db  '%lli',0
    fileName		db	"logicOperations.txt",0 ;LA ULTIMA LINEA DEL ARCHIVO DEBE TERMINAR CON UN FIN DE LINEA (ENTER)!!!
	mode			db	"r",0
    handleFile  	dq	0

    ; regOperanciones     times	0	db ''
	;  secOperando        times	16 	db ' '
    ;  operacion          times 1   db ''



	
section .bss
    inputTecladoValido  resb    50
    inputArchivoValido  resb    50
	buffer		        resb	17
    resultadoParcial    resq    1
    operandoNum         resq    1
    operandoSecNum      resq    1
    secOperando         resb    17
    operacion           resb    2   

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
	mov		rcx,msgIngresoOperando		;Param 1: Direccion del mensaje a imprimir
	sub		rsp,32
	call	printf						;Muestro encabezado del listado por pantalla
	add		rsp,32

	mov		rcx,buffer					;Parametro 1: campo donde están los datos a leer
	sub		rsp,32
	call	gets
	add		rsp,32

	call validarOperandoInput
    cmp byte[inputTecladoValido],'N'
    je  inputInvalido    
    
    mov		rcx,msgInputValido		;Param 1: Direccion del mensaje a imprimir
	sub		rsp,32
	call	printf						;Muestro encabezado del listado por pantalla
	add		rsp,32 

leerRegsitro:
    mov     rcx,secOperando
    mov     rdx,17              
    mov     r8,[handleFile]  
   	sub		rsp,32
    call    fgets               ;PREGUNTAR PORQUE NO FUNCIONA SOLO LEYENDO TODO EN UN REGISTRO Y TENGO QUE HACER DOS FGETS
    add		rsp,32
    
    cmp     rax,0
    jle     transformarEnString
    
    mov     rcx,operacion
    mov     rdx,2
    mov     r8,[handleFile]  
   	sub		rsp,32
    call    fgets
    add		rsp,32

    cmp     rax,0
    jle     transformarEnString

    mov     rcx,msgLeyendo
    sub		rsp,32
    call    puts   
	add		rsp,32

	;Valido registro
	call	validarRegistroArchivo
    cmp		byte[inputArchivoValido],'N'
    je		inputArchivoInvalido
    
    

    mov     rcx, msgInputArchivoValido
	sub		rsp,32
	call	printf						;Muestro registro del archivo valido por pantalla
	add		rsp,32

    mov     rcx, msgOperandoNumArchivo
    mov     rdx, secOperando
    mov     r8, operacion
	sub		rsp,32
	call	printf						;Muestro operacion y operando del archivo por pantalla
	add		rsp,32


    call    aplicarOperacion
    mov     rcx,msgImprimirResultadoParcial
    mov     rdx,[operandoNum]
    sub     rsp,32
    call    printf
    add     rsp,32

    jmp     leerRegsitro


inputArchivoInvalido:
    mov		rcx,msgInputArchivoInvalido		;Param 1: Direccion del mensaje a imprimir
	sub		rsp,32
	call	printf						;Muestro encabezado del listado por pantalla
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
	call	fclose							;CIERRO archivo
	add		rsp,32              	;Parametro 1: handleFile del archivo
	jmp		fin

inputInvalido:
    mov		rcx,msgInputInvalido		;Param 1: Direccion del mensaje a imprimir
	sub		rsp,32
	call	printf						;Muestro encabezado del listado por pantalla
	add		rsp,32    
    jmp     closeFiles
transformarEnString:
    ;----------------
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
valFisOk:           ;and;'0000 0000 0000 0000 0001'
    
    mov     rcx, buffer ;'1001 0001 1110 0001 1111' dividir por 2 para eliminar este bit, luego sumarle 30 a la mascara e ir guardando en string de 16 bytes
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
	
