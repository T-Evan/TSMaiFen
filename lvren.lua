local lvrenTask = {}

-- 旅人任务聚合
function lvrenTask.lvrenTask()
    if 功能开关["日常功能开关"] ~= nil and 功能开关["日常功能开关"] == 0 then
        return
    end

    -- 旅人相关

    -- 自动强化装备
    lvrenTask.updateEquip()

    -- 自动升级技能
    lvrenTask.updateSkill()

    -- 猫猫包
    lvrenTask.maomaobao()
end

-- 自动强化装备
function lvrenTask.updateEquip()
    if 功能开关["自动强化装备"] ~= nil and 功能开关["自动强化装备"] == 0 then
        return
    end

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 233, 1205, 281, 1234, "行李")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 446, 413, 528, 438, "一键强化")
end

-- 自动升级技能
function lvrenTask.updateSkill()
    if 功能开关["自动升级技能"] ~= nil and 功能开关["自动升级技能"] == 0 then
        return
    end

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 434, 1205, 484, 1234, "旅人")
    if res == false then
        return
    end

    x, y = findMultiColorInRegionFuzzy(0x83b853,
        "6|9|0xfefefa,11|9|0x81b852,11|15|0x83b953,11|21|0x84bc54,7|20|0x82b852,5|20|0x85bd5a,0|20|0x7eb54d,-6|20|0x82b853,-6|15|0x83b953,4|15|0xfbfdf9,4|12|0xfdfdf7",
        80, 0, 0, 720, 1280, { orient = 2 })
    if x ~= -1 then
        baseUtils.tapSleep(x, y, 3)
        res = baseUtils.TomatoOCRTap(tomatoOCR, 505, 916, 548, 944, "最大", 2, 2)
        baseUtils.tapSleep(365, 985) -- 点击升级按钮
    end
end

-- 猫猫包
function lvrenTask.maomaobao()
    if 功能开关["猫猫包果木"] ~= nil then
        if 功能开关["猫猫包果木"] == 0 or 任务记录["旅人-猫猫果木-完成"] == 1 then
            return
        end
    else
        return
    end

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 434, 1205, 484, 1234, "旅人")
    res = baseUtils.TomatoOCRTap(tomatoOCR, 564, 238, 630, 263, "猫猫包")
    res = baseUtils.TomatoOCRTap(tomatoOCR, 615, 1030, 696, 1055, "猫猫烤箱")
    if res == false then
        return
    end

    -- 点击果木
    x, y = findMultiColorInRegionFuzzy(0x95664b,
        "0|2|0x8c5b3f,1|3|0xba906e,6|9|0xba8b6d,0|9|0xcca781,-11|13|0xb26e49,-4|16|0xbc8966,-6|16|0xa26242,-7|17|0x55392d,-10|17|0x815137,-3|23|0x714f37,2|20|0x724d3a,10|16|0x724c39,6|18|0x724c39",
        90, 0, 0, 720, 1280, { orient = 2 })
    if x ~= -1 then
        baseUtils.tapSleep(x + 0, y, 3)
        res = baseUtils.TomatoOCRTap(tomatoOCR, 265, 863, 452, 893, "点击空白处可领取奖励", 30, 100)
    end

    -- 快捷兑换
    res = baseUtils.TomatoOCRTap(tomatoOCR, 557, 188, 639, 214, "快速兑换")
    local needCount = tonumber(功能开关["钻石兑换果木次数"])
    if needCount == nil then
        needCount = 0
    end

    if res then
        while 1 do
            -- 钻石兑换果木
            res, buyCount = baseUtils.TomatoOCRText(tomatoOCR, 378, 895, 389, 910, needCount) -- 1/9
            buyCount = tonumber(buyCount)
            if buyCount == nil or buyCount >= needCount then
                break
            end
            res = baseUtils.TomatoOCRTap(tomatoOCR, 338, 832, 379, 854, "购买")
            baseUtils.tapSleep(360, 1100) -- 点击空白处关闭
        end
    end

    任务记录["旅人-猫猫果木-完成"] = 1
end

return lvrenTask
