DATAS SEGMENT  
DATAS ENDS
 
STACKS SEGMENT STACK 'S'
    ;堆栈段程式
    DW 80 DUP(0)
STACKS ENDS
 
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
MAIN	PROC    FAR
    MOV AX,DATAS
    MOV DS,AX            ;將數據DATAS存入DS中
;------------------------------------------------------------------  
		MOV DX,SEG INT_60H   ;SEG標號段位址
		MOV DS,DX
		LEA DX,INT_60H       ;調用子函數INT_60H 取偏移地址	
		
		;AH=25H功能:置中斷向量AL=中断号 DS:DX=入口
		MOV AH,25H                
		MOV AL,60H           ;設定新的60H中斷向量
		INT 21H
		
		;退出程序并返回操作系统
		MOV AH,4CH
    INT 21H
MAIN	ENDP	
;------------------------------------------------------------------
;子程序:顯示背景 FAR(主程序和子程序不在同一程式段)
INT_60H		PROC	FAR
    PUSH AX		 ;保存寄存器
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DS
    
    MOV AX,DATAS
    MOV DS,AX            ;將數據段DATAS存入DS中
	mov dl,68        ; D
    mov ah, 02h      ; 09h 對應的是將字串輸出到螢幕上
    int 21h          ; 調用系統功能，對應的是目前 ah 暫存器中的值
	mov dl,48        ; 0
    mov ah, 02h      
    int 21h
	mov dl,55 		 ; 7
    mov ah, 02h      
    int 21h 
	mov dl,53 		 ; 5
    mov ah, 02h      
    int 21h 
	mov dl,50 		 ; 2
    mov ah, 02h      
    int 21h 
	mov dl,48		 ; 0
    mov ah, 02h      
    int 21h 
	mov dl,55 		 ; 7
    mov ah, 02h      
    int 21h 
	mov dl,49 	     ; 1
    mov ah, 02h      
    int 21h          
	mov dl,10        ; 換行
    mov ah, 02h      
    int 21h
	mov dl,13        ; CR (字元)
    mov ah, 02h      
    int 21h 
	POP	DS
	POP	DX
	POP	CX
	POP	BX
    POP	AX		      ;恢复寄存器  
    IRET	              ;中断返回
INT_60H  ENDP
;------------------------------------------------------------------         
CODES ENDS
END MAIN