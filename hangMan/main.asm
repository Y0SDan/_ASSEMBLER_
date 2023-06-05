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

    WORD_1 DB ?,'$'
    WORD_2 DB ?,'$'
    WORD_3 DB ?,'$'
    WORD_4 DB ?,'$'
    WORD_5 DB ?,'$'

    wordLength DB 5 DUP(0)



.CODE
    MAIN PROC FAR
        PUSH DS
        SUB  AX,AX
        MOV  AX,@data
        MOV  DS,AX
        MOV  ES,AX

        ;Start program
        SUB CX,CX
        MOV CX,05h        ;Contador para las 5 frases

        
        L1:
            MOV DL,MEN1
            ESCRIBIR_CAD MEN1

            ;Rellenando las 5 frases
            CMP CX,5
                JMP C1
            CMP CX,4
                JMP C2
            CMP CX,3
                JMP C3
            CMP CX,2
                JMP C4
            CMP CX,1
                JMP C5
        LUPE:
            LOOP L1

        JMP INI_CAD

        C1:
            leerCadena WORD1
            alimentar_linea
            alimentar_linea
            JMP LUPE
        C2:
            leerCadena WORD2
            alimentar_linea
            alimentar_linea

            JMP LUPE
        C3:
            alimentar_linea
            alimentar_linea
            JMP LUPE
        C4:
            leerCadena WORD4
            alimentar_linea
            alimentar_linea
            JMP LUPE
        C5:
            leerCadena WORD5
            alimentar_linea
            alimentar_linea
            JMP LUPE

        ;Crea la cadena con guiones y con la extensión actual de la cadena
        INI_CAD:
            SUB CX,CX
            LEA SI,WORD1 + 2

        LOOP_START:
            MOV AL,[SI]
            CMP AL,'$'
            JE  LOOP_END

            INC CX      ;Incrementar el contador de longitud
            INC SI      ;Avanzar al siguiente caracter
        JMP LOOP_START

        LOOP_END:

        MOV SI,0
        MOV wordLength[SI],CL

        DESEMPAQUETAR wordLength[SI]

        BYE:
            salir
    MAIN ENDP
END MAIN    
