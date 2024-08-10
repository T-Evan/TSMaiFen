require "TSLib"
require("ts")
json = require "json"
ui = require("ui")
logUtils = require("logUtil")
baseUtils = require("base")
dailyTask = require("daily")
shilianTask = require("shilian")
lvrenTask = require("lvren")
lvtuanTask = require("lvtuan")
yingdiTask = require("yingdi")
startUp = require("startUp")

任务记录 = {
    ["当前任务账号"] = 功能开关["选择启动账号"],

    ["仓鼠百货-完成"] = 0,
    ["旅团-浇树-完成"] = 0,
    ["旅团-调查队-完成"] = 0,
    ["旅人-猫猫果木-完成"] = 0,
    ["日常-招式创造-完成"] = 0,
    ["日常-骑兽乐园-完成"] = 0,
    ["试炼-恶龙-完成次数"] = 0,
    ["月签到"] = 0,
    ["月卡"] = 0,
    ["日礼包"] = 0,
    ["露营打卡点"] = 0,
}

function main(...)
    init(0) -- 设置屏幕方向，虚拟按键在屏幕下方

    baseUtils.loadRes()

    tomatoOCR = baseUtils.initTomatoOCR()
    -- aiOCRToken = baseUtils.initAiOCR()

    -- 子协程处理弹窗
    -- local thread = require('thread')
    -- local kill_tid = thread.create(killdialog,error_callback)
    -- thread.waitAllThreadExit()
    -- debug
    --shilianTask.fighting()
    --lua_exit()
    --runThread("__thread__child1") -- 没有用？

    -- 处理休息时间
    local needRunMinute = tonumber(功能开关["定时运行"]) -- 分钟
    if needRunMinute == nil then
        needRunMinute = 0
    end
    local needWaitMinute = tonumber(功能开关["定时休息"]) -- 分钟
    if needWaitMinute == nil then
        needWaitMinute = 0
    end

    local needSwitchMinute = tonumber(功能开关["定时切号"]) -- 分钟
    if needSwitchMinute == nil then
        needSwitchMinute = 0
    end

    local totalWait = needRunMinute * 60
    local totalSwitchMinute = needSwitchMinute * 60
    start_time = os.time()

    --多账号处理
    startUp.multiAccount()

    while true do
        -- 启动app
        startUp.startApp()

        -- 营地活动（优先领取）
        yingdiTask.yingdiTask()

        -- 日常（优先领取）
        dailyTask.dailyTask()

        -- 旅人相关
        lvrenTask.lvrenTask()

        -- 试炼
        shilianTask.shilian()

        -- 旅团相关
        lvtuanTask.lvtuanTask()

        -- 营地活动（最后领取）
        yingdiTask.yingdiTaskEnd()

        -- 日常（最后领取）
        dailyTask.dailyTaskEnd()

        -- 定时休息
        current_time = os.time()

        if totalWait ~= 0 and current_time - start_time >= totalWait then
            closeApp("com.xd.cfbmf")
            toast("休息" .. needWaitMinute .. "分钟")
            mSleep(needWaitMinute * 60 * 1000)
            start_time = os.time()
        end

        if totalSwitchMinute ~= 0 and current_time - start_time >= totalSwitchMinute then
            toast("运行" .. totalSwitchMinute .. "分钟，准备切换账号")
            startUp.switchAccount()
            start_time = os.time()
        end
    end
end

neo, errmsg = pcall(main)
if neo then
    dialog(errmsg, time)
else
    user_Choosen = dialogRet("很抱歉辅助出现异常，是否将错误信息写入剪切板以回报开发者！", "积极回报", "残忍拒绝", "", 0)
    if user_Choosen == 0 then
        writePasteboard(errmsg)
        dialog("错误信息已经写入剪切板！", 5)
    end
end

-- 释放
function beforeUserExit() -- 停止脚本，将会触发 beforeUserExit 函数
    tomatoOCR.release()
end
