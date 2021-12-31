# Hammerspoon

## Installation

Install from [Hammerspoon Offcial](https://github.com/Hammerspoon/hammerspoon/releases/latest), then clone config

```bash
rm -rf ~/.hammerspoon && git clone https://github.com/ShangjinTang/Hammerspoon.git ~/.hammerspoon
```

To add non-sync configurations:

1. Create the file `~/.hammerspoon/config_nosync.lua` .
2. Add configuration `CONFIG_NOSYNC_* = <value>` in this file.
3. Use `CONFIG_NOSYNC_*` in main `~/.hammerspoon/init.lua`.

**Note: Hyper key is based on KE (Karabiner-Elements).**

## Quick Search

Select some text and search.
If no text or empty text is selected, press a key will open corresponding homepage.

- **Hyper+G** : Search with Google
- **Hyper+T** : Google Translate
- **Hyper+B** : Search with Baidu

## App Launch

> This section is macOS 10.13 compatible.  
> Apps on macOS 10.15 and 11.x are not tested.

Quick Launch a specified app. Fixed apps are:

- Alpha
  - **⇧Q** : IINA
  - **⇧W** : WeChat
  - **⇧E** : NeteaseMusic
  - **⇧R** : TickTick
  - **⇧T** : Terminal
  - **⇧P** : Parallel Desktop
  - **⇧U** : App Cleaner
  - **⇧A** : Launchpad
  - **⇧S** : System Preferences
  - **⇧F** : ForkLift (or Finder)
  - **⇧H** : HazeOver
  - **⇧C** : Chrome
  - **⇧V** : VS Code
  - **⇧B** : Bartender 3
  - **⇧N** : Notion
  - **⇧M** : Microsoft Remote Desktop

## Weather Status Bar

Show weather on status bar, support:

- weather within one week
- today's AQI, sunrise & sunset
- weather within 24 hours (can be closed by `weatherStatusBar:setHourWeatherEnabled()`)

> To customize weather city, set `CONFIG_NOSYNC_WEATHER_CITY` to cityname.  
> e.g. `CONFIG_NOSYNC_WEATHER_CITY = "上海"`
