; 定義數據段，存放數據
data segment

data ends

; 定義代碼段，執行的程式碼
code segment
    ; 偽指令，告訴組譯器代碼段的對應
    assume cs:code, ds:data
start:

    int 60h        ; 調用系統功能，對應的是目前 ah 暫存器中的值
	;--------------------------------------主控權交還程式
    mov ax, 4c00h    ; 退出程式
	;mov ah, 4ch
    int 21h          ; 調用系統功能
	;--------------------------------------退出
code ends

end start   ; 讓組譯器知道程式的進入點