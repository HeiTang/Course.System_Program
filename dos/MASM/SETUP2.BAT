ECHO OFF
CLS
IF NOT %1.==S. SETUP
ECHO  
ECHO About to copy executable files to %TDRIVE%:%EDIR%. 
ECHO Duplicate files will be overwritten.
ECHO  
WHAT C "Do you want to copy these files now? (Y/n) " ~YN
ECHO  
ECHO  
IF %WHAT%==N A:RUNME %1
CLS
COPY A:*.EXE %EDIR%
ECHO  
ECHO About to copy mixed-language example and documentation files 
ECHO from directory A:\MIXED to directory %TDRIVE%:%ADIR%\MIXED. 
ECHO Duplicate files will be overwritten. 
ECHO  
WHAT C "Do you want to copy these files now? (Y/n) " ~YN
ECHO  
ECHO  
IF %WHAT%==N GOTO Copy3
COPY A:\MIXED\*.ASM %ADIR%\MIXED
COPY A:\MIXED\*.DOC %ADIR%\MIXED
COPY A:\MIXED\?AMAIN.* %ADIR%\MIXED
:Copy3
ECHO  
ECHO About to copy include files to directory %TDRIVE%:%IDIR%.
ECHO Duplicate files will be overwritten. 
ECHO  
WHAT C "Do you want to copy these files now? (Y/n) " ~YN
ECHO  
ECHO  
IF %WHAT%==N A:RUNME S
COPY A:\MIXED\*.INC %IDIR%
ECHO  
WHAT CE "Insert disk 2 (CodeView) in drive A and press any key when ready. "
IF NOT EXIST A:\CV.HLP GOTO Copy3
SET DISK=2
ECHO  
ECHO  
COPY A:*.INC %IDIR%
ECHO  
ECHO About to copy executable files to directory %TDRIVE%:%EDIR%. 
ECHO Duplicate files will be overwritten.
ECHO  
WHAT C "Do you want to copy these files now? (Y/n) " ~YN
ECHO  
ECHO  
IF %WHAT%==N A:RUNME S
COPY A:CV.* %EDIR%
COPY A:EXE*.* %EDIR%
ECHO  
ECHO About to copy source, documentation, and demo files to 
ECHO directory %TDRIVE%:%ADIR%. Duplicate files will be overwritten.
ECHO  
WHAT C "Do you want to copy these files now? (Y/n) " ~YN
ECHO  
ECHO  
IF %WHAT%==N A:RUNME S
COPY A:*.BAT %ADIR%
COPY A:*.ASM %ADIR%
COPY A:*.DOC %ADIR%
COPY A:*.CV %ADIR%
COPY A:WHA*.EXE %ADIR%
COPY A:SHO*.EXE %ADIR%
ECHO  
ECHO Preparing to copy MOUSE.SYS to directory %TDRIVE%:%SDIR%. 
ECHO Any previous version will be overwritten.
ECHO  
WHAT C "Do you want to copy this file now? (Y/n) " ~YN
ECHO  
ECHO  
IF %WHAT%==N A:RUNME S
COPY A:MOUS*.SYS %SDIR%
:Exit
WHAT Y
SET CDIR=%WHAT%
WHAT YE
SET CDRIVE=%WHAT%
IF NOT EXIST RUNME.BAT A:RUNME %1
CD %ADIR%
SET DISK=3
RUNME %2

