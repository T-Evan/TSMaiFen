local lvtuanTask = {}

-- 旅团任务聚合
function lvtuanTask.lvtuanTask()
    if 功能开关["旅团功能开关"] ~= nil and 功能开关["旅团功能开关"] == 0 then
        return
    end

    -- 旅团签到
    lvtuanTask.lvTuanWater()

    -- 旅团许愿墙
    lvtuanTask.lvTuanXuYuan()

    -- 旅团任务
    lvtuanTask.lvTuanRenWu()

    -- 旅团任务
    lvtuanTask.lvTuanShop()

    -- 旅团调查队
    lvtuanTask.lvTuanDiaoCha()
end

-- 旅团商店（服务区）
function lvtuanTask.lvTuanShop()
    if 功能开关["旅团商店兑换开关"] ~= nil and 功能开关["旅团商店兑换开关"] == 0 then
        return
    end

    baseUtils.toast("旅团 - 商店兑换 - 开始")

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 647, 592, 689, 614, "旅团")

    res = baseUtils.TomatoOCRTap(tomatoOCR, 634, 667, 698, 693, "服务区")
    if res == false then
        return
    end

    baseUtils.mSleep3(4000) -- 等待跳转动画

    local count = 0
    while count < 5 do
        if 功能开关["旅团商店-唤兽琴弦"] == 1 then
            x, y = findMultiColorInRegionFuzzy(0xffde9b,
                "-1|8|0xf2e9a8,10|11|0xb17c46,19|12|0xd19350,29|14|0xfee098,25|26|0xfad58e,-5|34|0xefc379,3|33|0xefe4df,24|29|0xfad28a,23|42|0xf5cd83,-15|92|0xfef593,-19|98|0xf1cf4d,-12|105|0xe4b142,-10|98|0xe2ac3c,-9|89|0xf2a94b",
                80, 0, 0, 720, 1280, { orient = 2 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y) -- 点击道具
                lvtuanTask.shopBuy()
            end
        end

        if 功能开关["旅团商店-全价兽粮"] == 1 then
            x, y = findMultiColorInRegionFuzzy(0xc68858,
                "6|-1|0xd8a06c,15|-2|0xcf9f6a,24|3|0xb16d48,20|9|0xe4c8a1,10|11|0xf2e2bf,2|11|0xecd9b2,-1|21|0xecdcb3,8|22|0xe0a13a,17|30|0xeddaac,7|32|0xc57d28,-21|85|0xecc95a,-26|94|0xeec64b,-16|92|0xf2d75b,-17|101|0xecca55,-29|87|0xf2a94b,-27|81|0xf1a84b",
                80, 0, 0, 720, 1280, { orient = 2 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y) -- 点击道具
                lvtuanTask.shopBuy()
            end
        end

        if 功能开关["旅团商店-超级成长零食"] == 1 then
            x, y = findMultiColorInRegionFuzzy(0xfac470,
                "10|0|0xfddfa2,23|6|0xffd89a,2|12|0xfee4ae,-7|17|0xffe9ac,-13|27|0xfddfa9,-3|24|0xe38943,-1|31|0xf2b26d,8|24|0xf1ad63,12|25|0xf3c56f,-25|86|0xfef59b,-28|99|0xe5ba41,-19|95|0xecbd46,-17|82|0xf2a94b,-39|84|0xf2a94b",
                80, 0, 0, 720, 1280, { orient = 2 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y) -- 点击道具
                lvtuanTask.shopBuy()
            end
        end

        if 功能开关["旅团商店-原材料"] == 1 then
            x, y = findMultiColorInRegionFuzzy(0x6a7290,
                "0|7|0xb5b5d1,5|6|0x989cba,11|7|0x626486,6|17|0x75789a,-9|14|0xc6c4de,-17|17|0xb7bad8,-21|20|0xbabddc,-16|31|0x848cae,-6|27|0x7c7ca5,-37|84|0xc38d36,-41|95|0xf0d14e,-49|92|0xf2a94b,-33|96|0xedc548,-27|90|0xf2a94b",
                80, 0, 0, 720, 1280, { orient = 2 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y) -- 点击道具
                lvtuanTask.shopBuy()
            end
        end

        if 功能开关["旅团商店-史诗经验"] == 1 then
            x, y = findMultiColorInRegionFuzzy(0x82397c,
                "6|7|0x943d81,-22|2|0x441940,-14|8|0xae4b98,-7|4|0xfdf4fd,-6|16|0xdb69c6,-23|11|0x984b93,-19|23|0xd757be,-9|28|0xd557be,1|25|0xd555c0,10|15|0x822e63,-29|82|0xf2a94b,-40|86|0xfaf194,-51|85|0xf2a94b,-32|95|0xdfa333,-33|88|0xf7df6a",
                80, 0, 0, 720, 1280, { orient = 2 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y) -- 点击道具
                lvtuanTask.shopBuy()
            end
        end

        if 功能开关["旅团商店-优秀经验"] == 1 then
            x, y = findMultiColorInRegionFuzzy(0x1b2f3b,
                "9|0|0x46616d,20|2|0xc7eed5,24|8|0x66c787,23|19|0xe3c785,12|16|0x9cc6e4,0|18|0x3682b6,0|30|0xd5bf5a,10|28|0xd8bd5a,26|26|0x4eaad7,18|32|0xd4ba57,-22|91|0xfef49a,-27|99|0xf1d65a,-24|106|0xf1a84b,-19|104|0xe3b33f,-16|98|0xe2ae3c,-10|94|0xf2a94b,-36|92|0xf2a94b",
                80, 0, 0, 720, 1280, { orient = 2 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y) -- 点击道具
                lvtuanTask.shopBuy()
            end
        end

        if 功能开关["旅团商店-普通经验"] == 1 then
            x, y = findMultiColorInRegionFuzzy(0x71f0d0,
                "7|1|0x529984,13|2|0x41aa95,23|13|0x3da896,8|12|0x42bb9a,-8|21|0x2e9a7d,13|25|0x57cdb3,23|22|0xe3f7f3,33|23|0x68bf60,24|34|0x6bbf63,1|35|0x60c491,-20|81|0xf2a94b,-23|91|0xfcee81,-11|91|0xf0a84b,-32|86|0xf2a94b,-31|92|0xb27834,-11|86|0xf2a94b",
                80, 0, 0, 720, 1280, { orient = 2 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y) -- 点击道具
                lvtuanTask.shopBuy()
            end
        end

        if 功能开关["旅团商店-金币"] == 1 then
            x, y = findMultiColorInRegionFuzzy(0xedcd7d,
                "13|2|0xfae7a5,23|8|0xfff5ac,22|15|0xeac275,6|11|0xd2a96f,-1|11|0xc58a58,-9|13|0xf5d38b,-8|26|0xe9c275,11|23|0xdfba71,1|22|0xd2a163,24|26|0xfef3ac,-20|85|0xfef89d,-28|89|0xe4bc45,-35|86|0xf2a94b,-28|96|0xeac44d,-21|97|0xdfaa39,-17|92|0xf5db61,-13|91|0xcb8c31",
                80, 0, 0, 720, 1280, { orient = 2 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y) -- 点击道具
                lvtuanTask.shopBuy()
            end
        end

        -- 翻页
        moveTo(360, 850, 360, 750, 30)
        baseUtils.mSleep3(3500);
        count = count + 1
    end
end

function lvtuanTask.shopBuy()
    x, y = findMultiColorInRegionFuzzy(0xedf1fa,
        "5|1|0xe5eaf7,10|2|0x7da2e2,18|3|0xdfe6f6,28|4|0xdee5f6,23|7|0x8aaae3,19|12|0x83a5e2,13|11|0x7da2e2,5|9|0xf7f8fc,-3|7|0xffffff,-4|16|0x7da2e2,5|14|0xd5def3,10|16|0x7da2e2,14|12|0xcfd9f1,15|13|0xffffff",
        80, 0, 0, 720, 1280, { orient = 2 })
    if x ~= -1 then
        baseUtils.tapSleep(x, y) -- 点击最大
    end
    x, y = findMultiColorInRegionFuzzy(0xf3a84b,
        "7|-1|0xf7caa5,11|-1|0xf7cdaa,19|1|0xf3a84b,20|1|0xf8d3b6,20|-1|0xfefcfb,29|0|0xfffffe,36|2|0xf3a84b,33|4|0xfbe8db,31|9|0xffffff,26|8|0xf3a84c,20|8|0xfceee5,12|7|0xfae0cd,9|11|0xf6c59a,18|10|0xfdf5f0",
        80, 0, 0, 720, 1280, { orient = 2 })
    if x ~= -1 then
        baseUtils.tapSleep(x, y)      -- 点击购买
        baseUtils.tapSleep(360, 1210) -- 点击空白处
    end
end

-- 调查队
function lvtuanTask.lvTuanDiaoCha()
    if 功能开关["旅团调查队"] ~= nil then
        if 功能开关["旅团调查队"] == 0 then
            baseUtils.toast("旅团 - 调查队 - 未开启")
            return
        end
        if 任务记录["旅团-调查队-完成"] == 1 then
            baseUtils.toast("旅团 - 调查队 - 已完成")
            return
        end
    else
        return
    end

    baseUtils.toast("旅团 - 调查队 - 开始")

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

    baseUtils.toast("旅团 - 旅团任务领取 - 开始")

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

-- 旅团许愿墙
function lvtuanTask.lvTuanXuYuan()
    if 功能开关["旅团许愿墙"] == 0 or 任务记录["旅团-许愿墙-完成"] == 1 then
        return
    end

    baseUtils.toast("旅团 - 许愿墙 - 开始")

    res = baseUtils.TomatoOCRTap(tomatoOCR, 647, 592, 689, 614, "旅团")
    res = baseUtils.TomatoOCRTap(tomatoOCR, 637, 830, 699, 855, "许愿墙")
    if res == false then
        return
    end
    for i = 1, 15 do
        x, y = findMultiColorInRegionFuzzy(0xbacaed,
            "4|0|0x7da2e2,8|1|0xbfceee,14|1|0xbdcded,34|1|0x7da2e2,31|2|0xabc0ea,31|14|0xb0c3ea,21|14|0xc1cfee,8|14|0x7da2e2,1|14|0xffffff,-14|14|0x7da2e2,14|18|0x7da2e2,28|18|0x7da2e2,23|8|0xffffff,2|8|0xeff2fa",
            80, 0, 0, 720, 1280, { orient = 2 }) -- 捐献按钮
        if x ~= -1 then
            baseUtils.tapSleep(x, y)             -- 点击捐献
            --点击最大
            baseUtils.tapSleep(504, 659)
            baseUtils.tapSleep(504, 718)
            baseUtils.tapSleep(504, 781)
            -- 点击捐赠
            res = baseUtils.TomatoOCRTap(tomatoOCR, 328, 822, 389, 854, "捐赠")
            --res = baseUtils.TomatoOCRTap(tomatoOCR, 97, 1200, 129, 1231, "回") -- 返回许愿墙首页
            baseUtils.tapSleep(365, 1214) -- 点击空白处
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

    baseUtils.toast("旅团 - 浇树 - 开始")

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
                baseUtils.tapSleep(465, 750, 3)
                baseUtils.tapSleep(465, 750, 1)
                baseUtils.tapSleep(355, 1220) -- 点击空白处关闭
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
