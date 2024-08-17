require "TSLib"
require("ts")

json = require "json"
logUtils = require("logUtil")
baseUtils = require("base")
功能开关 = commonVar["功能开关"]

--toast("c1线程启动")
--while (true) do
--	commonVar.c1 = commonVar.c1 + 1
--	toast("c1" .. commonVar.c1)
--	mSleep(1000)
--end

function main(...)
    if commonVar["暴走史莱姆开关"] == 1 and commonVar["暴走雷电大王"] == 1 then
        while (true) do
            if commonVar["breakChild"] == 1 then
                break
            end

            if commonVar["fighting"] == 1 then
                -- 检测战斗状态
                -- 异步识别commonVar["bossStatus"]
                daBaoZouLeiDianBoss()
            else
                mSleep(3000)
            end
        end
    end
end

function daBaoZouLeiDianBoss()
    --优先识别commonVar["bossStatus"]
    for i = 1, 5 do
        x, y = findMultiColorInRegionFuzzy(0xb0e274,
            "8|0|0xb2e281,15|0|0xb8e480,21|0|0xbde579,23|2|0xbae47b,23|14|0xa5df7e,5|36|0xd7ef67,-15|42|0xfefed4,-15|35|0xfefea3,-5|32|0xfefefa,-4|19|0xfefefd,-15|19|0xe7f475,13|19|0xfefefd,13|2|0xcdecae,2|10|0xfefefd,-5|5|0xbde67c,-18|5|0xfefeec,-20|17|0xfefeda,-25|18|0xfefeb3",
            75, 223, 213, 522, 418, { orient = 2 })
        if x ~= -1 then
            commonVar["bossStatus"] = "草"
        end

        x, y = findMultiColorInRegionFuzzy(0xfe9f66,
            "4|-7|0xfea75c,12|-10|0xfeb164,20|-7|0xfeab70,28|-6|0xfea960,28|-3|0xfea96c,31|7|0xfee1d1,36|13|0xfea770,36|21|0xfeb06a,24|21|0xfefcfb,13|21|0xfeae7d,18|12|0xfec5aa,4|18|0xfefdfc",
            75, 223, 213, 522, 418, { orient = 2 })
        if x ~= -1 then
            commonVar["bossStatus"] = "火"
        end

        x, y = findMultiColorInRegionFuzzy(0xb3e8f0,
            "4|0|0xb5e8ef,13|0|0xc8eced,13|10|0xfefefe,-14|10|0xb6e9ef,-11|12|0xfdfefd,8|12|0xfafcfd,22|12|0xafe6ed,29|16|0xfefed2,36|21|0xf7e078,18|21|0xfcfdfd,1|24|0x97e3f1,-7|24|0x96e2f0,-15|24|0xcef1ed,-21|24|0xf4fbf1,-25|36|0xfef991,9|36|0xd0f1ed,25|36|0xfefeb2,-4|26|0x93e1f1",
            80, 223, 213, 522, 418, { orient = 2 })
        if x ~= -1 then
            commonVar["bossStatus"] = "水"
        end

        if commonVar["bossStatus"] ~= "" then
            break
        end
    end
    mSleep(500)
    -- 未识别commonVar["bossStatus"]，无需识别玩家状态；提前返回准备下一轮识别
    --if commonVar["bossStatus"] == "" then
    --    return
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
