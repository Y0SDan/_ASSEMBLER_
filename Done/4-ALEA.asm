;programa para Masm QUE OBTIENE UN NUMERO ALEATORIO
   ; ESTE PROGRAMA CALCULA UN NUMERO ALEATORIO BASADO
   ; EN OTRO NUMERO ALEATORIO PREVIO O SEMILLA, COLOCADO EN DX
   ;Y LA SALIDA SE OBTIENE EN AX, EL NUMERO ALEATORIO ES DE 16 BITS

; Definicion de stack
STACKSG segment para stack 'stack'
        DB 20 DUP (0)
STACKSG ENDS

;DEFINICION DE AREAS DE TRABAJO
DATASG SEGMENT PARA 'DATA'
MEN1 DB 'SEMILLA PARA EL NUMERO$'
MEN2 DB 'ADIOS$'
DATASG ENDS

CODESG SEGMENT PARA 'CODE'
PRINCI PROC FAR
   ASSUME SS:STACKSG, DS:DATASG,CS:CODESG
   ;PROTOCOLO
   PUSH DS
   SUB AX,AX
   PUSH AX
   MOV AX,SEG DATASG
   MOV DS,AX

   ;INICIA PROGRAMA
   MOV CX,10
OTRO:   PUSH CX
   CALL SEMILLA
   CALL ALEATORIO
   CALL ESCALANDO
   CALL LEE
   POP CX
   LOOP OTRO
   CALL SALIR_DOS
PRINCI ENDP



SEMILLA PROC
PUSH AX
MOV AH,2CH
INT 21H  ; RETORNA CH=HORAS, EN FORMATO 00-23, MEDIANOCHE=0
         ; CL MINUTOS 00-59
         ;DH SEGUNDOS 00-59
         ;DL CENTESIMAS DE SEGUNDO 00-99
POP AX
RET
SEMILLA ENDP

ALEATORIO PROC
; XN+1=(2053*XN + 13849)MOD 2**16
; RETORNA EL NUMERO PSEUDOALEATORIO EN AX
MOV AX,DX ;CARGANDO A AX EL NUMERO SEMILLA tomado de la int 21 serv             2CH
MOV DX,0  ;CARGANDO CERO EN LA POSICION MAS SIGNIFICATIVA DEL               MULTIPLICANDO
MOV BX,2053 ; MULTIPLICADOR
MUL BX
MOV BX,13849 ;CARGA EN BX LA CONSTANTE ADITIVA
CLC
ADD AX,BX ; SUMA PARTES MENOS SIGNIFICATIVAS DEL RESULTADO
ADC DX,0 ; SUMA EL ACARREO SI ES NECESARIO
MOV BX,0FFFFH ; CARGAR LA CONSTANTE 2**16-1
DIV BX
MOV AX,DX ; MUEVE EL RESIDUO  AX
RET
ALEATORIO ENDP

ESCALANDO PROC
   ; ESCALANDO EL NUMERO PSEUDOALEATORIO OBTENIDO
   MOV DX,0
   MOV BX,00FFH ;NUMEROS ALEATORIOS ENTRE 0 Y 9
   DIV BX
   MOV AX,DX
   mov dl,ah
   call desempaqueta
   mov dl,al
   call desempaqueta
   ret
   
   RET
ESCALANDO ENDP

LEE PROC
   MOV AH,01
   INT 21H
RET
LEE ENDP

ESCRIBE PROC
   MOV AH,02
   INT 21H
 RET
ESCRIBE ENDP
SALIR_DOS PROC
   MOV AH,4CH
   INT 21H
RET
SALIR_DOS ENDP

   leer_caracter_con_eco PROC
    MOV AH,01
    INT 21H
    RET
   leer_caracter_con_eco ENDP
   
      escribe_car PROC
    PUSH AX
    MOV AH,02
    INT 21H
    POP AX
    RET
   escribe_car ENDP

   ascii_binario PROC
    CMP AL, 30h
    JL ERROR
    CMP AL,39h
    JG LETRA
    SUB AL,30h
    JMP FIN
LETRA:CMP AL,41
    JL ERROR
    CMP AL,46h
    JG ERROR
    SUB AL,37h
    JMP FIN
ERROR:MOV AL,0
FIN:RET
   ascii_binario ENDP
   
binario_ascii PROC
    CMP DL,9h
    JG SUMA37
    ADD DL,30h
    JMP FIN2
SUMA37:ADD DL,37h
FIN2:RET
binario_ascii ENDP

empaqueta PROC
    PUSH CX
    CALL leer_caracter_con_eco
    CALL ascii_binario
    MOV CL,04
    SHL AL,CL
    MOV CH,AL
    CALL leer_caracter_con_eco
    CALL ascii_binario
    ADD AL,CH
    POP CX
    RET
empaqueta ENDP

desempaqueta PROC
    PUSH DX
    PUSH CX
    MOV DH,DL
    MOV CL,4
    SHR DL,CL
    CALL binario_ascii
    CALL escribe_car
    MOV DL,DH
    AND DL,0Fh
    CALL binario_ascii
    CALL escribe_car
    POP CX
    POP DX
    RET
desempaqueta ENDP


CODESG ENDS
        END PRINCI
  