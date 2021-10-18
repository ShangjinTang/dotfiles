------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
-- Local Functions

local function isEmpty(s) return s == nil or s == '' end

local function toggleAppByID(appID)
    local frontmostWindow = hs.window.frontmostWindow()
    local isFrontmost = frontmostWindow:application():bundleID() == appID
    if not isFrontmost then
        hs.application.launchOrFocusByBundleID(appID)
        isFrontmost = true
    else
        frontmostWindow:application():hide()
        isFrontmost = false
    end
end

local function toggleAppByName(appName)
    local frontmostWindow = hs.window.frontmostWindow()
    local isFrontmost = frontmostWindow:application():name() == appName
    if not isFrontmost then
        hs.application.launchOrFocus(appName)
        isFrontmost = true
    else
        frontmostWindow:application():hide()
        isFrontmost = false
    end
end

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
-- Object

local obj = {}
obj.__index = obj
obj.name = "AppLaunch"
obj.version = "1.0"
obj.author = "Shangjin Tang <shangjin.tang@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"
-- obj.homepage = "https://github.com/"

function obj:log(str)
    if str ~= nil then
        print(obj.name .. ": " .. str)
    end
end

function obj:setMods(mods)
    obj.mods = mods
end

function obj:setConfigs(configs)
    obj:log("setConfigs() start")
    hs.fnutils.each(configs, function(config)
        local message = config.message
        if isEmpty(message) then message = config.name end
        if not isEmpty(config.id) then
            hs.hotkey.bind(obj.mods, config.key, message, function() toggleAppByID(config.id) end)
        elseif not isEmpty(config.name) then
            hs.hotkey.bind(obj.mods, config.key, message, function() toggleAppByName(config.name) end)
        end
    end)
    obj:log("setConfigs() end")
end

return obj