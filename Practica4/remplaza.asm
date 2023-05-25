.MODEL small
.STACK 100

.DATA
    MSG1     DB 'Ingresa un texto de 10 renglones:',10,'(enter para pasar al siguiente renglon)',13,10,'$'
    LINEA1   DB 100,?,100 DUP('$'),'$'
    LINEA2   DB 100,?,100 DUP('$'),'$'
    LINEA3   DB 100,?,100 DUP('$'),'$'
    LINEA4   DB 100,?,100 DUP('$'),'$'
    LINEA5   DB 100,?,100 DUP('$'),'$'
    LINEA6   DB 100,?,100 DUP('$'),'$'
    LINEA7   DB 100,?,100 DUP('$'),'$'
    LINEA8   DB 100,?,100 DUP('$'),'$'
    LINEA9   DB 100,?,100 DUP('$'),'$'
    LINEA10  DB 100,?,100 DUP('$'),'$'
    NEWLINE1  DB 100 DUP ('$'),'$'
    NEWLINE2  DB 100 DUP ('$'),'$'
    NEWLINE3  DB 100 DUP ('$'),'$'
    NEWLINE4  DB 100 DUP ('$'),'$'
    NEWLINE5  DB 100 DUP ('$'),'$'
    NEWLINE6  DB 100 DUP ('$'),'$'
    NEWLINE7  DB 100 DUP ('$'),'$'
    NEWLINE8  DB 100 DUP ('$'),'$'
    NEWLINE9  DB 100 DUP ('$'),'$'
    NEWLINE10  DB 100 DUP ('$'),'$'


.CODE
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB AX,AX
        PUSH AX
        MOV AX,@data
        MOV DS,AX
        MOV ES,AX

        ;Inicia
        LEA DX,MSG1
        CALL escribeCad

        LEA DX,LINEA1
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA2
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA3
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA4
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA5
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA6
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA7
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA8
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA9
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA10
        CALL leeCadxBuf
        CALL salta



        RET
    MAIN ENDP
    ;--------------- Subrutinas del programa-----------
    busca PROC
        ;LEA DX,INST1
CALL MENSAJE
CALL LEE; AL  = CARACTER PRESIONADO
mov bl,al
call salta

LEA DX,INST2
CALL MENSAJE
CALL LEE
MOV Bh,AL
ADD BH,0
call salta

MOV BL,"O"
MOV BH,"A"

CLD
L:MOV AL,BL
CMP [DI],'$'
JE EXIT
MOV CX,11
LEA DI,MEN1
REPNE SCASB
JNE EXIT
DEC DI ; DECREMENTAR LA DIRECCION PARA HACER EL REMPLAZO
MOV BYTE PTR[DI],BH ;mover un byte a la localidad apuntada por DI

        RET
    busca ENDP
    ;--------------- Subrutinas esenciales -------------

    ;Lee una cadena x buffer
    leeCadxBuf PROC
        PUSH AX
        MOV  AH,0AH      ;lee por buffer
        INT  21H 
        POP  AX
        
        RET
    leeCadxBuf ENDP

    escribeCad PROC
        PUSH AX
        MOV  AH,09
        INT  21H
        POP  AX
        RET
    escribeCad ENDP

    salta PROC
        PUSH DX
        MOV  DL,0AH
        CALL escribeChar
        MOV  DL,0DH
        CALL escribeChar
        POP  DX
        RET
    salta ENDP

    escribeChar PROC
        PUSH AX
        MOV  AH,02
        INT  21H
        POP  AX
        RET
    escribeChar ENDP

    ;Lee un caracter con eco (desde teclado) El registo de guarda en AL
    leeChar_conEco PROC
        PUSH AX
        MOV  AH,01
        INT  21H
        POP  AX
            
        RET
    leeChar_conEco ENDP

END MAIN        