; hello.asm

.386                ; 告诉汇编器使用32位指令集 (80386)
.model flat, stdcall; 指定内存模型为 flat（平坦），调用约定为 stdcall
option casemap:none ; 区分大小写

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data               ; 数据段
    szMsgCaption    db "Hello!", 0  ; 消息框标题
    szMsgText       db "Hello, World!", 0 ; 消息框文本

.code               ; 代码段
start:
    ; 调用 MessageBoxA API
    ; 参数顺序为：hWnd, lpText, lpCaption, uType
    ; 寄存器入栈顺序：从右到左
    push MB_OK          ; uType = 0 (OK按钮)
    push offset szMsgCaption ; lpCaption (标题)
    push offset szMsgText  ; lpText (消息文本)
    push 0              ; hWnd = 0 (无父窗口)
    call MessageBoxA

    ; 调用 ExitProcess API 退出程序
    push 0              ; dwExitCode = 0 (成功退出)
    call ExitProcess

end start           ; 程序入口点