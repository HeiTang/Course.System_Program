; 定義數據段，存放數據
data segment
    string db 13,10,'Hello',13,10,'$'
data ends

; 定義代碼段，執行的程式碼
code segment
    ; 偽指令，告訴組譯器代碼段的對應
    assume cs:code, ds:data

start:
    mov ax, data       ; 將 data 的地址放到 ax 暫存器
    mov ds, ax         ; 將 ax 的值放到 ds 暫存器
    lea dx, string     ; 將 string 變數的地址放進 dx 暫存器
    
    mov ah, 09h        ; 09 對應的是將字串輸出到螢幕上
    int 21h            ; 調用系統功能，對應的是目前 ah 暫存器中的值
    
    ;---------------------------------------
    
    mov ax, 0000h
    int 60h            ; 調用系統功能，對應的是目前 ah 暫存器中的值

    ;--------------------------------------- 主控權交還程式

    mov ax,4c00h       ; 退出程式
    int 21h            ; 調用系統功能

    ;--------------------------------------- 退出

code ends

end start  ; 讓組譯器知道程式的進入點，SYMDEB DEBUG 指令 -a