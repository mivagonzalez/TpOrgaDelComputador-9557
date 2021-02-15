;EJEMPLO CLASE
global 	main
extern 	printf
extern 	gets
extern 	fopen
extern 	fclose
extern 	puts
extern  sscanf

section .data
    string                      db  '1234567891000000',0
	msgIngresoOperando			db	'Por favor ingrese el operando de 16 bits',10,0
	msgImprimirElemento			db	'el numero ingresado es %s',10,0
	msgInputInvalido			db	'el numero ingresado es invalido',10,0
	msgInputValido			db	'el numero ingresado es valido',10,0
	msgOperandoNum			db	'el numero ingresado dspues de convertir es  %i',10,0
    operandoFormat          db  '%lli',0

    fileName		db	"logicOperations.txt",0 ;LA ULTIMA LINEA DEL ARCHIVO DEBE TERMINAR CON UN FIN DE LINEA (ENTER)!!!
	mode			db	"r",0
	msgErrOpen		db  "Error en apertura de archivo logicOperations.txt",0
    handleFile  	dq	0

    regListado	  times	0	db ''
	 secOperando  times	17 	db '1111111111111111',0
     operacion    times 1   db 'N'

    msjAperturaOk db "Apertura archivo logicOperations.text ok",0

	
section .bss
    inputTecladoValido  resb 50
	buffer		resb	17
    operandoNum resq    1

section .text
main:

	sub  rsp,28h

abrirArchivo:
    mov		rcx,fileName ;RCX
    mov     rdx,mode ;RDX
    call	fopen

    cmp     rax,0
    jle     errorOpen
    mov     [handleFile],rax

    mov     rcx,msjAperturaOk
    call    puts

ingresarOperando:    
	mov		rcx,msgIngresoOperando		;Param 1: Direccion del mensaje a imprimir
	sub		rsp,32
	call	printf						;Muestro encabezado del listado por pantalla
	add		rsp,32

	mov		rcx,buffer					;Parametro 1: campo donde están los datos a leer
	sub		rsp,32
	call	gets
	add		rsp,32

	call validarInput
    cmp byte[inputTecladoValido],'N'
    je  inputInvalido

    mov		rcx,msgInputValido		;Param 1: Direccion del mensaje a imprimir
	sub		rsp,32
	call	printf						;Muestro encabezado del listado por pantalla
	add		rsp,32 
    jmp     closeFiles


errorOpen:
    mov     rcx,msgErrOpen
    call    puts
	;Cierro archivo Listado
	mov		rcx,[handleFile]                	;Parametro 1: handleFile del archivo
	call	fclose							;CIERRO archivo
	jmp		fin

inputInvalido:
    mov		rcx,msgInputInvalido		;Param 1: Direccion del mensaje a imprimir
	sub		rsp,32
	call	printf						;Muestro encabezado del listado por pantalla
	add		rsp,32    

closeFiles:
    ;CIERRO archivo
    mov     rcx,[handleFile]
    call    fclose

fin:
    add  rsp,28h
    ret

; ;------------------------------------------------------------
; ;  RUTINAS INTERNAS
; ;------------------------------------------------------------

validarInput:
;------------------------------------------------------------	
    mov   byte[inputTecladoValido],'N'
    mov   rsi,0
    mov   r9,0

nextDig:
    cmp   byte[buffer + rsi],0
    je    valLongInput

    cmp   byte[buffer + rsi],'0'
    jl    finValidarInput  
    
    cmp   byte[buffer + rsi],'1'
    jg    finValidarInput
    inc   rsi
    inc   r9
    jmp   nextDig

valLongInput:
    cmp   r9,16
    jl    finValidarInput
    jg    finValidarInput
valFisOk:           ;and;'0000 0000 0000 0000 0001'
    mov     rcx, buffer ;'1001 0001 1110 0001 1111' dividir por 2 para eliminar este bit, luego sumarle 30 a la mascara e ir guardando en string de 16 bytes
    mov     rdx, operandoFormat
    mov     r8, operandoNum ;''
	sub		rsp,32
	call	sscanf
	add		rsp,32 

    cmp     rax,1
    jl      finValidarInput

    mov   byte[inputTecladoValido],'S'
finValidarInput:

ret

	
