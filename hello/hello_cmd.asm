; hello_cmd.asm

.386
.model flat, stdcall
option casemap:none

; 引入 Windows API 库
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

.data
    ; 定义一个以0结尾的字符串，用于在命令行输出
    szMsg db "Hello, MASM", 0

.code
start:
    ; 获取标准输出句柄
    ; dwStdHandle = STD_OUTPUT_HANDLE (-11)
    push STD_OUTPUT_HANDLE
    call GetStdHandle

    ; 参数顺序：hFile, lpBuffer, nNumberOfBytesToWrite, lpNumberOfBytesWritten, lpOverlapped
    ; 寄存器入栈顺序：从右到左
    push 0              ; lpOverlapped
    push 0              ; lpNumberOfBytesWritten (因为不需要知道写入了多少字节)
    push lengthof szMsg ; nNumberOfBytesToWrite (字符串的长度)
    push offset szMsg   ; lpBuffer (字符串地址)
    push eax            ; hFile (GetStdHandle 返回的标准输出句柄)
    call WriteFile

    ; 退出程序
    push 0
    call ExitProcess

end start