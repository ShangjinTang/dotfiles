#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; AHK Tutorial (zh-cn):
; https://wyagd001.github.io/zh-cn/docs/AutoHotkey.htm

; # Win | ! Alt | ^ Ctrl | + Shift | * <AnyChar>
; For function key: < left Key | > right Key

; ================================================================================
; 1. Environment Setting

SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff

; ================================================================================
; 2. Hot String

:*:+gmail::shangjin.tang@gmail.com

; ================================================================================
; 3. Key Mapping: Hyper
;    Capslock -> Hyper or Escape (alone);
;    Shift + Capslock -> Capslock

#If GetKeyState("CapsLock", "P")
w::Up
s::Down
a::Left
d::Right
q::Home
e::End
r::PgUp
f::PgDn
z::^#Left
x::#Tab
c::^#Right
t::search_clipboard("https://translate.google.com/", "?sl=auto&tl=zh-CN&text=", html_required=True)
g::search_clipboard("https://www.google.com/", "search?q=")
b::Run "https://www.bilibili.com/"
`::^#!+`  ; Ditto: Activate Window
1::^#!+1  ; Twinkle Tray: Brightness Down
2::^#!+2  ; Twinkle Tray: Brightness Up
3::^#!+3  ; Snipaste: Screenshot
4::^#!+4  ; Snipaste: Hide/Show all the pins
\::Reload
/::^#!+/  ; Listary: Show Listary Toolbar
Space::^#!+/  ; Listary: Show Listary Toolbar
#If

*CapsLock::
KeyWait, CapsLock
IF A_ThisHotkey = *CapsLock
    Send, {Escape}
Return

+CapsLock::CapsLock

; ------------------------------------------------------------
; 4. Key Mapping: General

; W: WeChat
#w::try toggle_ahk_class("C:\Program Files (x86)\Tencent\WeChat\WeChat.exe", "WeChatMainWndForPC")
; E: Netease Music
#e::try toggle_ahk_class("C:\Program Files (x86)\Netease\CloudMusic\cloudmusic.exe", "OrpheusBrowserHost")
; T: Terminal
#t::try toggle_ahk_exe("wt.exe", "WindowsTerminal.exe")
; F: XYExplorer
#f::try toggle_ahk_exe("C:\Program Files\XYplorer\XYplorer.exe", "XYplorer.exe")
; C: Chrome
#c::try toggle_ahk_exe("C:\Program Files\Google\Chrome\Application\chrome.exe", "chrome.exe")
; V: VSCode
#v::try toggle_ahk_exe("C:\Program Files\Microsoft VS Code\Code.exe", "Code.exe")
; N: Notion
#n::Run "https://www.notion.so/"
; M: Miro
#m::Run "https://miro.com/"

; RAlt
>!0::Volume_Mute
>!-::Volume_Down
>!=::Volume_Up

; ================================================================================
; 5. Key Mapping: Activate Window

; ------------------------------------------------------------
; 5.1 XShell use keys as Ubuntu
;     Ctrl + Shift + C: Copy
;     Ctrl + Shift + V: Paste

; ^+c::
; if WinActive("ahk_exe Xshell.exe")
;     Send ^{Insert}
; return
; ^+v::
; if WinActive("ahk_exe Xshell.exe")
;     Send +{Insert}
; return
; ^+z::
; if WinActive("ahk_exe sourceinsight4.exe")
;     Send ^y
; return

; ======================================================================

; 6. Functions

search_clipboard(main_url, query_url, html_required:=False)
{
    clipsaved := ClipboardAll
    clipboard := ""
    Send ^c
    ClipWait 0.1
    if ErrorLevel
    {
        Run % main_url
        return
    }
    if html_required
        clipboard := RegExReplace(RegExReplace(clipboard, " ","`%20"),"`r`n","`%0A")
    Run % main_url . query_url . clipboard
    clipboard := clipsaved
    clipsaved := ""
}

toggle_ahk_class(program_path, ahk_class_name)
{
    if WinExist("ahk_class " . ahk_class_name)
    {
        WinGet, WinState, MinMax, ahk_class %ahk_class_name%
        if WinState = -1
        {
            WinActivate
        }
        else
        {
            WinMinimize
        }
    }
    else
        Run, %program_path%
    return
}

toggle_ahk_exe(program_path, ahk_exe_name)
{
    if WinExist("ahk_exe " . ahk_exe_name)
    {
        WinGet, WinState, MinMax, ahk_exe %ahk_exe_name%
        if WinState = -1
        {
            WinActivate
        }
        else
        {
            WinMinimize
        }
    }
    else
        Run, %program_path%
    return
}
