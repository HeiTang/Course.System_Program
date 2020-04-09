.286
STACK	SEGMENT	STACK
		DW		1024 DUP(?)
STACK	ENDS

DATA	SEGMENT
STR1	DB		'Preset Disk: ',0DH,0AH,'$'
STR2	DB		'input_the_name_of_DISK ->','$'
STR3	DB		0DH,0AH,'$'
MSG		DB		'DISK_info_: ',0DH,0AH
CLUSTER	DB		?,?,?,?,'  each_disk_has_cluster',0DH,0AH
SECTOR	DB		?,?,'    each_cluster_has_sector',0DH,0AH
BYTES	DB		?,?,?,?,'  each_sector_has_bytes',0DH,0AH
FATID	DB		?,?,'    FATID',0DH,0AH,'$'
DATA	ENDS

DRVDATA	MACRO						;副程式_輸出預設的磁碟機資訊
		PUSH	DS
		MOV		AH,1BH
		INT		21H
		MOV		AH,BYTE PTR[BX]
		POP		DS
		ENDM

SPEDATA	MACRO	DRIVE				;副程式_輸出指定的磁碟機資訊
		PUSH	DS
		MOV		DL,DRIVE
		MOV		AH,1CH
		INT		21H
		MOV		AH,BYTE PTR[BX]
		POP		DS
		ENDM

BYTE2HEX MACRO	BYTE2,HEX4		;副程式_進位轉換
		PUSH	AX
		MOV		AX,BYTE2
		BYTEHEX	AH,HEX4
		BYTEHEX	AL,HEX4+2
		POP		AX
		ENDM

BYTEHEX	MACRO	BYTE1,HEX2			;副程式_進位轉換
		LOCAL	NO1,NO2
		PUSHA
		MOV		DL,BYTE1
		MOV		AL,DL
		AND		DL,0F0H
		SHR		DL,4
		ADD		DL,'0'
		CMP		DL,'9'+1
		JC		NO1					;進位跳躍
		ADD		DL,7
NO1:
		MOV		HEX2,DL
		AND		AL,0FH
		ADD		AL,'0'
		CMP		AL,'9'+1
		JC		NO2
		ADD		AL,7
NO2:
		MOV		HEX2+1,AL
		POPA
		ENDM

PRINT	MACRO	STRING				;副程式_印出資訊
		LEA		DX,STRING
		MOV		AH,09H
		INT		21H
		ENDM

CODE	SEGMENT		
PROG	PROC	FAR					;主程式進入點
		ASSUME	CS:CODE,DS:DATA,SS:STACK
		
		PUSH	DS
		MOV		AX,0
		PUSH	AX
		MOV		AX,DATA
		MOV		DS,AX
		
		;DRVDATA					;預設磁碟機資訊輸出
		
		;BYTEHEX	AH,FATID
		;BYTEHEX	AL,SECTOR
		;BYTE2HEX	CX,BYTES
		;BYTE2HEX	DX,CLUSTER
		
		;PRINT	STR1
		;PRINT	MSG
		
		PRINT	STR2
		MOV		AH,01H
		INT		21H
		SUB		AL,40H
		SPEDATA	AL					;指定磁碟機資訊輸出
		
		BYTEHEX	AH,FATID
		BYTEHEX	AL,SECTOR
		BYTE2HEX	CX,BYTES
		BYTE2HEX	DX,CLUSTER
		
		PRINT	STR3
		PRINT	MSG
		RET
PROG	ENDP
CODE	ENDS
		END		PROG				;程式結束_並標記起始點