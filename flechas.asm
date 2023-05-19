;PROGRAMA QUE LIMPIA LA PANTALLA

; Definicion de stack
.MODEL small
.STACK  100

;DEFINICION DE AREAS DE TRABAJO
.DATA
MSG1 DB "Ingrese cadena a desplegar: $"
MSG2 DB 13, 10, " $"
CADENA DB 40,?, 40 DUP ("$"),"$"
RENGLON DB 0
COLUMNA DB 0

.CODE
PRINCI PROC FAR
   ;PROTOCOLO
   PUSH DS
   SUB AX,AX
   PUSH AX
   MOV AX,@DATA
   MOV DS,AX
   MOV ES,AX

   ;INICIA PROGRAMA

    ;CALL limpiar_pantalla
	CALL PREINI
	
   RET
PRINCI ENDP


PREINI PROC NEAR
	CALL limpiar_pantalla
	LEA DX, MSG1
	CALL escribe_cadena
	LEA DX, MSG2
	CALL escribe_cadena
	CALL leercadena
	MOV AH,10H
	INT 16H
	CMP AL,00H
	JE RASTREA
	CMP AL,0E0H
	JE RASTREA
	JMP FINAL
RASTREA:
	CMP AH,48H ;Código de rastreo de la flecha arriba
	JE ARRIBA
	CMP AH,50H ;Codigo de rastreo de la flecha abajo
	JE ABAJO
ARRIBA:
    MOV RENGLON, 00
    MOV COLUMNA, 27H
	CALL POS_CUR
	
	MOV CX,00
    LEA SI, CADENA+1
    MOV CL, [SI]
    LEA DI, CADENA+2
OTRO:   
	MOV DL, [DI]
    INC DI
    CALL escribe_car
    LOOP OTRO
	JMP FINAL
ABAJO:
    MOV RENGLON, 18H
    MOV COLUMNA, 27H
	CALL POS_CUR
	
	MOV CX,00
    LEA SI, CADENA+1
    MOV CL, [SI]
    LEA DI, CADENA+2
OTRO2:   
	MOV DL, [DI]
    INC DI
    LOOP OTRO2
	
	MOV CL,[SI]
OTRO3:
	MOV DL,[DI]
	DEC DI
	CALL escribe_car
	LOOP OTRO3

FINAL:	CALL SALIR_DOS
		RET
PREINI ENDP

leercadena PROC
	PUSH DX
	PUSH AX
	LEA DX,CADENA
	MOV AH,0AH
	INT 21H
	POP AX
	POP DX
	RET
leercadena ENDP

escribe_cadena PROC
	PUSH AX
	MOV AH,09
	INT 21H
	POP AX
escribe_cadena ENDP

SALIR_DOS PROC
   MOV AH,4CH
   INT 21H
RET
SALIR_DOS ENDP

POS_CUR PROC
PUSH AX
PUSH BX
MOV AH,02
MOV BH,0
MOV DH,RENGLON ; RENGLON
MOV DL,COLUMNA ; COLUMNA
INT 10H
POP BX
POP AX
RET
POS_CUR ENDP

limpiar_pantalla PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AX,0600h
MOV BH,0dh      ; FONDO BLANCO CON PRIMER PLANO AZUL
MOV CX,0000H
MOV DX,184FH
INT 10h
POP DX
POP CX
POP BX
POP AX
RET
limpiar_pantalla ENDP

escribe_car PROC
	PUSH AX
	MOV AH,02 ; Caracter a desplegar almacenado en dl
	INT 21h
	POP AX
	RET
escribe_car ENDP

END PRINCI
  
