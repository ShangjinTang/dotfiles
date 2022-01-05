# Karabiner-Elements

## Installation

Install from [Hammerspoon Offcial](https://karabiner-elements.pqrs.org/).

## Mandatory Key Mapping

### CapsLock -> Hyper/Esc & Shift+CapsLock -> CapsLock

Note: Do not map Hyper + comma(`,`) period(`.`) or slash(`/`) on macOS.

### Option(Alt) + 12347890-= -> non-standard F-Keys

Note: On MacBook, F5 is for Siri and F6 is for Do-Not-Disturb, cannot be customized in KE.

## Optional Key Mapping

### Hyper + WSAD / QE / RF / ZXC / Enter

- Hyper + W/S/A/D: Up/Down/Left/Right
- Hyper + Q/E: Home/End
- Hyper + R/F: PgUp/PgDn
- Hyper + Z/X/C: Ctrl + Left/Up/Right
- Hyper + Enter: ⌃⌘F (Full Screen)

## Other Apps Key Mapping

- Hyper + Space: Toggle Alfred
- Hyper + V: Clipboard (Alfred 4)
- Hyper + 3: Snipaste - Snip
- Hyper + 4: Snipaste - Hide/Show all images

## Issues

### How to disable hyper keys for Windows OS

Disable keys in Microsoft Remote Desktop & Parallel Desktop:

```json
"conditions": [
  {
    "type": "frontmost_application_unless",
    "bundle_identifiers": [
      "^com\\.microsoft\\.rdc\\.macos$",
      "^com\\.parallels\\.winapp",
      "^com\\.parallels\\.desktop\\.console"
    ]
  }
]
```

### Prevent hyper key (Win+Ctrl+Alt+Shift) opens office in Windows

Run follow command in Windows CMD:

```plain
REG ADD HKCU\Software\Classes\ms-officeapp\Shell\Open\Command /t REG_SZ /d rundll32
```
