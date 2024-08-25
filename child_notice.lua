require "TSLib"
require("ts")

json = require "json"
--tomatoOCR = commonVar["tomatoOCR"]
baseUtils = require("base")
logUtils = require("logUtil")
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
        mSleep(10000)
    end
end

-- 升级成功/战斗胜利页确认
function noticeCancel()
    --local resGG = baseUtils.YDOCRText("notice", 332, 178, 385, 207, "公告")
    --if resGG then
    --    baseUtils.YDOCRTap("notice", 86, 1192, 139, 1225, "返回")
    --end
    --
    --local resHD = baseUtils.YDOCRText("notice", 317, 1087, 436, 1117, "今日不再提醒") -- 登录活动弹窗
    --if resHD then
    --    baseUtils.YDOCRTap("notice", 93, 1188, 126, 1218, "回")
    --end

    x, y = findMultiColorInRegionFuzzy(0xf3a84b,
        "8|-2|0xf3a84b,19|-2|0xfaddc7,16|8|0xf3a84b,19|8|0xfffefd,19|16|0xfbe7d9,30|16|0xf3a84b,30|0|0xf3a84b,37|0|0xf3a84b,37|5|0xfef9f6,65|5|0xf7c8a1,63|-2|0xf3a84b,63|7|0xffffff,59|15|0xf7cba6,70|15|0xfffefd,90|15|0xf3a84b,90|3|0xf3a84b,87|-4|0xf3a84b,99|-2|0xf3a84b,107|-2|0xf3a84b,107|16|0xf3a84b,115|11|0xf3a84b,96|11|0xf3a84b",
        90, 374, 1048, 570, 1122, { orient = 6 })
    if x ~= -1 then
        baseUtils.tapSleep(x, y, 1.5) -- 切换下一关卡
        toast("切换下一关卡")
        mSleep(20000)
    end

    x, y = findMultiColorInRegionFuzzy(0xa6a1ad,
        "0|0|0xa6a1ad,2|0|0x938f99,3|1|0xa5a0ac,7|1|0xa5a0ac,5|4|0xa39eaa,0|4|0xa6a1ad,-3|4|0xa39eab,-1|9|0xa29da9,3|9|0xa29da9,5|7|0x98939f,14|5|0x94909b,18|5|0xa6a1ad,20|5|0x96929d,24|5|0x94909b,24|8|0x9a96a1,24|12|0xa6a1ad,20|12|0x95919c,17|13|0xa5a0ac,19|9|0xa6a1ad,30|6|0xa39eab,32|4|0x848089,32|7|0x938f9a,35|7|0x8b8792,42|7|0x8f8b96,36|10|0xa6a1ad,37|13|0xa6a1ad,41|13|0xa5a0ac,61|5|0xa49fab,61|8|0xa49fab,61|12|0xa09ca8,53|7|0xa39fab",
        95, 102, 753, 617, 1275, { orient = 7 }) -- 匹配”点击空白“ 图色
    if x ~= -1 then
        baseUtils.tapSleep(40, 1255, 1.5)        -- 点击空白处
        toast("弹窗确认")
        mSleep(20000)
    end

    if x == -1 then
        x, y = findMultiColorInRegionFuzzy(0xa6a1ad,
            "0|0|0xa6a1ad,2|0|0x938f99,3|1|0xa5a0ac,7|1|0xa5a0ac,5|4|0xa39eaa,0|4|0xa6a1ad,-3|4|0xa39eab,-1|9|0xa29da9,3|9|0xa29da9,5|7|0x98939f,14|5|0x94909b,18|5|0xa6a1ad,20|5|0x96929d,24|5|0x94909b,24|8|0x9a96a1,24|12|0xa6a1ad,20|12|0x95919c,17|13|0xa5a0ac,19|9|0xa6a1ad,30|6|0xa39eab,32|4|0x848089,32|7|0x938f9a,35|7|0x8b8792,42|7|0x8f8b96,36|10|0xa6a1ad,37|13|0xa6a1ad,41|13|0xa5a0ac,61|5|0xa49fab,61|8|0xa49fab,61|12|0xa09ca8,53|7|0xa39fab",
            95, 89, 609, 630, 1272, { orient = 7 }) -- 匹配”点击空白“ 图色
        if x ~= -1 then
            baseUtils.tapSleep(40, 1255, 1.5)       -- 点击空白处
            toast("弹窗确认")
            mSleep(20000)
        end
    end

    if x == -1 then
        x, y = findMultiColorInRegionFuzzy(0xa6a1ad,
            "1|1|0xa5a0ac,3|1|0xa39fab,6|2|0x7f7b87,4|4|0xa49fab,2|4|0xa39eaa,-2|4|0xa39eaa,-4|4|0xa6a1ad,-4|7|0xa6a1ad,-4|8|0xa49fac,1|8|0xa29da9,6|9|0x7d7984,6|12|0x9b97a3,-1|12|0xa29da9,-5|11|0xa6a1ad,3|11|0xa09ba7,12|9|0xa6a1ad,12|11|0xa6a1ad,17|12|0xa19ca8,22|12|0x888490,17|9|0xa5a0ac,17|6|0xa6a1ad,17|4|0xa5a0ac,17|2|0xa6a1ad,14|2|0xa19ca9,21|2|0xa19ca9,23|6|0x9d98a4,12|6|0xa19ca8,19|6|0x9f9aa6",
            95, 89, 609, 630, 1272, { orient = 7 })
        if x ~= -1 then
            baseUtils.tapSleep(40, 1255, 1.5) -- 点击空白处
            toast("弹窗确认")
            mSleep(20000)
        end
    end

    if x == -1 then
        x, y = findMultiColorInRegionFuzzy(0xa6a1ad,
            "0|2|0xa6a1ad,0|4|0xa39eaa,-3|4|0xa49fac,-3|8|0xa19da9,0|8|0xa19da9,5|7|0xa6a1ad,5|6|0xa6a1ad,11|6|0xa09ca8,14|6|0x9f9aa6,17|6|0xa6a1ad,19|6|0x9f9aa6,21|6|0xa19ca8,22|10|0xa19da9,19|12|0xa19ca8,17|12|0xa19ca8,14|12|0xa19ca8,12|12|0xa19ca8,12|9|0xa6a1ad,17|8|0xa5a0ac,17|5|0xa6a1ad,17|2|0xa6a1ad,34|1|0xa49fab,36|1|0xa49fab,34|8|0x938f9a,33|8|0xa6a1ad,33|11|0xa6a1ad,29|12|0xa19ca8",
            95, 89, 609, 630, 1272, { orient = 7 })
        if x ~= -1 then
            baseUtils.tapSleep(40, 1255, 1.5) -- 点击空白处
            toast("弹窗确认")
            mSleep(20000)
        end
    end

    ---- 领取离线奖励
    --res = baseUtils.YDOCRTap("notice", 268, 869, 359, 888, "点击空白处", 30, 100)
    ---- 领取离线奖励 - 确认
    --res = baseUtils.YDOCRTap("notice", 279, 1079, 440, 1099, "点击空白处可领取奖励", 30, 100)
    --res = baseUtils.YDOCRTap("notice", 279, 1079, 440, 1099, "点击空白处可领取奖励", 30, 100)
    --res1 = baseUtils.YDOCRTap("notice", 289, 1067, 430, 1094, "点击空白处关闭")
    --res2 = baseUtils.YDOCRTap("notice", 279, 1079, 440, 1099, "点击空白处可领取奖励", 30, 20)
    --res3 = baseUtils.YDOCRTap("notice", 266, 863, 453, 890, "点击空白处可领取奖励", 30, 100)
    --res5 = baseUtils.YDOCRTap("notice", 268, 869, 359, 888, "点击空白处", 30, 100)
    --res6 = baseUtils.YDOCRTap("notice", 261, 861, 457, 893, "点击空白区域继续游戏", 30, 100)

    --x, y = findMultiColorInRegionFuzzy(0xa6a1ad,
    --    "0|0|0xa6a1ad,2|0|0x938f99,3|1|0xa5a0ac,7|1|0xa5a0ac,5|4|0xa39eaa,0|4|0xa6a1ad,-3|4|0xa39eab,-1|9|0xa29da9,3|9|0xa29da9,5|7|0x98939f,14|5|0x94909b,18|5|0xa6a1ad,20|5|0x96929d,24|5|0x94909b,24|8|0x9a96a1,24|12|0xa6a1ad,20|12|0x95919c,17|13|0xa5a0ac,19|9|0xa6a1ad,30|6|0xa39eab,32|4|0x848089,32|7|0x938f9a,35|7|0x8b8792,42|7|0x8f8b96,36|10|0xa6a1ad,37|13|0xa6a1ad,41|13|0xa5a0ac,61|5|0xa49fab,61|8|0xa49fab,61|12|0xa09ca8,53|7|0xa39fab",
    --    90, 102, 753, 617, 1275, { orient = 7 }) -- 匹配”点击空白“ 图色
    --if x ~= -1 then
    --    baseUtils.tapSleep(40, 1255, 1.5)            -- 点击空白处
    --    toast("发现弹窗 - 弹窗确认")
    --    mSleep(20000)
    --end
    --
    --if x == -1 then
    --    x, y = findMultiColorInRegionFuzzy(0xa6a1ad,
    --        "0|0|0xa6a1ad,2|0|0x938f99,3|1|0xa5a0ac,7|1|0xa5a0ac,5|4|0xa39eaa,0|4|0xa6a1ad,-3|4|0xa39eab,-1|9|0xa29da9,3|9|0xa29da9,5|7|0x98939f,14|5|0x94909b,18|5|0xa6a1ad,20|5|0x96929d,24|5|0x94909b,24|8|0x9a96a1,24|12|0xa6a1ad,20|12|0x95919c,17|13|0xa5a0ac,19|9|0xa6a1ad,30|6|0xa39eab,32|4|0x848089,32|7|0x938f9a,35|7|0x8b8792,42|7|0x8f8b96,36|10|0xa6a1ad,37|13|0xa6a1ad,41|13|0xa5a0ac,61|5|0xa49fab,61|8|0xa49fab,61|12|0xa09ca8,53|7|0xa39fab",
    --        90, 102, 753, 617, 1275, { orient = 7 }) -- 匹配”点击空白“ 图色
    --    if x ~= -1 then
    --        baseUtils.tapSleep(40, 1255, 1.5)            -- 点击空白处
    --        toast("发现弹窗 - 弹窗确认")
    --        mSleep(20000)
    --    end
    --end

    --local res1 = false
    --local res2 = false
    --local res3 = false
    --local res4 = false
    --local res5 = false
    --res1 = baseUtils.YDOCRText("notice", 213, 521, 272, 584, "战") -- 战斗胜利
    --if res1 == false then
    --    res2 = baseUtils.YDOCRText("notice", 448, 500, 503, 560, "利") -- 战斗胜利
    --    if res2 == false then
    --        res3 = baseUtils.YDOCRText("notice", 229, 436, 286, 497, "升") --升级成功
    --        if res3 == false then
    --            res4 = baseUtils.YDOCRTap("notice", 301, 1202, 419, 1229, "点击空白处关闭") --战斗失败
    --            if res4 == false then
    --                res5 = baseUtils.YDOCRTap("notice", 265, 986, 455, 1018, "点击空白处可领取奖励") --恶龙胜利
    --            end
    --        end
    --    end
    --end
    --res6 = baseUtils.YDOCRText("notice", 227, 544, 287, 600, "战") -- 战斗失败
    --
    --if res1 or res2 or res3 or res4 or res5 or res6 then
    --    baseUtils.tapSleep(55, 1242, 0.2)  -- 点击空白处
    --    baseUtils.tapSleep(685, 1240, 0.2) -- 点击空白处
    --    toast("发现弹窗 - 弹窗确认")
    --end
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
