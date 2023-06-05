; Hangman game in TASM

.MODEL small
.STACK 100H

.DATA
    wordList db 'dog', 'cat', 'bird', 'fish', 'horse', '$'
    wordLength db 3, 3, 4, 4, 5
    currentWord db ?
    currentWordLength db ?
    displayString db ?, ?, ?, ?, ?, '$'
    lives db 6
    guess db ?
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Choose a random word from the list
    mov ah, 2ch
    int 21h
    xor dx, dx
    mov cx, 5
    div cx
    mov currentWord, dl

    ; Set the current word length and display string
    mov bx, offset wordLength
    xor ax, ax
    mov al, currentWord
    add bx, ax
    mov al, [bx]
    mov currentWordLength, al
    xor cx, cx
    mov cl, currentWordLength
set_display_string:
    mov bx, offset displayString
    add bx, cx
    dec bx
    mov byte ptr [bx], '_'
    loop set_display_string

display_game:
; Display the current game state
mov ah, 9
lea dx, displayString
int 21h

; Check if the game is over (win or lose)
cmp lives, 0
je game_over_lose
mov si, offset displayString
check_win:
lodsb
cmp al, '_'
jne continue_game
jmp check_win

continue_game:
; Get user input (guess)
get_input:
mov ah, 1
int 21h
cmp al, 'a'
jl get_input
cmp al, 'z'
jg get_input
mov guess, al

check_guess:
; Check if the guess is correct and update the display string accordingly

game_over_lose:
; Display losing message

game_over_win:
; Display winning message

main endp

end main

