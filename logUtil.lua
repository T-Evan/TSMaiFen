local logUtils = {}

-- initLog("192.168.6.126", 3) --初始化日志，并以异步方式发送；把 2 换成 3  即为同步发送，192.168.1.1 为控制端 IP
glSettings({ switch = "0101", x1 = 200, y1 = 50, x2 = 300, y2 = 200, tsp_switch = true })
function logUtils.log(content)
    --log(content)
    if 功能开关 ~= nil and 功能开关["调试开关"] ~= nil and 功能开关["调试开关"] == 1 then
        mLog(content)
    end
    --nLog("[" .. os.date("%H:%M:%S") .. string.sub(ts.ms(), 11) .. "]  " .. text)
    -- wLog("192.168.6.126", content) --发送日志内容：当前时间 Test_1 OK!!! 192.168.1.1（控制端 IP 即电脑 IP）
    -- mSleep(2200) -- 避免toast遮挡
end

return logUtils
