;Programa que debe imprimir un mensaje 
;en el centro arriba y en el centro abajo
;presinonando las teclas repag y avpag

;Definicion de stack
.MODEL small
.STACK 100

;Definicion areas de trabajo
.DATA
    ;Variables
    MEN1 DB "¡¡¡¡¡Hello world!!!!!"

.CODE   
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB AX,AX    
        PUSH AX
        MOV AX,@DATA
        MOV DS,AX

        ;INICIA PROGRAMA
        