require "TSLib"
require("ts")

json = require "json"
logUtils = require("logUtil")
baseUtils = require("base")
--dailyTask = require("daily")
--shilianTask = require("shilian")
功能开关 = commonVar["功能开关"]

--tomatoOCR = baseUtils.initTomatoOCR()
--toast("c4线程启动")
--while (true) do
--    commonVar.c4 = commonVar.c4 + 1
--    toast("c4" .. commonVar.c4)
--    mSleep(1000)
--end
--toast("return线程启动" .. commonVar.needHome)
function main(...)
    while (true) do
        if commonVar["breakChild"] == 1 then
            break
        end
        -- 异步处理返回首页
        if commonVar["needHome"] == 1 then
            returnHome()
        else
            mSleep(3000)
        end
    end
end

function returnHome()
    for i = 1, 5 do
        -- 已返回首页
        if commonVar["needHome"] == 0 then
            return
        end

        --res6 = baseUtils.TomatoOCRTapV2(tomatoOCR, 213, 604, 266, 635, "拒绝") -- 避免错误时机匹配成功（存在多次拒绝导致的匹配惩罚）

        x, y = findMultiColorInRegionFuzzy(0x6584b9,
            "2|0|0x6584b9,8|0|0x6584b9,15|0|0x6584b9,17|0|0x6584b9,20|0|0x6584b9,23|0|0x6584b9,27|0|0x6584b9,31|0|0x6584b9,46|0|0x6584b9,59|0|0x6584b9,65|-1|0x6584b9,72|1|0x6584b9,78|1|0x6584b9,78|8|0x6584b9,66|6|0x6584b9,56|6|0x6584b9,45|4|0x6584b9,36|5|0x6584b9,9|5|0x6584b9,-7|4|0x6483b8",
            75, 3, 1115, 144, 1272, { orient = 7 }) -- 返回按钮
        if x ~= -1 then
            toast("返回首页")
            baseUtils.tapSleep(x, y, 1.5)
        end
        x2, y2 = findMultiColorInRegionFuzzy(0x6584b9,
            "0|3|0x6484b9,0|17|0x6483b8,0|25|0xffffff,0|34|0x6584b9,6|34|0x7892c3,6|22|0x6184b8,10|16|0xffffff,15|16|0x6685ba,27|16|0x9daccd,25|16|0xffffff,25|24|0xf5f6f9,32|24|0xf9f9fb,36|24|0xd8dde9,36|22|0x9babcc,36|19|0xffffff,29|18|0xf6f7fa,29|13|0xd9deea,34|13|0xfafafc,32|9|0xffffff,39|9|0xffffff",
            80, 3, 1115, 144, 1272, { orient = 7 }) -- 返回按钮
        if x2 ~= -1 then
            toast("返回首页")
            baseUtils.tapSleep(x2, y2, 1.5)
        end
        x3, y3 = findMultiColorInRegionFuzzy(0xffffff,
            "1|2|0xfdfdfe,1|18|0x6584b9,8|14|0xfbfcfd,8|-2|0x6a87ba,8|2|0xd6dbe8,17|8|0x6d89bb,15|8|0xf6f7fa,15|14|0xfdfdfe,15|18|0xd5dbe7,22|-2|0x6584b9,32|3|0xeef0f5,32|12|0xeef0f5,32|20|0x6584b9,42|18|0xccd3e3,49|18|0xbac3d9,50|12|0xffffff,47|3|0x6584b9,39|6|0xf3f4f8,39|10|0xd7dce8,63|8|0x81a4dc,63|9|0x82a5dd,81|9|0x9fc5ff,78|9|0x9ec5ff,67|9|0x83a6df",
            90, 2, 1118, 260, 1277, { orient = 7 })
        if x3 ~= -1 then
            toast("返回首页")
            baseUtils.tapSleep(x3, y3, 1.5)
        end

        if x1 == -1 and x2 == -1 and x3 == -1 then
            --判断是否在首页
            resShou = baseUtils.YDOCRText("return", 626, 379, 711, 405, "冒险手册")
            if resShou then
                toast("已返回首页")
                commonVar.needHome = 0
                return
            end

            --res7 = dailyTask.quitTeam()
            --
            --if res7 == false then
            --    --判断战败页
            --    shilianTask.fightFail()
            --end
        end
    end

    --res = baseUtils.YDOCRTap("return", 168, 1184, 204, 1219, "回")
    --if res == false then
    --    res = baseUtils.YDOCRTap("return", 67, 1187, 120, 1218, "返回")
    --end
    --if res == false then
    --    res = baseUtils.YDOCRTap("return", 70, 1200, 123, 1231, "返回")
    --end
    --if res == false then
    --    res = baseUtils.YDOCRTap("return", 87, 1187, 138, 1219, "返回") -- 邮件页返回按钮
    --end
    --if res == false then
    --    res = baseUtils.YDOCRTap("return", 171, 1189, 200, 1216, "回")
    --end
    --if res == false then
    --    res = baseUtils.YDOCRTap("return", 98, 1202, 128, 1231, "回")
    --end
    --if res == false then
    --    res = baseUtils.YDOCRTap("return", 93, 1186, 127, 1217, "回")
    --end
    --
    ---- 点击首页-冒险
    --res = baseUtils.YDOCRTap("return", 327, 1205, 389, 1233, "冒险")
    mSleep(4000)
    -- 判断宝箱开启
    --shilianTask.openTreasure()
end

function initTomatoOCRReturn()
    local tomatoOCR = require("TomatoOCRCore")

    -- 初始化-android-触动精灵
    tomatoOCR.init("android")

    -- 初始化-android-触动小精灵
    --tomatoOCR.init("android-x")
    local license =
    "gAAAAABmo1lIAAAAAGeaUIBr5x9E7spn_xedmP6VKb40BJaa9nSPCHpmoc7tABnFHWPOz24TrHhyuXdaVI95ANvi99C8LN90K0RqD83nbURChETd-8YmvnOd2AXfsM2ioQ==" -- 从群文件txt中获取
    local flag = tomatoOCR.setLicense(license)
    -- flag= 次数 或 到期日期 : 试用license或正式license

    local rec_type = "ch-3.0"
    -- 注：ch、ch-2.0、ch-3.0版可切换使用，对部分场景可适当调整
    -- "ch"：普通中英文识别，1.0版模型
    -- "ch-2.0"：普通中英文识别，2.0版模型
    -- "ch-3.0"：普通中英文识别，3.0版模型
    -- "cht"：繁体，"japan"：日语，"korean"：韩语
    tomatoOCR.setRecType(rec_type)

    tomatoOCR.setDetBoxType("rect")     -- 调整检测模型检测文本参数- 默认"rect": 由于手机上截图文本均为矩形文本，从该版本之后均改为rect，"quad"：可准确检测倾斜文本
    tomatoOCR.setDetUnclipRatio(1.9)    -- 调整检测模型检测文本参数 - 默认1.9: 值范围1.6-2.5之间
    tomatoOCR.setRecScoreThreshold(0.6) -- 识别得分过滤 - 默认0.1，值范围0.1-0.9之间
    tomatoOCR.setReturnType("json")
    -- 返回类型 - 默认"json": 包含得分、坐标和文字；
    -- "text"：纯文字；
    -- "num"：纯数字；
    -- 自定义输入想要返回的文本：".￥1234567890"，仅只返回这些内容

    local type = 3
    -- type 可传可不传
    -- type=0 : 只检测
    -- type=1 : 方向分类 + 识别
    -- type=2 : 只识别
    -- type=3 : 检测 + 识别

    -- 只检测文字位置：type=0
    -- 全屏识别: type=3或者不传type
    -- 截取单行文字识别：type=1或者type=2

    return tomatoOCR
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
