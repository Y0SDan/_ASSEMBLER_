
; DEFINICION SEGMENTO DE PILA
STACKSG segment para stack 'stack'       
        DB 20 DUP (0)                   ; Define espacio en la pila
STACKSG ENDS

;DEFINICION DE AREAS DE TRABAJO

 ; DEFINICION  SEGMENTO DE DATOS
DATASG SEGMENT PARA 'DATA'
    MEN1 DB  'INGRESE EL TOTAL DE NUMEROS : $'
    MEN2 DB  'INGRESE UN NUMEROS : $'
    MEN3 DB  'PARES ENCONTRADOS : $'
    MEN4 DB  'TOTAL DE PARES ENCONTRADOS: $'

CONTENIDO DB 100 DUP ("$"),  "$" ;REPITE EL SIGNO DE PESOS 
DATASG ENDS

; DEFINICION  SEGMENTO DE CODIGO
CODESG SEGMENT PARA 'CODE'
  
MAIN PROC FAR                             ;Inicia proceso
   ASSUME SS:STACKSG, DS:DATASG,CS:CODESG ;  ;Alineaci?n de Segmentos
         
           ;PROTOCOLO
           PUSH DS
           SUB AX,AX
           PUSH AX
           MOV AX,SEG DATASG
           MOV DS,AX

           ;INICIA PROGRAMA
           
           LEA DX, MEN1
           CALL ESCRIBE_CADENA
           CALL ALIMENTAR_L
           CALL EMPAQUETAR
           CALL ALIMENTAR_L
           MOV CX, 0
           MOV CL, AL
           MOV BX, 0
           LEA SI, CONTENIDO
NUM:       LEA DX, MEN2     ; ESCRIBA UN NUMERO
           CALL ESCRIBE_CADENA
           CALL EMPAQUETAR
           CALL ALIMENTAR_L
           MOV BL, AL
           MOV DL, 2
           DIV DL
           CMP AH, 0
           JE PAR
L1:        LOOP NUM
           JMP FINEJ1
PAR:       MOV [SI], BL         ; GUARDAR NUMERO EN SI
           INC SI
           INC BH
           JMP L1
FINEJ1:       MOV CL, BH
           MOV DX, OFFSET MEN3      ; PARES ENCONTRADOS
           CALL ESCRIBE_CADENA
           CALL ALIMENTAR_L
           LEA SI, CONTENIDO
ESCR:       MOV DL, [SI]
           CALL DESEMPAQUETAR
           CALL ALIMENTAR_L
           INC SI
           LOOP ESCR
           MOV DX, OFFSET MEN4      ; TOTAL DE PARES ENCONTRADOS
           CALL ESCRIBE_CADENA
           MOV DL, BH
           CALL DESEMPAQUETAR
           CALL ALIMENTAR_L
           
           
           

           RET
            MAIN ENDP             ;Fin proceso
            
            ;Aqui van las subrutinas
            
           ESCRIBE_CADENA PROC
            PUSH AX
            MOV AH,09
            INT 21H
            POP AX
            RET
           ESCRIBE_CADENA ENDP
           
           LECTURA_C PROC
            MOV AH,01
            INT 21H
            RET
           LECTURA_C ENDP
           
           ESCRIBIR_C PROC
            PUSH AX
            MOV AH,02
            INT 21H
            POP AX
            RET
           ESCRIBIR_C ENDP
           
           ALIMENTAR_L PROC
            PUSH DX
            MOV DL, 0AH
            CALL ESCRIBIR_C
            MOV DL, 0DH
            CALL ESCRIBIR_C
            POP DX
            RET
           ALIMENTAR_L ENDP
           
           SAL_A_DOS PROC
            MOV AH,4CH
            INT 21H
            RET
           SAL_A_DOS ENDP
           
           LEER_CSE PROC
            MOV AH,08
            INT 21H
            RET
           LEER_CSE ENDP
           
           ASCII_BINARIO PROC
           CMP AL,30H
           JL ERROR
           CMP AL,39H
           JG LETRA
           SUB AL, 30H
           JMP FIN
LETRA:     CMP AL, 41H
           JL ERROR
           CMP AL,46H
           JG ERROR
           SUB AL, 37H
           JMP FIN
ERROR:     MOV AL,0
FIN:       RET
           ASCII_BINARIO ENDP

           BINARIO_ASCII PROC
            CMP DL, 9H
            JG SUMA37
            ADD DL, 30H
            JMP FINAL
SUMA37:     ADD DL, 37H
FINAL:      RET
           BINARIO_ASCII ENDP
           
           EMPAQUETAR PROC
            PUSH CX
            CALL LECTURA_C
            CALL ASCII_BINARIO
            MOV CL, 04
            SHL AL,CL
            MOV CH,AL
            CALL LECTURA_C
            CALL ASCII_BINARIO
            ADD AL, CH
            POP CX
            RET
           EMPAQUETAR ENDP
           
           
           DESEMPAQUETAR PROC
            PUSH DX
            PUSH CX
            MOV DH, DL
            MOV CL,4
            SHR DL,CL
            CALL BINARIO_ASCII
            CALL ESCRIBIR_C
            MOV DL,DH
            AND DL,0FH
            CALL BINARIO_ASCII
            CALL ESCRIBIR_C
            POP CX
            POP DX
            RET
           DESEMPAQUETAR ENDP
           
           
           
    
    
    
    
    
    
CODESG ENDS                 ;Fin segemento de c?dico
END MAIN                  ;Fin de programa


