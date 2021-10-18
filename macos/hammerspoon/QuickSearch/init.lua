------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
-- Local Functions

local function isEmpty(s) return s == nil or s == '' end
local function stripSpace(s)
    local stripedString = ''
    if not isEmpty(s) then stripedString = s:gsub("^%s*(.-)%s*$", "%1") end
    return stripedString
end

local function searchWithEngine(searchUrl, fallbackUrl)
    oldData = hs.pasteboard.readAllData()
    hs.pasteboard.clearContents()

    hs.eventtap.keyStroke({"cmd"}, "c", 0)
    hs.timer.doAfter(0.1, function()
        local copiedString = stripSpace(hs.pasteboard.readString())
        if not isEmpty(copiedString) and not isEmpty(searchUrl) then
            hs.urlevent.openURL(searchUrl .. hs.http.encodeForQuery(copiedString))
        elseif not isEmpty(fallbackUrl) then
            hs.urlevent.openURL(fallbackUrl)
        end
    end)
end

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
-- Object

local obj={}
obj.__index = obj
obj.name = "QuickSearch"
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
        hs.hotkey.bind(obj.mods, config.key, config.message, function()
            searchWithEngine(config.searchUrl, config.fallbackUrl)
        end)
    end)
    obj:log("setConfigs() end")
end

return obj