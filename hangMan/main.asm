;Hangman "RichiSoft y asociados :p"
INCLUDE MACROS.LIB

.MODEL small
.STACK 100H

.DATA
    MEN1  DB 'Ingresa frase',10,'(Maximo 20 caracteres)',10,10,'$'
    WORD1 DB 20,?, 20 DUP ("$"),"$"
    WORD2 DB 20,?, 20 DUP ("$"),"$"
    WORD3 DB 20,?, 20 DUP ("$"),"$"
    WORD4 DB 20,?, 20 DUP ("$"),"$"
    WORD5 DB 20,?, 20 DUP ("$"),"$"

    WORD_1 DB 250 DUP("$"),'$'
    WORD_2 DB 250 DUP("$"),'$'
    WORD_3 DB 250 DUP("$"),'$'
    WORD_4 DB 250 DUP("$"),'$'
    WORD_5 DB 250 DUP("$"),'$'

    wordLength DB 5 DUP(0)



.CODE
    MAIN PROC FAR
        PUSH DS
        SUB  AX,AX
        MOV  AX,@data
        MOV  DS,AX
        MOV  ES,AX

        ;Start program
        
            MOV DL,MEN1
            ESCRIBIR_CAD MEN1

            leerCadena WORD1
            alimentar_linea
            alimentar_linea

            MOV DL,MEN1
            ESCRIBIR_CAD MEN1

            leerCadena WORD2
            alimentar_linea
            alimentar_linea

            MOV DL,MEN1
            ESCRIBIR_CAD MEN1

            leerCadena WORD3
            alimentar_linea
            alimentar_linea

            MOV DL,MEN1
            ESCRIBIR_CAD MEN1

            leerCadena WORD4
            alimentar_linea
            alimentar_linea

            MOV DL,MEN1
            ESCRIBIR_CAD MEN1
 
            leerCadena WORD5
            alimentar_linea
            alimentar_linea

        ;Crea la cadena con guiones y con la extensión actual de la cadena
        INI_CAD:
            SUB CX,CX
            LEA SI,WORD1 + 2

            alimentar_linea
            alimentar_linea
            ESCRIBIR [SI]
            alimentar_linea
            alimentar_linea


        LOOP_START:
            MOV AL,[SI]
            CMP AL,'$'
            JE  LOOP_END
            CMP AL,32
            JE SUBS
            S:
              INC CX      ;Incrementar el contador de longitud
              INC SI      ;Avanzar al siguiente caracter
        JMP LOOP_START

        SUBS: 
            DEC CL
            JMP S

        LOOP_END:

        MOV SI,0
        SUB CL,1
        MOV wordLength[SI],CL

        DESEMPAQUETAR wordLength[SI]
        alimentar_linea

        LEA SI,WORD1 + 2
        LEA DI,WORD_1
        L1:
            MOV AL,[SI]
            CMP AL,'$'
            JE BYE
            CMP AL,32
            JE ESP
            MOV [DI],'_'
            G:
              INC DI
              INC SI
        LOOP L1
        
        ESP:
            MOV [DI],32
            JMP G


        BYE:
            ESCRIBIR_CAD WORD_1
            alimentar_linea
            alimentar_linea
            salir
    MAIN ENDP
END MAIN    
