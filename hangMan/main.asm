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
;-------------------------------------------------------------------------------
        ;Crea la cadena con guiones y con la extensión actual de la cadena
            SUB CX,CX
            SUB BX,BX
            LEA SI,WORD1 + 2

        LOOP_START:
            MOV AL,[SI]
            CMP AL,'$'
            JE  LOOP_END
            CMP AL,32
            JE  SUBS
            S:
              INC CX      ;Incrementar el contador de longitud
              INC SI      ;Avanzar al siguiente caracter
        JMP LOOP_START

        SUBS: 
            INC BL
            JMP S

        LOOP_END:

        MOV SI,0
        MOV BH,CL
        DEC BH ;Decrementamos para no incluir el final de cadena en el conteo
        SUB BH,BL ;LE RESTAMOS LOS ESPACIOS
        MOV wordLength[SI],BH

        DESEMPAQUETAR wordLength[SI]
        alimentar_linea

        LEA SI,WORD1 + 2
        LEA DI,WORD_1
        L1:
            MOV AL,[SI]
            CMP AL,'$'
            JE  BYE
            CMP AL,32
            JE  ESP
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
            

;------------------------------------------------------
    ;Cadena 2
    SUB CX,CX
    SUB BX,BX
    LEA SI,WORD2 + 2

    LOOP_START2:
        MOV AL,[SI]
        CMP AL,'$'
        JE  LOOP_END2
        CMP AL,32
        JE  SUBS2
        S2:
          INC CX      ;Incrementar el contador de longitud
          INC SI      ;Avanzar al siguiente caracter
    JMP LOOP_START2

    SUBS2: 
        INC BL
        JMP S2

    LOOP_END2:

        MOV SI,1
        MOV BH,CL
        DEC BH ;Decrementamos para no incluir el final de cadena en el conteo
        SUB BH,BL ;LE RESTAMOS LOS ESPACIOS
        MOV wordLength[SI],BH

        DESEMPAQUETAR wordLength[SI]
        alimentar_linea

        LEA SI,WORD2 + 2
        LEA DI,WORD_2
        L2:
            MOV AL,[SI]
            CMP AL,'$'
            JE  BYE2
            CMP AL,32
            JE  ESP2
            MOV [DI],'_'
            G2:
              INC DI
              INC SI
        LOOP L2
        
        ESP2:
            MOV [DI],32
            JMP G2


        BYE2:
            ESCRIBIR_CAD WORD_2
            alimentar_linea
            alimentar_linea

;-------------------------------------------------------------
    ;Cadena 3
    SUB CX,CX
    SUB BX,BX
    LEA SI,WORD3 + 2

    LOOP_START3:
        MOV AL,[SI]
        CMP AL,'$'
        JE  LOOP_END3
        CMP AL,32
        JE  SUBS3
        S3:
          INC CX      ;Incrementar el contador de longitud
          INC SI      ;Avanzar al siguiente caracter
    JMP LOOP_START3

    SUBS3: 
        INC BL
        JMP S3

    LOOP_END3:

        MOV SI,2
        MOV BH,CL
        DEC BH ;Decrementamos para no incluir el final de cadena en el conteo
        SUB BH,BL ;LE RESTAMOS LOS ESPACIOS
        MOV wordLength[SI],BH

        DESEMPAQUETAR wordLength[SI]
        alimentar_linea

        LEA SI,WORD3 + 2
        LEA DI,WORD_3
        L3:
            MOV AL,[SI]
            CMP AL,'$'
            JE  BYE3
            CMP AL,32
            JE  ESP3
            MOV [DI],'_'
            G3:
              INC DI
              INC SI
        LOOP L3
        
        ESP3:
            MOV [DI],32
            JMP G3


        BYE3:
            ESCRIBIR_CAD WORD_3
            alimentar_linea
            alimentar_linea
;-------------------------------------------------------------
    ;Cadena 3
    SUB CX,CX
    SUB BX,BX
    LEA SI,WORD4 + 2

    LOOP_START4:
        MOV AL,[SI]
        CMP AL,'$'
        JE  LOOP_END4
        CMP AL,32
        JE  SUBS4
        S4:
          INC CX      ;Incrementar el contador de longitud
          INC SI      ;Avanzar al siguiente caracter
    JMP LOOP_START4

    SUBS4: 
        INC BL
        JMP S4

    LOOP_END4:

        MOV SI,3
        MOV BH,CL
        DEC BH ;Decrementamos para no incluir el final de cadena en el conteo
        SUB BH,BL ;LE RESTAMOS LOS ESPACIOS
        MOV wordLength[SI],BH

        DESEMPAQUETAR wordLength[SI]
        alimentar_linea

        LEA SI,WORD4 + 2
        LEA DI,WORD_4
        L4:
            MOV AL,[SI]
            CMP AL,'$'
            JE  BYE4
            CMP AL,32
            JE  ESP4
            MOV [DI],'_'
            G4:
              INC DI
              INC SI
        LOOP L4
        
        ESP4:
            MOV [DI],32
            JMP G4


        BYE4:
            ESCRIBIR_CAD WORD_4
            alimentar_linea
            alimentar_linea
;-------------------------------------------------------------
    ;Cadena 3
    SUB CX,CX
    SUB BX,BX
    LEA SI,WORD5 + 2

    LOOP_START5:
        MOV AL,[SI]
        CMP AL,'$'
        JE  LOOP_END5
        CMP AL,32
        JE  SUBS5
        S5:
          INC CX      ;Incrementar el contador de longitud
          INC SI      ;Avanzar al siguiente caracter
    JMP LOOP_START5

    SUBS5: 
        INC BL
        JMP S5

    LOOP_END5:

        MOV SI,4
        MOV BH,CL
        DEC BH ;Decrementamos para no incluir el final de cadena en el conteo
        SUB BH,BL ;LE RESTAMOS LOS ESPACIOS
        MOV wordLength[SI],BH

        DESEMPAQUETAR wordLength[SI]
        alimentar_linea

        LEA SI,WORD5 + 2
        LEA DI,WORD_5
        L5:
            MOV AL,[SI]
            CMP AL,'$'
            JE  BYE5
            CMP AL,32
            JE  ESP5
            MOV [DI],'_'
            G5:
              INC DI
              INC SI
        LOOP L5
        
        ESP5:
            MOV [DI],32
            JMP G5


        BYE5:
            ESCRIBIR_CAD WORD_5
            alimentar_linea
            alimentar_linea

    salir
    MAIN ENDP
END MAIN    

;Las cadenas originales estan en Word1,word2,...,word5
;Las longitudes estan en el arreglo "wordLength"
;en orden ascendente, las cadenas modificadas estan 
;en word_1, word_2,...,word_5