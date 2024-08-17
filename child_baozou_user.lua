require "TSLib"
require("ts")

json = require "json"
logUtils = require("logUtil")
baseUtils = require("base")
功能开关 = commonVar["功能开关"]

--toast("c2线程启动")
--while (true) do
--	commonVar.c2 = commonVar.c2 + 1
--    toast("c2" .. commonVar.c2)
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
                daBaoZouLeiDianUser()
            else
                mSleep(3000)
            end
        end
    end
end

function daBaoZouLeiDianUser()
    for i = 1, 5 do
        -- 识别开花
        x, y = findMultiColorInRegionFuzzy(0x399976,
            "0|1|0x3eac87,3|2|0x3eb694,17|1|0x3ab0a0,20|4|0x2e9c7b,22|16|0x5ec798,9|12|0xa3f1f0,2|12|0xaef3f6,-3|13|0xc2f5f6,-7|18|0xe1f4f6,-5|30|0x47a26c,-4|23|0xebf1f3,1|31|0x59bc84,5|28|0xe1eeed,10|32|0xd8ecec,11|17|0xa3efdc,15|22|0x85e1b9,22|22|0xbee4d7,26|23|0x4da36d,26|27|0x43945e,22|31|0x459e66,19|34|0x3d8d58,16|37|0x3c8650,15|37|0x3e8953,13|37|0x41935b",
            85, 221, 666, 510, 1033, { orient = 2 })
        --x, y = findMultiColorInRegionFuzzy(0xa0efe4,
        --    "3|1|0xb8f4f1,12|0|0xc9f7f9,12|4|0xdff7f8,15|4|0xe1f6f7,15|9|0x7adcae,13|16|0xe3efef,9|16|0xddeeef,3|16|0x81d7ad,-3|16|0x5ec089,-5|11|0xcce9e3,-5|6|0xe8f6f7,-10|-1|0x5cbca1",
        --    85, 221, 666, 510, 1033, { orient = 2 })
        if x ~= -1 then
            commonVar["userStatus"] = "开花"
            break
        end

        -- 识别篝火
        x, y = findMultiColorInRegionFuzzy(0x61b570,
            "2|0|0x7bbc75,5|0|0xafb06f,11|0|0xfaf1e1,17|0|0xf9eedc,22|0|0xe3c99d,28|0|0x6bc382,35|0|0x5b9e6c,29|6|0x6cbc7d,24|6|0xf6dfc6,17|6|0xdbb26f,16|6|0xbfc075,1|7|0x6eb771,1|14|0x958b49,8|14|0xf3bd99,13|14|0xe99e62,22|14|0xf3c09c,31|14|0x578e48,32|7|0x56a560,10|23|0x698742,30|5|0x61b671,31|-3|0x50a96e",
            80, 221, 666, 510, 1033, { orient = 7 })
        --x, y = findMultiColorInRegionFuzzy(0x85c897,
        --    "1|-2|0x94b091,6|-2|0xfbf7f3,16|-2|0xfaf6f2,24|-2|0x8dabb0,24|4|0x73be8a,20|9|0xf3ddc5,11|9|0xb6c87e,4|9|0xf6e3ce,-2|9|0xc7ae7a,-4|17|0x6d9b59,5|19|0xf1bc98,6|23|0xf0a582,11|26|0x868650,16|26|0xcd7c4a,21|22|0xb57337,21|13|0x9da059",
        --    85, 221, 666, 510, 1033, { orient = 7 })
        if x ~= -1 then
            commonVar["userStatus"] = "篝火"
            break
        end

        -- 识别蒸汽
        x, y = findMultiColorInRegionFuzzy(0xc43c4c,
            "2|0|0xbf4059,5|0|0xbe4a6b,7|0|0xc24f78,9|1|0xc15998,12|1|0x98d2f6,16|1|0xb496dd,17|1|0xc561a9,19|1|0xbc4f7a,21|1|0xbc4a6e,26|1|0xc73f51,26|5|0xc05485,23|4|0x9eabe0,20|4|0xb85797,19|4|0xb75ca1,13|4|0x96d9f8,8|4|0xb65ca4,6|4|0xb8589b,0|5|0x9cbeec,4|13|0xaf71c6,9|13|0xcbecf4,16|13|0xa475cb,20|13|0xb8c8e9,27|13|0xc05e99,27|18|0xbc5b8a,23|21|0xb978c4,13|21|0x987aca,9|22|0x996eba,-1|22|0xb5568d,3|29|0xc4e4ed,16|31|0xbf80b9",
            80, 221, 666, 510, 1033, { orient = 7 })
        --x, y = findMultiColorInRegionFuzzy(0xce3d5d,
        --    "10|0|0xbb5793,6|-3|0xc3425b,22|-3|0xd94f90,24|9|0xc9ebf6,31|9|0xc4587b,30|15|0xbc5b88,21|15|0xb385d5,11|15|0xc4e0f1,4|21|0xae5b99,-3|21|0xba516e,8|18|0x9e6bb8,8|23|0xa666a5,3|24|0xbe5ea0,3|25|0xc175b2,3|30|0xc2e2ec,10|30|0xc4e5ee,18|30|0xc273ad,23|30|0xc6e7ee",
        --    85, 221, 666, 510, 1033, { orient = 7 })
        if x ~= -1 then
            commonVar["userStatus"] = "蒸汽"
            break
        end

        if commonVar["userStatus"] ~= "" then
            break
        end
    end
    mSleep(500)
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
