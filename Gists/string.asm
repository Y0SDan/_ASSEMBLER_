;DEFINICON DE SEGMENTO DE PILA
STACKSG SEGMENT para STACK 'STACK'
    DB 20 DUP(0)                    ;DEFINE EL ESPACIO DE LA PILA
STACKSG ENDS

;Definicion de áreas de trabajo

;Definicion segmento de datos
DATASG SEGMENT PARA 'DATA'
    MEN1        DB 'Hola Mundo $'
    SALTA       DB 13,10,'$' 
    INST1       DB 'Proporcione 20 caracteres'
    CONTENIDO   DB 20 DUP("$"), "$"             ;Crea un arreglo de caracteres de tamño 21 y lo rellena con $
DATASG ENDS    

;Definicion segmento codigo
CODE SEGMENT PARA 'CODE'

    MAIN PROC FAR                                   ;Inicia proceso
        ASSUME CS:CODESG, DS:DATASG, SS:STACKSG     ;Alineacion de segmentos
        
        ;PROTOCOLO
        PUSH DS
        SUB  AX,AX
        PUSH AX
        MOV  AX,SEG DATASG
        MOV  DS,AX

        

    