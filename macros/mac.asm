include macros.lib
.model small
.stack 64
.data
num db 0

.code
MAIN PROC FAR   
    inicio2
    mov cx,9
    ini:
    mov num,cl
    imprime_num num
    loop ini 
    sal_a_dos

    MAIN ENDP
END MAIN


