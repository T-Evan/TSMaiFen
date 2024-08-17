require "TSLib"
require("ts")

json = require "json"
logUtils = require("logUtil")
baseUtils = require("base")
startUp = require("startUp")
功能开关 = commonVar["功能开关"]

function main(...)
    while (true) do
        -- 异地登录
        loginRes = startUp.anotherLogin()
        if loginRes then
        end
        mSleep(3000)
    end
end

neo, errmsg = pcall(main)
if neo then
    commonUtils.baseUtils.dialog(errmsg, time)
else
    toast(errmsg)
    user_Choosen = dialogRet("很抱歉辅助出现异常，是否将错误信息写入剪切板以回报开发者！", "积极回报", "残忍拒绝", "", 0)
    if user_Choosen == 0 then
        writePasteboard(errmsg)
        commonUtils.baseUtils.dialog("错误信息已经写入剪切板！", 5)
    end
end

-- 释放
function beforeUserExit() -- 停止脚本，将会触发 beforeUserExit 函数
    tomatoOCR.release()
end
