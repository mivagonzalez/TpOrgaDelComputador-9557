;EJEMPLO CLASE
global 	main
extern 	printf
extern 	gets
extern  sscanf

section .data
    string                      db  '1234567891000000',0
	msgIngresoOperando			db	'Por favor ingrese el operando de 3 bits',10,0
	msgImprimirElemento			db	'el numero ingresado es %s',10,0
	msgInputInvalido			db	'el numero ingresado es invalido',10,0
	msgInputValido			db	'el numero ingresado es valido',10,0
	msgOperandoNum			db	'el numero ingresado dspues de convertir es  %i',10,0
    operandoFormat          db  '%lli',0

	
section .bss
    inputTecladoValido  resb 50
	buffer		resb	17
    operandoNum resq    1

section .text
main:

	sub  rsp,28h
ingresarOperando:    
	mov		rcx,msgIngresoOperando		;Param 1: Direccion del mensaje a imprimir
	sub		rsp,32
	call	printf						;Muestro encabezado del listado por pantalla
	add		rsp,32

	mov		rcx,buffer					;Parametro 1: campo donde están los datos a leer
	sub		rsp,32
	call	gets
	add		rsp,32


    mov    rcx, msgImprimirElemento
    mov    rdx, buffer
    sub		rsp,32
	call	printf						;Muestro encabezado del listado por pantalla
	add		rsp,32 

	call validarInput
    cmp byte[inputTecladoValido],'N'
    je  inputInvalido

    mov		rcx,msgInputValido		;Param 1: Direccion del mensaje a imprimir
	sub		rsp,32
	call	printf						;Muestro encabezado del listado por pantalla
	add		rsp,32 
    jmp     fin

inputInvalido:
    mov		rcx,msgInputInvalido		;Param 1: Direccion del mensaje a imprimir
	sub		rsp,32
	call	printf						;Muestro encabezado del listado por pantalla
	add		rsp,32    

fin:
    add  rsp,28h
    ret
ret
;------------------------------------------------------------
;  RUTINAS INTERNAS
;------------------------------------------------------------

validarInput:
;------------------------------------------------------------	
    mov   byte[inputTecladoValido],'N'
    mov   rsi,0

nextDig:
    cmp   byte[buffer + rsi],0
    je    valFisOk

    cmp   byte[buffer + rsi],'0'
    jl    finValidarInput  
    
    cmp   byte[buffer + rsi],'1'
    jg    finValidarInput
    inc   rsi
    jmp   nextDig

valFisOk:           ;and;'0000 0000 0000 0000 0001'
    mov     rcx, buffer ;'1001 0001 1110 0001 1111' dividir por 2 para eliminar este bit, luego sumarle 30 a la mascara e ir guardando en string de 16 bytes
    mov     rdx, operandoFormat
    mov     r8, operandoNum ;''
	sub		rsp,32
	call	sscanf
	add		rsp,32 

    cmp     rax,1
    jl      finValidarInput

    mov     rcx,msgOperandoNum
    mov     rdx,[operandoNum]   
	sub		rsp,32
	call	printf
	add		rsp,32 

    mov   byte[inputTecladoValido],'S'

finValidarInput:

ret
	
