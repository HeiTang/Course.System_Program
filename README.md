# Week 0:03/20

## 下載安裝包
1. 下載助教給的安裝包：第 0 週_環境設置.zip，並解壓縮
3. 進入`第 0 週_環境設置`這個資料夾
4. 執行 DOSBox0.74-3-win32-installer.exe
5. 安裝 7z1900-x64.exe (7-zip) 解壓縮工具

## 新增 DOS 的硬碟槽
1. D:\ 創建一個新資料夾叫做 dos
2. 在 D:\dos 創建 ASM 和 MASM 這兩個新資料夾
3. 右鍵點擊桌面上安裝好的 DOSBox0.74-3 選擇`內容`
4. 接著`開啟檔案位置`，找到 DOSBox 0.74-3 Options.bat 批次檔
5. 雙擊後會看到一些預先的設定
6. 在批次檔的最下方我們新增以下內容 (tty.txt)
	```shell=
	MOUNT C D:\dos\MASM
	MOUNT D D:\dos\ASM	
	set PATH=$PATH$;c:\;
	d:
	```
	- 第一行，代表將 D 槽中的資料夾設置為 DOSBox 下的 C 槽
	- 第三行，將他寫入系統環境變數中
	- 最後一行，切換至 d
7. 將此批次檔存檔後並關閉
8. 現在執行桌面的 DOSBox 0.74-3，會看到一些 .bat 設定後的資訊
9. 輸入 C: 或 D: 就能切換當前位置

## 設定 DOS 的硬碟槽
1. 解壓縮`第 0 週_環境設置/Microsoft Marco Assembler 5.0 (5.25).7z`這個資料夾
2. 進入該資料夾會看到 disc01.img 和 disk02.img
3. 右鍵 disk01.img 選擇 7z 功能`開啟壓縮檔`，全選內容將其複製到 D:\dos\MASM （dos 的 C 槽）
4. 選擇 disk02.img 重複上一步
5. 過程中若出現是否覆蓋重複檔案的問題時，全部皆是
	:::info
	MASM 是 DOS 的 C 槽
	ASM 是 DOS 的 D 槽
	:::

## 測試是否可運作
1. 將`第 0 週_環境設置/hello.asm`複製到 D:\dos\ASM
2. 現在執行桌面的 DOSBox 0.74-3
3. 我們先輸入 `masm`，它會要求你輸入要執行的檔名
    - ![](https://i.imgur.com/xmcTFth.png)
5. 我們輸入 `hello`，接著按 ENTER 直到畫面不再出現別的訊息
    - ![](https://i.imgur.com/bSPrm1H.png)
    - 這時候會發現上面出現 0 Errors 代表完成
8. 我們回到 D:\dos\ASM 裡面，會發現多了一個 HELLO.OBJ 檔
9. 切換回 DOSBox 介面，輸入 `link HELLO.OBJ`
    - ![](https://i.imgur.com/qQcL4Wx.png)
    - 它會出現一些訊息，一樣按 ENTER 繼續
11. D:\dos\ASM 裡面又多了一個 HELLO.EXE 檔
12. 在 DOSBox 的介面打上 hello 如果輸出 HELLO 就代表你成功了
    - ![](https://i.imgur.com/Bf3tKLA.png)


## 補充說明
1. 點開 D:\dos\ASM\hello.asm
    - ![](https://i.imgur.com/6Ede1Jq.png)
    - ![](https://i.imgur.com/QdmdjcV.png)
    - 第一行開頭的 data 和 code 是可以自己命名的
        - assume cs:\<自己命名的>, ds:\<自己命名的>
2. 13,10 是指換行迴車的 ASCII