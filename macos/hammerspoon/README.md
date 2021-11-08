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

## Quick Search

Select some text and search.
If no text or empty text is selected, press a key will open corresponding homepage.

- **⌥⇧S** : Search with Google
- **⌥⇧T** : Google Translate
- **⌥⇧G** : Search with GitHub
- **⌥⇧A** : Android Code Search
- **⌥⇧B** : Search with Bilibili
- **⌥⇧C** : Search with CSDN
- **⌥⇧W** : Search with Wikipedia
- **⌥⇧Z** : Search with Zhihu

## App Launch

> This section is macOS 10.13 compatible.  
> Apps on macOS 10.15 and 11.x are not tested.

Quick Launch a specified app. Fixed apps are:

- Numeric
  - **⇧1** : Chrome
  - **⇧2** : Safari
  - **⇧7** : Android Studio
  - **⇧8** : Intellij Idea
  - **⇧9** : CLion
  - **⇧0** : PyCharm
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
