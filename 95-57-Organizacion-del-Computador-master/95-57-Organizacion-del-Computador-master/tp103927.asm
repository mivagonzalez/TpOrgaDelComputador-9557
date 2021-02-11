global main
extern puts
extern gets
extern sscanf
extern printf

section .data
    msjIngMatriz                db  "Ingrese de la matriz %li",10,0
    msjIngMatrizFil             db  "el elemento en la fila %li columna %li",10,0
    msjIngCantMatrices          db  "Ingrese la cantidad de matrices con las que va a operar",0
    formatoInputNumero          db  "%li",0
    msjIngCantMatricesInvalido  db  "La cantidad de matrices debe ser de 2 a 5",0
    msjIngCantFilCol            db  "Ingrese la cantidad de filas y columnas que tendran las matrices, separados por un espacio",0
    formatoInputDosElementos    db  "%hi %hi",0
    msjIngCantFilColInvalido    db  "La fila y columna debe ser un numero entre [1..8]",0
    indiceMatriz                dq  1
    indiceFila                  dq  1
    indiceCol                   dq  1
    ;msjDebug                    db  "llegue aca"
    auxiliarFila                dq  0
    auxiliarCol                 dq  0
    matrices         times 320 	dq  0
    formatoInputElemento        db  "%li",0
    msjElementoInvalido         db  "Elemento ingresado invalido, debe ser un numero entre -99 y 99, se pondra 0 en esa posicion",10,0
    posicionVector              dq  0
    msjElementoMatriz           dq  "  %li  ",0
    indiceVector                dq  1
    msjMostrarMatriz            db  "Matrices:",10,0
    indiceImprimir              dq  0
    msjNewLine                  dw  " ",10,0
    auxiliarImprimir            dq  0
    auxiliarMatrices            dq  0
    msjOpciones                 db  "Ingrese...",0
    opcionUno                   db  "1 para hacer resta de 2 o más matrices",0
    opcionDos                   db  "2 para ver si dos matrices son iguales",0
    opcionTres                  db  "3 para multiplicar una matriz por un valor escalar leído desde teclado",0
    opcionCuatro                db  "4 para modificar el valor de un elemento de una matriz",0
    opcionCinco                 db  "5 para consultar el valor de un elemento de una matriz",0
    msjOpcionInvalida           db  "Opcion invalida, debe ser un numero entre 1 y 5",0
    msjCuantasMatrices          db  "Ingrese cuantas matrices que quiere restar",0
    msjIngCantMatricesRestarInvalido    db  "Cantidad ingresada invalida",0
    msjCualesMatricesRestar     db  "Cuales de las anteriores matrices desea restar? Indicando 1 para la primer matriz, 2 para la segunda y asi sucesivamente. Ingrese en el orden que desea restarlas",0
    msjNumeroDeMatrizInvalido   db  "Numero de matriz invalido, vuelva a ingresar los numeros de las matrices nuevamente",0
    matrizResta      times 64   dq  0
    auxiliarResta               dq  0
    indiceRestar                dq  0
    posicionRestar              dq  0
    matrizARestar               dq  0
    msjResultadoResta           db  "Resultado de la resta: ",10,0
    msjCualesMatricesIgualar    db  "Ingrese los numeros de las dos matrices que desea igualar, primero uno, enter, luego el segundo",0
    msjIngMatricesIgualarInvalido   db  "Numeros de matrices invalido",0
    matriz1                     dq  0   
    matriz2                     dq  0
    indiceMatriz1               dq  0
    indiceMatriz2               dq  0
    posicionMatriz1             dq  0
    elemento1                   dq  0
    posicionMatriz2             dq  0
    elemento2                   dq  0
    msjMatricesDistintas        db  "Las matrices son distintas",0
    msjMatricesIguales          db  "Las matrices son iguales",0
    msjIngMatrizPorEscalar      db  "Ingrese el numero de matriz que desea multiplicar por escalar",0
    matrizAMultiplicar          dq  0
    msjIngMatricesXEscInvalida  db  "Numero de matriz invalido",0
    msjIngEscalar               db  "Ingrese el escalar para multiplicar por la matriz",0
    escalar                     dq  0
    msjEscalarInvalido          db  "Escalar invalido",0
    indiceMultiplicar           dq  0
    posicionMultiplicar         dq  0
    matrizMultiplicar   times 64 dq 0
    msjResultadoMultiplicar     db  "Resultado multiplicacion: ",0
    msjIngNumMatrizElemenMod    db  "Ingrese el numero de matriz que desea modificar",0
    matrizAModificar            dq  0
    msjIngMatricesModificarInvalida db  "Numero de matriz invalido",0
    msjIngFilColModificar       db  "Ingrese la fila y la columna del elemento que desea modificar (separadas por un espacio)"
    filaModificar               dw  0
    columnaModificar            dw  0
    msjIngFilColModificarInvalido   db  "Fila y columna ingresadas invalido",0
    elementoModificado          dq  0
    msjIngElemento              db  "Ingrese el numero que desea poner en esa fila y columna",0
    msjElementoModificadoInvalido   dq  "Numero invalido, debe ser un numero entre -99 y 99",0
    msjIngNumMatrizElemenCon    db  "Ingrese el numero de la matriz que quiere consultar el elemento",0
    matrizAConsultar            dq  0
    msjIngMatricesConsultarInvalida db  "Numero de matriz invalido",0
    msjIngFilColConsultar       db  "Ingrese la fila y la columna del elemento que desea consultar (separadas por un espacio)"
    filaConsultar               dw  0
    columnaConsultar            dw  0
    msjIngFilColConsultarInvalido   db  "Fila y columna ingresadas invalido",0
    msjElementoConsultado       db  "El elemento en esa posicion es: %li",10,0

section .bss
    inputCantMatrices     resq    10
    esValido              resb    1
    cantMatrices          resq    1
    plusRsp		          resq	  1
    inputDosElementos     resb    50
    fila                  resw    1   
    columna               resw    1
    inputElemento         resq    1
    filas                 resq    1
    elemento              resq    1
    inputOpcion           resq    1
    opcion                resq    1
    inputCantMatricesRestar resq    1
    cantMatricesRestar    resq    1
    inputNumMatRestar     resq    1
    matricesRestar      times 5 resq 1
    numMatRestar          resq    1
    inputMatriz1          resq    1
    inputMatriz2          resq    1
    inputNumMatrizXEscalar  resq  1
    inputEscalar          resq    1
    inputNumMatrizModificar resq    50
    inputFilColMatrizModificar  resw    50
    inputElementoModificado resq    1
    inputNumMatrizConsultar resq    1
    inputFilColMatrizConsultar  resw    50


section .text
main:
sub     rsp,8

    call ingresoCantMatrices

    call ingresoCantFilCol

    call ingresoMatrices 

    call imprimirMatrices

    call menuDeOpciones

add     rsp,8 
ret

ingresoCantMatrices:
    mov     rdi,msjIngCantMatrices
    call    puts

    mov     rdi,inputCantMatrices
    call    gets

validarCantMatrices:
    mov     byte[esValido],'N'

    mov     rdi,inputCantMatrices 
    mov     rsi,formatoInputNumero
    mov     rdx,cantMatrices

    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32               
    cmp     rax,1                   
    jl      cantMatricesInvalido

    cmp     qword[cantMatrices],2    
    jl      cantMatricesInvalido        
    cmp     qword[cantMatrices],5    
    jg      cantMatricesInvalido

    mov     byte[esValido],'S'   

ret

cantMatricesInvalido:
    mov     rdi,msjIngCantMatricesInvalido
    call    puts
    jmp     ingresoCantMatrices
ret   

ingresoCantFilCol:
    mov     rdi,msjIngCantFilCol
    call    puts

    mov     rdi,inputDosElementos
    call    gets

validarFilCol:
    mov     byte[esValido],'N'   

    mov     rdi,inputDosElementos         
    mov     rsi,formatoInputDosElementos  
    mov     rdx,fila                
    mov     rcx,columna             
    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32    
    cmp     rax,2                   
    jl      filColInvalido

    cmp     word[fila],1    
    jl      filColInvalido        
    cmp     word[fila],8    
    jg      filColInvalido        

    cmp     word[columna],1 
    jl      filColInvalido        
    cmp     word[columna],8 
    jg      filColInvalido        

    mov     byte[esValido],'S'
    ret

filColInvalido:
    mov     rdi,msjIngCantFilColInvalido
    call    puts
    jmp     ingresoCantFilCol
ret

ingresoMatrices:

    sub     rcx,rcx             
    mov     rcx,[cantMatrices] 

mensajeIngMatrices:
    push    rcx
    
    mov     rdi,msjIngMatriz
    mov     rsi,qword[indiceMatriz]
    call    printf

    sub     rcx,rcx             
    mov     cx,[fila]

mensajeFila:
    mov     [auxiliarFila],rcx

    sub     rcx,rcx             
    mov     cx,[columna]

msjColumna:
    mov     [auxiliarCol],rcx

    mov     rdi,msjIngMatrizFil
    mov     rsi,qword[indiceFila]
    mov     rdx,qword[indiceCol]
    call    printf

    mov     rdi,inputElemento
    call gets

    sub     rbx,rbx
    mov     rbx,qword[indiceVector]
    sub     rbx,1
    
    imul    rbx,rbx,8
    mov     qword[posicionVector],rbx   

    inc     qword[indiceVector]
    call    validarElemento

    inc     qword[indiceCol]
    mov     rcx,[auxiliarCol]
    dec     rcx
    jnz     msjColumna

    mov     qword[indiceCol],1
    inc     qword[indiceFila]
    mov     rcx,[auxiliarFila]
    dec     rcx
    jnz     mensajeFila

    mov     qword[indiceFila],1
    inc     qword[indiceMatriz]
    pop     rcx
    dec     rcx
    jnz     mensajeIngMatrices

ret

validarElemento:
    mov     byte[esValido],'N'

    mov     rdi,inputElemento       
    mov     rsi,formatoInputElemento 
    mov     rdx,elemento
    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32    
    
    cmp     rax,1                  
    jl      elementoInvalido

    cmp     qword[elemento],-99    
    jl      elementoInvalido        
    cmp     qword[elemento],99    
    jg      elementoInvalido               

    mov     byte[esValido],'S'

    mov     rbx,qword[posicionVector]
    mov     rdx,qword[elemento]
    
    mov     qword[matrices+rbx],rdx

    ret

elementoInvalido:
    mov     rdi,msjElementoInvalido
    call    puts
ret

menuDeOpciones:
    mov     rdi,msjOpciones
    call    puts
    mov     rdi,opcionUno
    call    puts
    mov     rdi,opcionDos
    call    puts
    mov     rdi,opcionTres
    call    puts
    mov     rdi,opcionCuatro
    call    puts
    mov     rdi,opcionCinco
    call    puts

    mov     rdi,inputOpcion
    call    gets

    call    validarOpcion

    cmp     qword[opcion],1                   
    je      restaDeMatrices

    cmp     qword[opcion],2
    je      igualdadDeMatrices

    cmp     qword[opcion],3
    je      matrizPorEscalar

    cmp     qword[opcion],4
    je      modificiarValorDeMatriz

    cmp     qword[opcion],5
    je      consultarValorDeMatriz

ret

validarOpcion:
    mov     byte[esValido],'N'

    mov     rdi,inputOpcion 
    mov     rsi,formatoInputNumero
    mov     rdx,opcion

    call    checkAlign
    sub     rsp,[plusRsp]
    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32  

    cmp     rax,1                   
    jl      opcionInvalida

    cmp     qword[opcion],1    
    jl      opcionInvalida        
    cmp     qword[opcion],5    
    jg      opcionInvalida

    mov     byte[esValido],'S'   

ret

opcionInvalida:
    mov     rdi,msjOpcionInvalida
    call    puts
    jmp     menuDeOpciones
ret

restaDeMatrices:
    mov     rdi,msjCuantasMatrices
    call    puts

    mov     rdi,inputCantMatricesRestar
    call    gets

    call    validarCantMatricesRestar

    mov     rdi,msjCualesMatricesRestar
    call    puts

    ;call    imprimirMatrices

    mov     qword[posicionVector],0
    mov     qword[indiceVector],0

    sub     rcx,rcx
    mov     rcx,qword[cantMatricesRestar]

ingresoMatricesARestar:
    mov     qword[auxiliarMatrices],rcx
    mov     rdi,inputNumMatRestar
    call    gets

    call    validarNumMatRestar

    mov     rcx,qword[auxiliarMatrices]
    dec     rcx
    jnle     ingresoMatricesARestar

calculoDesplazamientoPrimerMatriz:
    sub     rbx,rbx
    mov     bx,word[fila]
    imul    bx,word[columna]
    sub     rcx,rcx
    mov     rcx,rbx
    mov     qword[auxiliarResta],rcx

    mov     rax,qword[matricesRestar]
    dec     rax
    imul    rbx,rax
    mov     qword[indiceVector],rbx
    imul    rbx,rbx,8
    mov     qword[posicionVector],rbx
    mov     qword[posicionRestar],0
    mov     qword[indiceRestar],0

    
guardarMatriz:
    sub     rax,rax
    mov     rbx,qword[posicionVector]
    mov     rax,qword[matrices+rbx]
    sub     rbx,rbx
    mov     rbx,qword[posicionRestar]
    mov     qword[matrizResta+rbx],rax

    inc     qword[indiceVector]
    mov     rbx,qword[indiceVector]
    imul    rbx,rbx,8
    mov     qword[posicionVector],rbx
    inc     qword[indiceRestar]
    mov     rbx,qword[indiceRestar]
    imul    rbx,rbx,8
    mov     qword[posicionRestar],rbx

    mov     rcx,qword[auxiliarResta]
    dec     rcx
    mov     qword[auxiliarResta],rcx
    jnz     guardarMatriz

    mov     qword[indiceMatriz],1
    
    sub     rcx,rcx
    mov     rcx,qword[cantMatricesRestar]
    dec     rcx
matrizRestar:
    mov     qword[auxiliarMatrices],rcx

    sub     rbx,rbx
    mov     rbx,qword[indiceMatriz]
    imul    rbx,rbx,8
    mov     rax,qword[matricesRestar+rbx]
    mov     qword[matrizARestar],rax

    sub     rbx,rbx
    mov     bx,word[fila]
    imul    bx,word[columna]
    dec     qword[matrizARestar]
    imul    rbx,qword[matrizARestar]
    mov     qword[indiceRestar],rbx

    mov     qword[indiceVector],0

    sub     rbx,rbx
    mov     bx,word[fila]
    imul    bx,word[columna]
    mov     rcx,rbx

resta:
    mov     qword[auxiliarResta],rcx

    mov     rbx,qword[indiceRestar]
    imul    rbx,rbx,8
    mov     qword[posicionRestar],rbx

    mov     rax,qword[matrices+rbx]

    mov     rbx,qword[indiceVector]
    imul    rbx,rbx,8
    mov     qword[posicionVector],rbx

    sub     qword[matrizResta+rbx],rax

    inc     qword[indiceVector]
    inc     qword[indiceRestar]
    mov     rcx,qword[auxiliarResta]
    dec     rcx
    jnz     resta
    
    inc     qword[indiceMatriz]
    mov     rcx,qword[auxiliarMatrices]
    dec     rcx
    jnz     matrizRestar

imprimirMatrizResta:
    mov     qword[auxiliarImprimir],0
    mov     rbx,0
    
    mov     rdi,msjResultadoResta
    call    puts

    sub rcx,rcx
    mov cx,word[fila]

loopImprimirFil:
    mov     qword[auxiliarFila],rcx
    sub     rcx,rcx
    mov     cx,word[columna]

loopImprimirElemCol:
    mov     qword[auxiliarCol],rcx

    mov     rax,qword[matrizResta+rbx]
    mov     qword[elemento],rax

    mov     rdi,msjElementoMatriz
    mov     rsi,qword[elemento]
    
    sub rsp, 8
	call printf
	add rsp, 8

    inc     qword[auxiliarImprimir]
    imul    rbx,qword[auxiliarImprimir],8

    mov     rcx,qword[auxiliarCol]
    dec     rcx
    jnz     loopImprimirElemCol

    mov     rdi,msjNewLine
    call    puts

    mov     rcx,qword[auxiliarFila]
    dec     rcx
    jnz     loopImprimirFil

ret

validarNumMatRestar:
    mov     byte[esValido],'N'

    mov     rdi,inputNumMatRestar 
    mov     rsi,formatoInputNumero
    mov     rdx,numMatRestar

    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32               
    cmp     rax,1                   
    jl      numMatRestarInvalido

    cmp     qword[numMatRestar],1    
    jl      numMatRestarInvalido    
    mov     rcx,qword[cantMatricesRestar]    
    cmp     qword[numMatRestar],rcx 
    jg      numMatRestarInvalido

    mov     rdx,qword[numMatRestar]
    mov     rbx,qword[posicionVector]
    mov     qword[matricesRestar+rbx],rdx
    inc     qword[indiceVector]
    imul    rbx,qword[indiceVector],8
    mov     qword[posicionVector],rbx

    mov     byte[esValido],'S'
ret

numMatRestarInvalido:
    mov     rdi,msjNumeroDeMatrizInvalido
    call    puts
    ;jmp     ingresoMatricesARestar
    ;call     restaDeMatrices
ret

validarCantMatricesRestar:
    mov     byte[esValido],'N'

    mov     rdi,inputCantMatricesRestar 
    mov     rsi,formatoInputNumero
    mov     rdx,cantMatricesRestar

    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32  

    cmp     rax,1                   
    jl      cantMatricesRestarInvalido

    cmp     qword[cantMatricesRestar],2    
    jl      cantMatricesRestarInvalido    
    mov     rcx,qword[cantMatrices]    
    cmp     qword[cantMatricesRestar],rcx 
    jg      cantMatricesRestarInvalido

    mov     byte[esValido],'S'
ret

cantMatricesRestarInvalido:
    mov     rdi,msjIngCantMatricesRestarInvalido
    call    puts
    jmp     restaDeMatrices
ret

igualdadDeMatrices:
    mov     rdi,msjCualesMatricesIgualar
    call    puts

    mov     rdi,inputMatriz1
    call    gets

    mov     rdi,inputMatriz2
    call    gets

    call    validarNumMatrices

igualarMatrices:

    sub     rbx,rbx
    mov     bx,word[fila]
    imul    bx,word[columna]
    dec     qword[matriz1]
    imul    rbx,qword[matriz1]
    mov     qword[indiceMatriz1],rbx

    sub     rbx,rbx
    mov     bx,word[fila]
    imul    bx,word[columna]
    mov     rcx,rbx
    dec     word[matriz2]
    imul    rbx,qword[matriz2]
    mov     qword[indiceMatriz2],rbx

igualar:
    mov     qword[auxiliarMatrices],rcx
    mov     rbx,qword[indiceMatriz1]
    imul    rbx,rbx,8
    mov     qword[posicionMatriz1],rbx

    mov     rax,qword[matrices+rbx]
    mov     qword[elemento1],rax

    mov     rbx,qword[indiceMatriz2]
    imul    rbx,rbx,8
    mov     qword[posicionMatriz2],rbx

    mov     rax,qword[matrices+rbx]
    mov     qword[elemento2],rax

    cmp     qword[elemento1],rax
    jne     matricesDistintas
    inc     qword[indiceMatriz1]
    inc     qword[indiceMatriz2]

    mov     rcx,qword[auxiliarMatrices]
    dec     rcx
    jnz     igualar

    jmp     matricesIguales

ret

matricesIguales:
    mov     rdi,msjMatricesIguales
    call    puts
ret

matricesDistintas:
    mov     rdi,msjMatricesDistintas
    call    puts
ret

validarNumMatrices:
    mov     byte[esValido],'N'   

    mov     rdi,inputMatriz1         
    mov     rsi,formatoInputElemento
    mov     rdx,matriz1                
    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32    
    cmp     rax,1                   
    jl      matricesInvalidas

    mov     rdi,inputMatriz2         
    mov     rsi,formatoInputElemento
    mov     rdx,matriz2                
    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32    
    cmp     rax,1                   
    jl      matricesInvalidas  

    cmp     qword[matriz1],1    
    jl      matricesInvalidas 
    mov     rcx,qword[cantMatrices]       
    cmp     qword[matriz1],rcx  
    jg      matricesInvalidas        

    cmp     qword[matriz2],1 
    jl      matricesInvalidas  
    mov     rcx,qword[cantMatrices]      
    cmp     qword[matriz2],rcx 
    jg      matricesInvalidas        

    mov     byte[esValido],'S'
ret

matricesInvalidas:
    mov     rdi,msjIngMatricesIgualarInvalido
    call    puts
    jmp     igualdadDeMatrices
ret

matrizPorEscalar:
    
    call    ingresoNumMatrizPorEscalar

    call    ingresarEscalar

    sub     rbx,rbx
    mov     bx,word[fila]
    imul    bx,word[columna]
    mov     rcx,rbx
    dec     qword[matrizAMultiplicar]
    imul    rbx,qword[matrizAMultiplicar]
    mov     qword[indiceVector],rbx

    mov     qword[indiceMultiplicar],0

multiplicarMatriz:
    mov     qword[auxiliarMatrices],rcx

    mov     rbx,qword[indiceVector]
    imul    rbx,rbx,8
    mov     qword[posicionVector],rbx

    mov     rax,qword[matrices+rbx]
    imul    rax,qword[escalar]

    mov     rbx,qword[indiceMultiplicar]
    imul    rbx,rbx,8
    mov     qword[posicionMultiplicar],rbx

    mov     qword[matrizMultiplicar+rbx],rax

    inc     qword[indiceMultiplicar]
    inc     qword[indiceVector]
    mov     rcx,qword[auxiliarMatrices]
    dec     rcx
    jnz     multiplicarMatriz

imprimirMatrizMultiplicar:
    mov     qword[auxiliarImprimir],0
    mov     rbx,0
    
    mov     rdi,msjResultadoMultiplicar
    call    puts

    sub rcx,rcx
    mov cx,word[fila]

loopImprimirFilMultiplicar:
    mov     qword[auxiliarFila],rcx
    sub     rcx,rcx
    mov     cx,word[columna]

loopImprimirElemColMultiplicar:
    mov     qword[auxiliarCol],rcx

    mov     rax,qword[matrizMultiplicar+rbx]
    mov     qword[elemento],rax

    mov     rdi,msjElementoMatriz
    mov     rsi,qword[elemento]
    
    sub rsp, 8
	call printf
	add rsp, 8

    inc     qword[auxiliarImprimir]
    imul    rbx,qword[auxiliarImprimir],8

    mov     rcx,qword[auxiliarCol]
    dec     rcx
    jnz     loopImprimirElemColMultiplicar

    mov     rdi,msjNewLine
    call    puts

    mov     rcx,qword[auxiliarFila]
    dec     rcx
    jnz     loopImprimirFilMultiplicar

ret 

ingresarEscalar:

    mov     rdi,msjIngEscalar
    call    puts

    mov     rdi,inputEscalar
    call    gets

    call    validarEscalar

ret

ingresoNumMatrizPorEscalar:

    mov     rdi,msjIngMatrizPorEscalar
    call    puts

    mov     rdi,inputNumMatrizXEscalar
    call    gets

    call    validarNumMatrizXEscalar
ret
validarEscalar:
    mov     byte[esValido],'N'   

    mov     rdi,inputEscalar      
    mov     rsi,formatoInputElemento
    mov     rdx,escalar                
    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32    
    cmp     rax,1                   
    jl      escalarInvalido
ret

escalarInvalido:
    mov     rdi,msjEscalarInvalido
    call    puts
    jmp     ingresarEscalar
ret

validarNumMatrizXEscalar:
    mov     byte[esValido],'N'   

    mov     rdi,inputNumMatrizXEscalar       
    mov     rsi,formatoInputElemento
    mov     rdx,matrizAMultiplicar                
    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32    
    cmp     rax,1                   
    jl      matrizInvalida

    cmp     qword[matrizAMultiplicar],1    
    jl      matrizInvalida
    mov     rcx,qword[cantMatrices]       
    cmp     qword[matrizAMultiplicar],rcx  
    jg      matrizInvalida             

    mov     byte[esValido],'S'
ret

matrizInvalida:
    mov     rdi,msjIngMatricesXEscInvalida
    call    puts
    jmp     ingresoNumMatrizPorEscalar
ret

modificiarValorDeMatriz:
    
    call    ingresarMatrizElementoModificar

    call    ingresarFilColElementoModificar

    call    ingresarElemento

modificarValor:
    sub     rbx,rbx
    mov     bx,word[fila]
    imul    bx,word[columna]
    dec     qword[matrizAModificar]
    imul    rbx,qword[matrizAModificar]
    mov     qword[indiceVector],rbx

    dec     word[filaModificar]
    dec     word[columnaModificar]
    sub     rbx,rbx
    mov     bx,word[filaModificar]
    imul    rbx,rbx,2
    add     bx,word[columnaModificar]
    add     qword[indiceVector],rbx
    
    mov     rbx,qword[indiceVector]
    imul    rbx,rbx,8
    mov     rax,qword[elementoModificado]
    mov     qword[matrices+rbx],rax

ret

ingresarElemento:
    mov     rdi,msjIngElemento
    call    puts

    mov     rdi,inputElementoModificado
    call    gets

    call    validarElementoModificado

ret

validarElementoModificado:
    mov     byte[esValido],'N'   

    mov     rdi,inputElementoModificado    
    mov     rsi,formatoInputElemento
    mov     rdx,elementoModificado                
    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32    
    cmp     rax,1                   
    jl      elementoModificadoInvalido  

    cmp     qword[elementoModificado],-99    
    jl      elementoModificadoInvalido
    cmp     qword[elementoModificado],99  
    jg      elementoModificadoInvalido           

    mov     byte[esValido],'S'
ret

elementoModificadoInvalido:
    mov     rdi,msjElementoModificadoInvalido
    call    puts
    jmp     ingresarElemento
ret

ingresarMatrizElementoModificar:
    mov     rdi,msjIngNumMatrizElemenMod
    call    puts

    mov     rdi,inputNumMatrizModificar
    call    gets

    call    validarNumMatrizModificar

ret

validarNumMatrizModificar:
    mov     byte[esValido],'N'   

    mov     rdi,inputNumMatrizModificar    
    mov     rsi,formatoInputElemento
    mov     rdx,matrizAModificar                
    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32    
    cmp     rax,1                   
    jl      matrizInvalidaModificar

    cmp     qword[matrizAModificar],1    
    jl      matrizInvalidaModificar
    mov     rcx,qword[cantMatrices]       
    cmp     qword[matrizAModificar],rcx  
    jg      matrizInvalidaModificar             

    mov     byte[esValido],'S'
ret

matrizInvalidaModificar:
    mov     rdi,msjIngMatricesModificarInvalida
    call    puts
    jmp     ingresarMatrizElementoModificar
ret

ingresarFilColElementoModificar:
    mov     rdi,msjIngFilColModificar
    call    puts

    mov     rdi,inputFilColMatrizModificar
    call    gets

    call    validarFilColMatrizModificar
ret

validarFilColMatrizModificar:
    mov     byte[esValido],'N'   

    mov     rdi,inputFilColMatrizModificar         
    mov     rsi,formatoInputDosElementos  
    mov     rdx,filaModificar                
    mov     rcx,columnaModificar             
    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32    
    cmp     rax,2                   
    jl      filColModificarInvalido

    cmp     word[filaModificar],1    
    jl      filColModificarInvalido  
    mov     bx,word[fila]
    cmp     word[filaModificar],bx   
    jg      filColModificarInvalido        

    cmp     word[columnaModificar],1 
    jl      filColModificarInvalido  
    mov     bx,word[columna]      
    cmp     word[columnaModificar],bx
    jg      filColModificarInvalido        

    mov     byte[esValido],'S'
    ret

filColModificarInvalido:
    mov     rdi,msjIngFilColModificarInvalido
    call    puts
    jmp     ingresarFilColElementoModificar
ret

consultarValorDeMatriz:
    call    ingresarMatrizElementoConsultar

    call    ingresarFilColElementoConsultar

consultarValor:
    sub     rbx,rbx
    mov     bx,word[fila]
    imul    bx,word[columna]
    dec     qword[matrizAConsultar]
    imul    rbx,qword[matrizAConsultar]
    mov     qword[indiceVector],rbx

    dec     word[filaConsultar]
    dec     word[columnaConsultar]
    sub     rbx,rbx
    mov     bx,word[filaConsultar]
    imul    rbx,rbx,2
    add     bx,word[columnaConsultar]
    add     qword[indiceVector],rbx
    
    mov     rbx,qword[indiceVector]
    imul    rbx,rbx,8

    mov     rdi,msjElementoConsultado
    mov     rsi,qword[matrices+rbx]
    
    sub rsp, 8
	call printf
	add rsp, 8

ret

ingresarFilColElementoConsultar:
    mov     rdi,msjIngFilColConsultar
    call    puts

    mov     rdi,inputFilColMatrizConsultar
    call    gets

    call    validarFilColMatrizConsultar
ret

validarFilColMatrizConsultar:
    mov     byte[esValido],'N'   

    mov     rdi,inputFilColMatrizConsultar         
    mov     rsi,formatoInputDosElementos  
    mov     rdx,filaConsultar                
    mov     rcx,columnaConsultar             
    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32    
    cmp     rax,2                   
    jl      filColConsultarInvalido

    cmp     word[filaConsultar],1    
    jl      filColConsultarInvalido  
    mov     bx,word[fila]
    cmp     word[filaConsultar],bx   
    jg      filColConsultarInvalido        

    cmp     word[columnaConsultar],1 
    jl      filColConsultarInvalido  
    mov     bx,word[columna]      
    cmp     word[columnaConsultar],bx
    jg      filColConsultarInvalido        

    mov     byte[esValido],'S'
    ret

filColConsultarInvalido:
    mov     rdi,msjIngFilColConsultarInvalido
    call    puts
    jmp     ingresarFilColElementoConsultar
ret

ingresarMatrizElementoConsultar:
    mov     rdi,msjIngNumMatrizElemenCon
    call    puts

    mov     rdi,inputNumMatrizConsultar
    call    gets

    call    validarNumMatrizConsultar

ret

validarNumMatrizConsultar:
    mov     byte[esValido],'N'   

    mov     rdi,inputNumMatrizConsultar  
    mov     rsi,formatoInputElemento
    mov     rdx,matrizAConsultar                
    call    checkAlign
    sub     rsp,[plusRsp]

    call    sscanf  
    add		rsp,[plusRsp]   ;add rsp,32    
    cmp     rax,1                   
    jl      matrizInvalidaConsultar

    cmp     qword[matrizAConsultar],1    
    jl      matrizInvalidaConsultar
    mov     rcx,qword[cantMatrices]       
    cmp     qword[matrizAConsultar],rcx  
    jg      matrizInvalidaConsultar             

    mov     byte[esValido],'S'
ret

matrizInvalidaConsultar:
    mov     rdi,msjIngMatricesConsultarInvalida
    call    puts
    jmp     ingresarMatrizElementoConsultar
ret
    
imprimirMatrices:
    mov qword[auxiliarImprimir],0
	mov rax, 0
	mov rdi, msjMostrarMatriz
	sub rsp, 8
	call printf
	add rsp, 8

    sub rbx,rbx
    mov rbx,0

    sub rcx,rcx
    mov rcx,qword[cantMatrices]   

imprimir:
    mov qword[auxiliarMatrices],rcx

    sub rcx,rcx
    mov cx,word[fila]

loopImprimirFilas:
    mov     qword[auxiliarFila],rcx
    sub     rcx,rcx
    mov     cx,word[columna]

loopImprimirElementoCol:
    mov     qword[auxiliarCol],rcx

    mov     rax,qword[matrices+rbx]
    mov     qword[elemento],rax

    mov     rdi,msjElementoMatriz
    mov     rsi,qword[elemento]
    
    sub rsp, 8
	call printf
	add rsp, 8

    inc     qword[auxiliarImprimir]
    imul    rbx,qword[auxiliarImprimir],8

    mov     rcx,qword[auxiliarCol]
    dec     rcx
    jnz     loopImprimirElementoCol

    mov     rdi,msjNewLine
    call    puts

    mov     rcx,qword[auxiliarFila]
    dec     rcx
    jnz     loopImprimirFilas

    mov     rdi,msjNewLine
    call    puts

    mov     rcx,qword[auxiliarMatrices]
    dec     rcx
    jnz     imprimir

ret

;--------------------------------------------------------
;           CheckAlign
;--------------------------------------------------------
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