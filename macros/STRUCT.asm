Include MACROS.LIB
.model small
.stack 64
.data
    
    ALUMNO STRUC
        NOMBRE DB 30 DUP(0)
        MATRICULA DB 10 DUP(0)
        SEMESTRE DB 5 DUP(?)
        MATERIA DB 30 DUP(?)
        ESPECIAL DB 30 DUP(?)
        CADENA DB 20,?, 20 DUP ("$"), "$"
    ALUMNO ENDS
    
    ESTUDIANTE ALUMNO <'PEDRO RAMON$','202102001$','4TO$','LENGUAJE ENSAMBLADOR$','SI, ES ESPECIALITO$'>
    
.code

MAIN PROC
    PUSH DS
    SUB AX, AX
    PUSH AX
    MOV AX, @DATA
    MOV DS,AX
    
    ; PROGRAMA
    
    ESCRIBIR_CAD ESTUDIANTE.NOMBRE
    alimentar_linea
    ESCRIBIR_CAD ESTUDIANTE.MATRICULA
    alimentar_linea
    ESCRIBIR_CAD ESTUDIANTE.SEMESTRE
    alimentar_linea
    ESCRIBIR_CAD ESTUDIANTE.MATERIA
    alimentar_linea
    ESCRIBIR_CAD ESTUDIANTE.ESPECIAL    

    leerCadena ESTUDIANTE.CADENA
    
    
mov ax, 4c00h
int 21h
RET
MAIN ENDP

END MAIN

;Siempre que hagamos un programa debemos tener docuemntacion