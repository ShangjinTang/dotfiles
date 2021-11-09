------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
-- Local Functions

local weaEmoji = {
    xue = '❄️',
    lei = '⛈',
    shachen = '😷',
    wu = '🌫',
    bingbao = '🌨',
    yun = '⛅',
    yu = '🌧',
    yin = '☁️',
    qing = '☀️',
    default = ''
}


local function getTimeEmoji(hourNumber)
    local logo = ""
    if hourNumber == 7 then
        logo = "⏰"
    elseif hourNumber == 8 then
        logo = "🥪"
    elseif hourNumber == 12 then
        logo = "🍱"
    elseif hourNumber == 18 then
        logo = "🥗"
    elseif (hourNumber >= 9 and hourNumber <= 11) or (hourNumber >= 14 and hourNumber <= 17) or hourNumber == 19 then
        logo = "⌨️"
    elseif hourNumber >= 19 and hourNumber <= 23 then
        logo = "🌐"
    else
        logo = "😴"
    end
    return logo
end


------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
-- Object

local obj={}
obj.__index = obj
obj.name = "WeatherStatusBar"
obj.version = "1.0"
obj.author = "Shangjin Tang <shangjin.tang@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"
-- obj.homepage = "https://github.com/"
function obj:log(str)
    if str ~= nil then
        print(obj.name .. ": " .. str)
    end
end


obj.menubar = hs.menubar.new()  -- menuBar: 状态栏对象（单例）


function obj:initialize()
    obj.menubar:setTitle('⌛')
    obj.menuData = {}  -- menuData: 状态栏信息（包含下拉列表）
    obj.menubarTitle = nil  -- menuTitle: 状态栏天气显示
end


-- Reference: https://www.tianqiapi.com/index/doc?version=v1
-- obj:setIdSecret() must be called before obj:updateWeatherUrl()
function obj:updateWeatherUrl()
    obj.apiUrl = "https://www.tianqiapi.com/api?unescape=1&version=v1" .. "&appid=" .. obj.appid .. "&appsecret=" .. obj.appsecret
    if obj.city then
        obj.apiUrl = obj.apiUrl .. "&city=" .. hs.http.encodeForQuery(obj.city)
    end
end


function obj:setCity(city)
    obj.city = city
end


function obj:setIdSecret(appid, appsecret)
    obj.appid = appid
    obj.appsecret = appsecret
end


function obj:setHourWeatherEnabled(bool)
    obj.hourWeatherEnabled = bool
end


function obj:setUpdateDuration(duration)
    obj.updateDuration = duration
end


function obj:appendMenuData(str)
    table.insert(obj.menuData, {title = str})
end


function obj:appendUnselectableMenuData(str)
    table.insert(obj.menuData, {title = str, disabled = true})
end


function obj:formatTitleWeather(month, date, data, city)
    local wea
    if tonumber(os.date("%H")) < 18 then
        wea = data.wea
    else
        wea = data.wea_night
    end
    return string.format("%s %s %s", city, data.tem, wea)
end


function obj:formatDropdownWeather(month, date, data)
    return string.format("%-24s \t%-4s %-4s %-2s %-16s \t%-4s %-4s %-2s %-16s", data.day, "白天", data.tem1, weaEmoji[data.wea_day_img], data.wea_day, "晚上", data.tem2, weaEmoji[data.wea_night_img], data.wea_night)
end


function obj:formatDropdownWeather(month, date, data)
    return string.format("%-24s \t%-4s %-4s %-2s %-16s \t%-4s %-4s %-2s %-16s", data.day, "白天", data.tem1, weaEmoji[data.wea_day_img], data.wea_day, "晚上", data.tem2, weaEmoji[data.wea_night_img], data.wea_night)
end


function obj:updateHourWeather(urlBody)
    obj:appendMenuData('-')
    obj:appendMenuData("未来24小时天气")
    local currentHour = tonumber(os.date("%H"))
    local hours = {}
    local weas = {}
    local wea_imgs = {}
    local tems = {}
    currentHourMatched = false
    for hour, wea, wea_img, tem in string.gmatch(urlBody, '"hours":"(%d+)时",.-"wea":"([^"]+)",.-"wea_img":"(%l+)",.-"tem":"(%d+)"') do
        hourDiff = (hour - currentHour - 1) % 24
        if (not currentHourMatched and hourDiff == 0) or (currentHourMatched and hourDiff ~= 0) then
            table.insert(hours, hour)
            table.insert(weas, wea)
            table.insert(wea_imgs, wea_img)
            table.insert(tems, tem)
            if (not currentHourMatched and hourDiff == 0) then
                currentHourMatched = true
            end
        end
    end
    for i = 1,24 do
        local logo = getTimeEmoji(tonumber(hours[i]))
        str = string.format("%s\t%-s \t\t\t%-8s \t\t\t%-s \t%-16s", logo, hours[i] .. ":00", tems[i] .. "°C", weaEmoji[wea_imgs[i]], weas[i])
        obj:appendMenuData(str)
    end
end

function obj:updateWeather()
    obj:initialize()
    obj:log("Get weather start")
    obj:updateWeatherUrl()
    hs.http.asyncGet(obj.apiUrl, nil, function(code, body)
        if code ~= 200 then
            obj:log('Get weather error:' .. code)
            return
        end
        local rawjson = hs.json.decode(body)
        local city = rawjson.city
        local update_time =  rawjson.update_time
        local todayDate = os.date("%d")
        for _, dailyData in pairs(rawjson.data) do
            -- obj:log(hs.inspect(dailyData))
            local weatherMonth = string.sub(dailyData.date, 6, 7)
            local weatherDate = string.sub(dailyData.date, 9, 10)
            local dateDifference = tonumber(weatherDate) - tonumber(todayDate)
            if dateDifference == 0 then
                obj.menubarTitle = obj:formatTitleWeather(weatherMonth, weatherDate, dailyData, city)
                obj:appendMenuData("今日天气")
                obj:appendMenuData(obj:formatDropdownWeather(weatherMonth, weatherDate, dailyData))
                obj:appendMenuData("AQI：" .. dailyData.air .. " " .. dailyData.air_level .. "\t\t\t日出 " .. dailyData.sunrise .. " \t\t\t\t日落 " .. dailyData.sunset)
                obj:appendMenuData('-')
                obj:appendMenuData("未来一周天气")
            elseif (dateDifference > 0 and dateDifference < 7) or dateDifference < -21 then
                obj:appendMenuData(obj:formatDropdownWeather(weatherMonth, weatherDate, dailyData))
            end
        end
        if obj.hourWeatherEnabled then
            obj:updateHourWeather(body)
        end
        obj:appendMenuData('-')
        obj:appendUnselectableMenuData(city .. "天气    " .. string.sub(update_time, 12, 16) .. " 更新")
        obj.menubar:setTitle(obj.menubarTitle)
        obj.menubar:setMenu(obj.menuData)
    end)
    obj:log("Get weather end")
end


return obj
