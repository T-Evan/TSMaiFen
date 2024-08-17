require "TSLib"
require("ts")

json = require "json"
--tomatoOCR = commonVar["tomatoOCR"]
--baseUtils = commonVar["baseUtils"]
--shilianTask = commonVar["shilianTask"]
--dailyTask = commonVar["dailyTask"]

--toast("c3线程启动")
--while (true) do
--    commonVar.c3 = commonVar.c3 + 1
--    toast("c3" .. commonVar.c3)
--    mSleep(4000)
--end

--toast("notice线程启动" .. commonVar["fighting"])
function main(...)
    while (true) do
        if commonVar["breakChild"] == 1 then
            break
        end
        if commonVar["fighting"] == 0 then
            noticeCancel()
        else
        end
        mSleep(5000)
    end
end

-- 升级成功/战斗胜利页确认
function noticeCancel()
    --local resGG = baseUtils.TomatoOCRTextV2("notice", tomatoOCR, 332, 178, 385, 207, "公告")
    --if resGG then
    --    baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 86, 1192, 139, 1225, "返回")
    --end
    --
    --local resHD = baseUtils.TomatoOCRTextV2("notice", tomatoOCR, 317, 1087, 436, 1117, "今日不再提醒") -- 登录活动弹窗
    --if resHD then
    --    baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 93, 1188, 126, 1218, "回")
    --end
    --
    ---- 领取离线奖励
    --res = baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 268, 869, 359, 888, "点击空白处", 30, 100)
    ---- 领取离线奖励 - 确认
    --res = baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 279, 1079, 440, 1099, "点击空白处可领取奖励", 30, 100)
    --res = baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 279, 1079, 440, 1099, "点击空白处可领取奖励", 30, 100)
    --res1 = baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 289, 1067, 430, 1094, "点击空白处关闭")
    --res2 = baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 279, 1079, 440, 1099, "点击空白处可领取奖励", 30, 20)
    --res3 = baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 266, 863, 453, 890, "点击空白处可领取奖励", 30, 100)
    --res5 = baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 268, 869, 359, 888, "点击空白处", 30, 100)
    --res6 = baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 261, 861, 457, 893, "点击空白区域继续游戏", 30, 100)
    --

    x, y = findMultiColorInRegionFuzzy(0xa6a1ad,
        "0|0|0xa6a1ad,2|0|0x938f99,3|1|0xa5a0ac,7|1|0xa5a0ac,5|4|0xa39eaa,0|4|0xa6a1ad,-3|4|0xa39eab,-1|9|0xa29da9,3|9|0xa29da9,5|7|0x98939f,14|5|0x94909b,18|5|0xa6a1ad,20|5|0x96929d,24|5|0x94909b,24|8|0x9a96a1,24|12|0xa6a1ad,20|12|0x95919c,17|13|0xa5a0ac,19|9|0xa6a1ad,30|6|0xa39eab,32|4|0x848089,32|7|0x938f9a,35|7|0x8b8792,42|7|0x8f8b96,36|10|0xa6a1ad,37|13|0xa6a1ad,41|13|0xa5a0ac,61|5|0xa49fab,61|8|0xa49fab,61|12|0xa09ca8,53|7|0xa39fab",
        90, 102, 753, 617, 1275, { orient = 7 }) -- 匹配”点击空白“ 图色
    if x ~= -1 then
        tapSleepNotice(x, y, 1.5)
    end

    --local res1 = false
    --local res2 = false
    --local res3 = false
    --local res4 = false
    --local res5 = false
    --res1 = baseUtils.TomatoOCRTextV2("notice", tomatoOCR, 213, 521, 272, 584, "战") -- 战斗胜利
    --if res1 == false then
    --    res2 = baseUtils.TomatoOCRTextV2("notice", tomatoOCR, 448, 500, 503, 560, "利") -- 战斗胜利
    --    if res2 == false then
    --        res3 = baseUtils.TomatoOCRTextV2("notice", tomatoOCR, 229, 436, 286, 497, "升") --升级成功
    --        if res3 == false then
    --            res4 = baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 301, 1202, 419, 1229, "点击空白处关闭") --战斗失败
    --            if res4 == false then
    --                res5 = baseUtils.TomatoOCRTapV2("notice", tomatoOCR, 265, 986, 455, 1018, "点击空白处可领取奖励") --恶龙胜利
    --            end
    --        end
    --    end
    --end
    --res6 = baseUtils.TomatoOCRTextV2("notice", tomatoOCR, 227, 544, 287, 600, "战") -- 战斗失败

    --if res1 or res2 or res3 or res4 or res5 or res6 then
    --    tapSleepNotice(55, 1242, 0.2)  -- 点击空白处
    --    tapSleepNotice(685, 1240, 0.2) -- 点击空白处
    --    --baseUtils.toast("发现弹窗 - 弹窗确认")
    --end
end

function tapSleepNotice(x, y, ms)
    ms = ms or 2
    tap(x, y)
    mSleep(ms * 1000)
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
