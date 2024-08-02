local lvtuanTask = {}

-- 旅团任务聚合
function lvtuanTask.lvtuanTask()
    if 功能开关["旅团功能开关"] ~= nil and 功能开关["旅团功能开关"] == 0 then
        return
    end

    -- 旅团签到
    lvtuanTask.lvTuanWater()

    -- 旅团任务
    lvtuanTask.lvTuanRenWu()


    -- 旅团调查队
    lvtuanTask.lvTuanDiaoCha()
end

-- 调查队
function lvtuanTask.lvTuanDiaoCha()
    if 功能开关["旅团调查队"] ~= nil then
        if 功能开关["旅团调查队"] == 0 or 任务记录["旅团-调查队-完成"] == 1 then
            return
        end
    else
        return
    end

    local loopCount = 0
    local needCount = tonumber(功能开关["调查队挑战次数"])
    if needCount == nil then
        needCount = 0
    end

    while loopCount < needCount do
        loopCount = loopCount + 1

        local loopCount = 0
        while loopCount < 3 do
            loopCount = loopCount + 1
            res = baseUtils.TomatoOCRTap(tomatoOCR, 632, 916, 702, 947, "调查队")
            if res == false then
                res = baseUtils.TomatoOCRTap(tomatoOCR, 647, 592, 689, 614, "旅团")
                if res == false then
                    -- 返回首页
                    dailyTask.homePage()
                    -- 退出组队
                    dailyTask.quitTeam()
                else
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 632, 916, 702, 947, "调查队")
                end
            else
                break
            end
        end

        res = baseUtils.TomatoOCRTap(tomatoOCR, 309, 966, 414, 994, "开启调查")
        baseUtils.tapSleep(205, 760)    -- 添加队友
        baseUtils.tapSleep(530, 435, 1) -- 添加队友1
        baseUtils.tapSleep(530, 556, 1) -- 添加队友2
        baseUtils.tapSleep(531, 674, 1) -- 添加队友3
        baseUtils.tapSleep(532, 794, 1) -- 添加队友4
        baseUtils.tapSleep(530, 910, 1) -- 添加队友5
        res = baseUtils.TomatoOCRTap(tomatoOCR, 70, 1200, 123, 1231, "返回")
        res = baseUtils.TomatoOCRTap(tomatoOCR, 331, 976, 386, 1005, "开始")
        baseUtils.mSleep3(5 * 1000)
        -- 战斗中
        lvtuanTask.fighting()
    end

    任务记录["旅团-调查队-完成"] = 1
end

-- 旅团任务
function lvtuanTask.lvTuanRenWu()
    if 功能开关["旅团任务"] ~= nil and 功能开关["旅团任务"] == 0 then
        return
    end

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 647, 592, 689, 614, "旅团")

    res = baseUtils.TomatoOCRTap(tomatoOCR, 624, 742, 708, 767, "旅团任务")
    if res == false then
        return
    end

    while 1 do
        x, y = findMultiColorInRegionFuzzy(0xfffefe,
            "6|0|0xfdf6f0,13|0|0xfadfcb,22|0|0xfffffe,32|0|0xfefaf7,39|0|0xf6c091,39|7|0xf3a84b,36|7|0xffffff,25|7|0xfceade,16|7|0xffffff,7|7|0xfceee5,-1|7|0xf9dbc5,0|12|0xf5bb85,11|12|0xfbe7d9,16|12|0xfcede2,22|11|0xffffff,32|11|0xfefaf7",
            90, 0, 0, 720, 1280, { orient = 2 }) -- 识别黄色领取按钮
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            baseUtils.tapSleep(360, 1100) -- 点击空白处关闭

            -- 点击宝箱（从右到左）
            baseUtils.tapSleep(570, 390)
            baseUtils.tapSleep(490, 390)
            baseUtils.tapSleep(410, 390)
            baseUtils.tapSleep(330, 390)
            baseUtils.tapSleep(250, 390)
        else
            break
        end
    end
end

-- 旅团浇水
function lvtuanTask.lvTuanWater()
    if 功能开关["旅团浇树"] == 0 or 任务记录["旅团-浇树-完成"] == 1 then
        return
    end

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 647, 592, 689, 614, "旅团")
    baseUtils.tapSleep(400, 250, 3)

    res = baseUtils.TomatoOCRText(tomatoOCR, 312, 627, 407, 655, "旅团之树")
    local needCount = tonumber(功能开关["付费浇树次数"])
    if needCount == nil then
        needCount = 0
    end
    buyCount = 0
    if res then
        while 1 do
            res, buyCount = baseUtils.TomatoOCRText(tomatoOCR, 400, 1137, 416, 1153, "已购买次数") -- 1/5
            buyCount = tonumber(buyCount)
            if buyCount == nil or buyCount - 1 >= needCount then
                任务记录["旅团-浇树-完成"] = 1
                break
            end

            if buyCount == 0 then
                -- 免费浇灌
                baseUtils.tapSleep(360, 1100)
                baseUtils.tapSleep(360, 1100) -- 点击空白处关闭
                baseUtils.mSleep3(3000)
            end

            -- 付费浇灌
            if buyCount - 1 < needCount then
                baseUtils.tapSleep(360, 1100, 3)
                baseUtils.tapSleep(464, 755, 3)
                baseUtils.tapSleep(360, 1100) -- 点击空白处关闭
            end
        end
    end
end

-- 判断是否战斗中
function lvtuanTask.fighting()
    local attempts = 0     -- 初始化尝试次数
    local maxAttempts = 30 -- 设置最大尝试次数

    while attempts < maxAttempts do
        res = baseUtils.TomatoOCRText(tomatoOCR, 642, 461, 702, 483, "麦克风")
        if res then
            logUtils.log("战斗中")
        else
            break -- 识别失败，退出循环
        end
        attempts = attempts + 1
        baseUtils.mSleep3(5 * 1000) -- 可以根据需要添加适当的延迟
    end

    -- 战斗结束
    lvtuanTask.openTreasure()
end

-- 领取宝箱（调查队）
function lvtuanTask.openTreasure()
    local attempts = 0    -- 初始化尝试次数
    local maxAttempts = 2 -- 设置最大尝试次数

    while attempts < maxAttempts do
        attempts = attempts + 1
        -- 调查队宝箱
        -- 战斗结束页
        res = baseUtils.TomatoOCRTap(tomatoOCR, 331, 1022, 387, 1050, "开启")
        if res then
            baseUtils.tapSleep(340, 930)
        end
        -- 结算页
        res = baseUtils.TomatoOCRTap(tomatoOCR, 333, 752, 388, 781, "开启")
        if res then
            baseUtils.mSleep3(1000)
            baseUtils.tapSleep(340, 930)
        end

        -- 钥匙不足退出
        res = baseUtils.TomatoOCRText(tomatoOCR, 329, 726, 391, 761, "0")
        if res then
            logUtils.log("钥匙不足")
            res = baseUtils.TomatoOCRText(tomatoOCR, 68, 1201, 130, 1232, "返回")
            res = baseUtils.TomatoOCRText(tomatoOCR, 329, 723, 391, 762, "确定")
        end
    end
end

return lvtuanTask
