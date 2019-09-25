; nasm
		org 	7c00h		; 代码会被加载到 0x7c00 位置
        mov 	ax, cs
        mov		ds, ax
        mov		es, ax
        call 	PrintStr
PrintStr:
        mov		ax, msg
        mov		bp, ax		; es:bp = str
        mov		cx, 16		; cx = len
        mov		ax, 1301h	; ah => Write String 
        mov		bx, 000ch	; bh => 页表号0 bl => 黑底红字
        mov		dl, 0
        int		10h
        ret
msg:    db	"33333, World!",13, 10
times 	510-($-$$)	db 0
        dw 0xaa55
