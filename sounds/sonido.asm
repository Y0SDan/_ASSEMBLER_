.model small
.stack 100h
.data
.code

org 100h

main:
  mov ax, @data
  mov ds, ax

  ; Set up timer for tone generation
  mov al, 00110110b
  out 43h, al
  mov ax, 1193 ; Adjust this value to change the frequency (higher = higher pitch)
  out 42h, al
  mov al, ah
  out 42h, al

  ; Play the melody
  call play_note
  call play_note
  call play_note
  call play_note
  call play_note
  call play_note
  call play_note

  mov ax, 4C00h
  int 21h

play_note:
  mov cx, 10000 ; Adjust this value to change the duration of each note
  mov dx, 03C8h ; Adjust this value to change the volume (lower = softer)
  out dx, al
  mov dx, 03C9h ; Adjust this value to change the volume (lower = softer)
  mov al, 10h
  out dx, al
  mov dx, 61h
  in al, dx
  or al, 00000011b
  out dx, al
  mov cx, 4000 ; Delay to control note duration
  ;delay_loop:
  loop PLAY_NOTE

  mov dx, 61h
  in al, dx
  and al, 11111100b
  out dx, al

  ret

end main