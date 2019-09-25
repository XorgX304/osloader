
        org 0x7c00

        ; read sector
        mov     ax, 0x0201      ; ah -> read; al -> count
        mov     cx, 0x0002      ; cylinder -> 0; sector -> 2
        mov     dh, 0           ; head -> 0
        mov     dl, 80h         ; drive
        mov     di, 0
        mov     es, di
        mov     bx, 0x7e00      ; 0 : 0x7e00

        int     13h             ; read 

        jmp     $

times   510 - ($-$$)    db 0
        db      0x55, 0xaa
times   1024    db 'a'

; boot with qemu
; qemu-system-x86_64 -drive format=raw,file=read_sector -s -S
; gdb -ex 'target remote localhost:1234'     -ex 'break *0x7c00'     -ex 'continue'