STACK	SEGMENT	STACK
		DB		256 DUP(0)
STACK	ENDS

DATA	SEGMENT	AT	0B800H
		DB		4000 DUP(?)
DATA	ENDS

CODE	SEGMENT
PROG	PROC	FAR
		ASSUME	CS:CODE,DS:DATA,SS:STACK
		
		PUSH	DS
		MOV		AX,0
		PUSH	AX
		MOV		AX,DATA
		MOV		DS,AX
		
WB:		MOV		AH,07H		
		MOV		DL,0    ;counter
		
READY:	MOV		BX,00H
		MOV		AL,' '


		MOV		CX,2000	;in print	|
CLS:					;			|
		MOV		[BX],AX	;			|
		ADD		BX,2	;			|
		LOOP	CLS		;------------
		
		MOV		AL,0	
		MOV		AH,0
		MOV		BX,160
		
AGAIN:
		MOV		[BX],AL	;AL 字母 ASCII
		ADD		BX,4	;記憶體位置增加
		ADD		AH,1	;
		CMP		AH,40	;限制40
		JB		SLINE	;無符號小於則跳轉
		
		ADD		BX,160
		MOV		AH,0
		
SLINE:
		CMP		AL,255	;比較al與常數
		JE		COMPLETE;等於則跳轉
		INC		AL		;AL++
		JMP		AGAIN	;無條件跳轉
		
COMPLETE:
		MOV		AH,08H	;等待任何鍵盤輸入
		INT		21H
		INC		DL
		
		CMP		DL,1
		JE		BR
		CMP		DL,2
		JE		BG
		CMP		DL,3
		JE		BY
		CMP		DL,4
		JE		BW
		CMP		DL,5
		JE		JPOUT
		
BR:		MOV		AH,14H
		JMP		READY
BG:		MOV		AH,12H
		JMP		READY
BY:		MOV		AH,1EH
		JMP		READY
BW:		MOV		AH,1FH
		JMP		READY
		
JPOUT:	
		MOV		BX,0
		MOV		AL,' ' 
		MOV		AH,07H
		
		MOV		CX,2000	;clear 	|
CLS1:					;		|
		MOV		[BX],AX	;		|
		ADD		BX,2	;		|
		LOOP	CLS1	;--------
		RET
PROG	ENDP
CODE	ENDS
		END		PROG
		