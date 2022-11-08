# PowerToys README

## Always on Top

Shortcut (default): Win + Ctrl + T

## ~~Color Picker~~

Disabled. It can be replaced by SniPaste.

## FancyZones

Shortcut (default): Win + Shift + \`

## File Explorer add-ons

### Enabling in Windows 11

Open Windows File Explorer, select the **View** menu in the File Explorer ribbon. Hover over **Show**, and then select **Preview pane**.

### Enabling in Windows 10

Open Windows File Explorer, select the **View** tab in the File Explorer ribbon, and then select **Preview Pane**.

## Mouse Utilities

### ~~Find my mouse~~

Disabled.

### Mouse highlighter

Shortcut (default): Win + Shift + H

Left button highlight color: RED (#FF0000)

## PowerToys Run

Shortcut (default): Alt + Space

## Text Extractor

Shortcut (default): Win + Shift + T (mapping to Hyper+5)

### How to install an OCR language pack (en-US)

The following commands install the OCR pack for "en-US":

```powershell
PS C:>\ $Capability = Get-WindowsCapability -Online | Where-Object { $_.Name -Like 'Language.OCR*en-US*' }
PS C:>\ $Capability | Add-WindowsCapability -Online
```

### How to remove an OCR language pack (zh-CN)

The following commands remove the OCR pack for "zh-CN":

```powershell
PS C:>\ $Capability = Get-WindowsCapability -Online | Where-Object { $_.Name -Like 'Language.OCR*zh-CN*' }
PS C:>\ $Capability | Add-WindowsCapability -Online
```

