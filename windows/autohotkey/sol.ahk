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
; 3. Key Mapping: CapsLock as Hyper
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
y::Run "https://www.youtube.com/"
`::^#!+`  ; Ditto: Activate Window
1::^#!+1  ; Twinkle Tray: Brightness Down
2::^#!+2  ; Twinkle Tray: Brightness Up
3::^#!+3  ; Snipaste: Screenshot
4::^#!+4  ; Snipaste: Hide/Show all the pins
5:: +#T  ; PowerToys: OCR (Text Extractor)
0::Reload
\::try open_terminal_path_in_samba("/home/sol", "\\wsl$\Arch\home\sol")
Space::^#!+/  ; Listary: Show Listary Toolbar
#If

*CapsLock::
KeyWait, CapsLock
IF A_ThisHotkey = *CapsLock
    Send, {Escape}
Return

+CapsLock::CapsLock


; ================================================================================
; 4. CapsLock + Tab -> ScrollLock
; If ScrollLock on, map 1234567890-= to F1~F12
#If GetKeyState("CapsLock", "P")
Tab::SetScrollLockState % !GetKeyState("ScrollLock", "T")
#If
#If GetKeyState("ScrollLock", "T")
1::F1
2::F2
3::F3
4::F4
5::F5
6::F6
7::F7
8::F8
9::F9
0::F10
-::F11
=::F12
#If

; ================================================================================
; 5. Key Mapping: General

; W: WeChat
#w::try toggle_ahk_class("C:\Program Files (x86)\Tencent\WeChat\WeChat.exe", "WeChatMainWndForPC")
; E: Netease Music
#e::try toggle_ahk_class("C:\Program Files (x86)\Netease\CloudMusic\cloudmusic.exe", "OrpheusBrowserHost")
; R: TickTick
#r::Run "https://dida365.com/"
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

; ================================================================================
; 6. Key Mapping: Activate Window

; ------------------------------------------------------------
; 6.1 XShell use keys as Ubuntu
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

; 7. Functions

search_clipboard(main_url, query_url, html_required:=False)
{
    clipsaved := ClipboardAll
    clipboard := ""
    Send ^{Insert}
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

open_terminal_path_in_samba(terminal_home_path, samba_home_path) {
    clipsaved := ClipboardAll
    clipboard := ""
    Send ^{Insert}
    ClipWait 0.1

    clipboard := Trim(clipboard)

    if ErrorLevel
    {
        Run, explorer.exe %samba_home_path%
        return
    }

    if (SubStr(clipboard, 1, 1) = "~")
    {
        newClip := samba_home_path . SubStr(clipboard, 2)
        newClip := StrReplace(newClip, "/", "\")
        Run, explorer.exe %newClip%
    }
    else if (StrLen(terminal_home_path) != 0 && SubStr(clipboard, 1, StrLen(terminal_home_path)) = terminal_home_path)
    {
        newClip := samba_home_path . SubStr(clipboard, StrLen(terminal_home_path) + 1)
        newClip := StrReplace(newClip, "/", "\")
        Run, explorer.exe %newClip%
    }
    else
    {
        Run, explorer.exe %samba_home_path%
        return
    }

    clipboard := clipsaved
    clipsaved := ""
    return
}
