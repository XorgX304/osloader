
        org 0x7c00

copy_fist_sector:
        xor     ax, ax
        mov     es, ax
        mov     di, 0x600       ; dst = [es:di]
        mov     ds, ax
        mov     si, 0x7c00      ; src = [ds:si]
        mov     cx, 0x200       ; size = 0x200
        cld             ; clear DF (0) -> incrementing
        rep     movsb 
        
        mov     ax, 0x7c00       
        mov     sp, ax          ; stack top

        push    0x61b
        ret                     ; jmp 0x61d

select_os:
        call    boot_menu
        cmp     al, 3
        jg      select_os

        ; reset 
        xor ah, ah ; reset drive
        xor dl, dl
        int 13h

        ; read loader sector
        mov     di, 0
        mov     ds, di

        shl     al, 4
        mov     ah, 0
        mov     bx, 447 + 0x7c00
        add     bx, ax

        mov     ax, 0x0201              ; al -> count   
        mov     cx, [bx]                ; cylinder and sector

        dec     bx
        mov     dh, [bx]                ; head
        mov     dl, 0x80                ; drive

        mov     di, 0
        mov     es, di
        mov     bx, 0x7c00              ; es : bx

        int     0x13

        call    print_rn
        
        mov     ax, 0x6b0               ; booting
        mov     cx, 22
        mov     dx, 0
        call    print_s

        call    print_rn

        push    0x7c00
        ret                    

        jmp     $

boot_menu:
        ; print hint
        mov	ax, 0x69a       ; boot_hint
        mov     cx, 22
        mov     dx, 0x0000
        call    print_s

        ; get input 
        mov     ah, 0
        int     0x16

        call    print_char
        sub     ax, 0x30
        ret

        
; ax = str; cx = len; dx = (row, column)
print_s:
        mov	bp, ax		; es:bp = str
        mov	ax, 0x1301	; ah => Write String 
        mov	bx, 0x000c	; bh => 页表号0 bl => 黑底红字
        int	0x10
        ret 

print_char:
        mov     ah, 9
        mov	bx, 0x000c
        mov     cx, 1
        int     0x10
        ret

print_rn:
        mov     al, 13
        call    print_char
        mov     al, 10
        call    print_char
        ret
        
; code_size = 0x9b
boot_hint:      db      "Input os id to boot", 13, 10, 0 
booting:        db      "booting...         ", 13, 10, 0      
times   446 - ($-$$)    db 0
db      0x00, 0x02, 0x00
times   13      db      0
db      0x00, 0x03, 0x00
times   13      db      0
db      0x00, 0x04, 0x00
times   13      db      0
db      0x00, 0x05, 0x00
times   13      db      0
db      0x55, 0xaa


