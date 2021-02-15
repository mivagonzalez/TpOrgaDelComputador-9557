; Dado un archivo en formato texto que contiene informacion sobre autos llamado listado.txt
; donde cada linea del archivo representa un registro de informacion de un auto con los campos: 
;   marca:							10 caracteres
;   modelo: 						15 caracteres
;   año de fabricacion:				4 caracteres
;   patente:						7 caracteres
;   precio:							7 caracteres
; Se pide codificar un programa en assembler intel que lea cada registro del archivo listado y guarde
; en un nuevo archivo en formato binario llamado seleccionados.dat las patentes de aquellos autos
; cuyo año de fabricación esté entre 2010 y 2019 inclusive
; Como los datos del archivo pueden ser incorrectos, se deberan validar mediante una rutina interna.
; Solamente se deberá validar Marca (que sea Fiat, Ford, Chevrolet o Peugeot) y año (que sea un valor
; numérico)


global	main
extern  puts
extern  fopen
extern  fclose
extern  fgets
extern  sscanf
extern  fwrite

section	.data
	fileListado		db	"listado.txt",0
	modeListado		db	"r",0		;read | texto | abrir o error
	msjErrOpenLis	db	"Error en apertura de archivo Listado",0
    handleListado	dq	0
	fileSeleccion	db	"seleccion.dat",0
	modeSeleccion	db	"ab+",0
	msjErrOpenSel   db	"Error en apertura de archivo seleccion",0
	handleSeleccion	dq	0

	regListado	times	0	db ''
	 marca		times	10 	db ' '
	 modelo		times	15	db ' '
	 anio		times   4	db ' '
	 patente	times	7	db ' '
	 precio		times   7	db ' '
	 EOL		times   2	db ' '    

    vecMarcas		db	'Peugeot   Fiat      Ford      Chevrolet '

    anioStr	 		db '****',0
	anioFormat	    db '%hi',0	;16 bits (word)
	anioNum			dw	0				;16 bits (word)    

	regSeleccion	times	0	db	''
	 patenteS		times	7	db ' '

;*** Mensajes para debug
msjInicio   db  "Iniciando...",0
msjAperturaOk db "Apertura Listado ok",0
msjAperturaOkS db "Apertura Seleccion ok",0
msjLeyendo	db	"leyendo...",0
msjMarcaErr db 'Marca Invalida',0
msjAnioErr  db 'Anio invalido',0

section .bss
    datoValido		resb	1
    regsitroValido	resb 1
    plusRsp		resq	1    

section  .text
main:
mov     rdi,msjInicio
call    puts

    mov		rdi,fileListado ;RCX
    mov     rsi,modeListado ;RDX
    call	fopen

    cmp     rax,0
    jle     errorOpenLis
    mov     [handleListado],rax

mov     rdi,msjAperturaOk
call    puts
	;Abro archivo seleccion
	mov		rdi,fileSeleccion
	mov		rsi,modeSeleccion
	call	fopen

	cmp		rax,0
	jle		errorOpenSel
	mov		[handleSeleccion],rax

mov     rdi,msjAperturaOkS
call    puts
    ;LEO EL ARCHIVO LISTADO
leerRegsitro:
    mov     rdi,regListado
    mov     rsi,45              ;REVISAR TAMAÑO FIN DE LINEA!!!!
    mov     rdx,[handleListado]        ;R8
    call    fgets
    cmp     rax,0
    jle     closeFiles
mov rdi,msjLeyendo
call puts    
	;Valido registro
	call	validarRegistro
    cmp		byte[regsitroValido],'N'
    je		leerRegsitro

	;Convierto año a numerico
	mov		rcx,4
	mov		rsi,anio
	mov		rdi,anioStr
	rep	movsb

	mov		rdi,anioStr        ;rcx
	mov		rsi,anioFormat      ;rdx
	mov		rdx,anioNum         ;r8
	call	checkAlign      ;no va en Windows
	sub		rsp,[plusRsp]   ;sub rsp,32
    call	sscanf
	add		rsp,[plusRsp]   ;add rsp,32


; Verifico si el año esta comprendido en el rango 2010 - 2019
	cmp		word[anioNum],2010
	jl		leerRegsitro
	cmp		word[anioNum],2019
	jg		leerRegsitro   

	;Copio Patnte al campo del registro del archivo
	mov		rcx,7
	mov		rsi,patente
	mov		rdi,patenteS
	rep	movsb	

	;Guardo registro en archivo Seleccion
	mov		rdi,regSeleccion			;Parametro 1: dir area de memoria con los datos a copiar
	mov		rsi,7									;Parametro 2: longitud del registro
	mov		rdx,1									;Parametro 3: cantidad de registros
	mov		rcx,[handleSeleccion]	;Parametro 4: handle del archivo
	call	fwrite								;LEO registro. Devuelve en RAX la cantidad de bytes leidos



    jmp    leerRegsitro


    jmp closeFiles

errorOpenLis:
	mov		rdi,msjErrOpenLis ;RCX
	call	puts
	jmp		endProg    
errorOpenSel:
    mov     rdi,msjErrOpenSel
    call    puts
	;Cierro archivo Listado
	mov		rdi,[handleListado]	;Parametro 1: handle del archivo
	call	fclose							;CIERRO archivo
	jmp		endProg
closeFiles:
    mov     rdi,[handleListado]
    call    fclose
	mov		rdi,[handleSeleccion]	;Parametro 1: handle del archivo
	call	fclose							;CIERRO archivo
endProg:
ret

;------------------------------------------------------
;   Rutinas internas
;------------------------------------------------------
validarRegistro:
    mov     byte[regsitroValido],'N'

    call    validarMarca
    cmp     byte[datoValido],'N'
    je      finValidarRegistro

    call     validarAnio
    cmp     byte[datoValido],'N'
    je      finValidarRegistro

    mov     byte[regsitroValido],'S'

finValidarRegistro:
ret

validarMarca:
    mov     byte[datoValido],'S'

    mov     rbx,0
    mov     rcx,4
nextMarca:
    push    rcx
    mov     rcx,10
    lea     rsi,[marca]  ; = mov rsi,marca
    lea     rdi,[vecMarcas+rbx]
    repe cmpsb

    pop     rcx
    je      marcaOk
    add     rbx,10
    loop    nextMarca

    mov     byte[datoValido],'N'
mov rdi,msjMarcaErr
call puts	    
marcaOk:
ret


validarAnio:
	mov		byte[datoValido],'S'

	mov		rcx,4
	mov		rbx,0
nextDigito:
	cmp		byte[anio+rbx],'0'
	jl		anioError
	cmp		byte[anio+rbx],'9'
	jg		anioError
	inc		rbx
	loop	nextDigito
	jmp		anioOk	;ret

anioError:
	mov		byte[datoValido],'N'
mov rdi,msjAnioErr
call puts	
anioOk:
ret


;----------------------------------------
;----------------------------------------
; ****	checkAlign ****
;----------------------------------------
;----------------------------------------
checkAlign:
	push rax
	push rbx
;	push rcx
	push rdx
	push rdi

	mov   qword[plusRsp],0
	mov		rdx,0

	mov		rax,rsp		
	add     rax,8		;para sumar lo q restó la CALL 
	add		rax,32	;para sumar lo que restaron las PUSH
	
	mov		rbx,16
	idiv	rbx			;rdx:rax / 16   resto queda en RDX

	cmp     rdx,0		;Resto = 0?
	je		finCheckAlign
;mov rdi,msj
;call puts
	mov   qword[plusRsp],8
finCheckAlign:
	pop rdi
	pop rdx
;	pop rcx
	pop rbx
	pop rax
	ret