;PROGRAMA QUE LIMPIA LA PANTALLA

; Definicion de stack
.MODEL small
.STACK  100

;DEFINICION DE AREAS DE TRABAJO
.DATA
MSG1 DB "Hola Mundo$"
RENGLON DB 0
COLUMNA DB 0

.CODE
MAIN PROC FAR
   ;PROTOCOLO
   push ds
   sub ax,ax
   push ax
   MOV AX,@DATA
   MOV DS,AX
  

   ;INICIA PROGRAMA
    MOV CX,9
    CALL limpiar_pantalla
    MOV RENGLON, 10
    MOV COLUMNA, 20
   L: call  POS_CUR
    LEA DX, MSG1
    CALL escribeCad
    call salta
    ADD RENGLON,1
    ADD COLUMNA,1
    LOOP L

    MOV RENGLON, 11
    MOV COLUMNA, 21
    call  POS_CUR
    LEA DX, MSG1
    CALL escribeCad
    CALL saltamhghfh
 
   CALL SALIR

;------------------------------------ Subrutinas del Programa -------------------------------;

    POS_CUR PROC
    PUSH AX
    PUSH BX
    PUSH DX
    MOV AH,02
    MOV BH,0
    MOV DH,RENGLON ; RENGLON
    MOV DL,COLUMNA ; COLUMNA
    INT 10h
    POP DX
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
MOV BH,71h      ; FONDO BLANCO CON PRIMER PLANO AZUL
MOV CX,0000H    ;coordenada inicial
MOV DX,184FH    ;coordenada final
INT 10h
POP DX
POP CX
POP BX
POP AX
RET
limpiar_pantalla ENDP

;------------------------------------ Subrutinas esenciales ---------------------------------;

        leeChar_conEco PROC
            MOV AH,01
            INT 21H
            RET
        leeChar_conEco ENDP

        escribeChar PROC ;
            PUSH AX
            MOV  AH,02
            INT  21H
            POP  AX
            RET
        escribeChar ENDP    
        
        escribeCad PROC
            PUSH AX
            MOV  AH,09
            INT  21H
            POP  AX
            RET
        escribeCad ENDP

        ;salto de linea y retorno de carro
        salta PROC
            PUSH DX
            MOV  DL,0AH
            CALL escribeChar
            MOV  DL,0DH
            CALL escribeChar
            POP  DX
            RET
        salta ENDP

        ;Compromete DL y convierte de ascci a binario
        empaqueta PROC
            PUSH CX
            CALL leeChar_conEco
            CALL ascii_Bin
            MOV  CL,04
            SHL  AL,CL
            MOV  CH,AL
            CALL leeChar_conEco
            CALL ascii_Bin
            ADD  AL,CH
            POP  CX
            RET
        empaqueta ENDP

        ;Toma lo de empaqueta y lo convierte de binario a ascci compromete a DL
        desempaqueta PROC
            PUSH DX
            PUSH CX
            MOV  DH,DL
            MOV  CL,4
            SHR  DL,CL ;CORRIMIENTO A LA DERECHA
            CALL bin_Ascii
            CALL escribeChar
            MOV  DL,DH
            AND  DL,0FH ; Operrador logico and
            CALL bin_Ascii
            CALL escribeChar
            POP  CX
            POP  DX
            RET
        desempaqueta ENDP

        ;Convierte de binario a ascci
        bin_Ascii PROC
                    CMP DL,9H
                    JG  SUMA37
                    ADD DL,30H
                    JMP FIN2
            SUMA37: ADD DL,37H
            FIN2:   RET
        bin_Ascii ENDP 

        ;Convierte de ascci a binario
        ascii_Bin PROC
                    CMP AL,30H
                    JL  ERROR
                    CMP AL,39H
                    JG  LETRA
                    SUB AL,30H
                    JMP FIN
            LETRA:  CMP AL,41H
                    JL  ERROR
                    CMP AL,46H
                    JG  ERROR
                    SUB AL,37H
                    JMP FIN
            ERROR:  MOV AL,0
            FIN:    RET
        ascii_Bin ENDP 

        ;Salir DOS
        salir PROC
            MOV AH,4CH
            INT 21H
            RET
        salir ENDP

    MAIN ENDP
    END MAIN
