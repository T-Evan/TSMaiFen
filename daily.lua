local dailyTask = {}

-- 返回首页
function dailyTask.homePage()
    while 1 do
        res6 = shilianTask.WaitFight()

        -- 判断是否已在首页
        --if (isColor(659, 367, 0xe2e1d1, 90) and isColor(662, 368, 0xe2dfd1, 90) and isColor(668, 368, 0xa1a099, 90) and isColor(664, 370, 0xe2dfd1, 90) and isColor(653, 370, 0xe2dece, 90) and isColor(656, 372, 0xe4e1d4, 90) and isColor(662, 372, 0xe2dfd1, 90) and isColor(674, 372, 0xe2ded1, 90) and isColor(678, 372, 0xe2ded1, 90) and isColor(679, 367, 0x7d9084, 90) and isColor(681, 373, 0xe1dfcf, 90) and isColor(679, 376, 0x797c81, 90) and isColor(676, 378, 0xe2e0d2, 90) and isColor(672, 386, 0xf3eddd, 90) and isColor(675, 386, 0xf3eddd, 90) and isColor(682, 385, 0xf3eddd, 90) and isColor(678, 389, 0xf3eddd, 90) and isColor(678, 392, 0xf3eddd, 90) and isColor(678, 399, 0xf3eddd, 90) and isColor(675, 399, 0xf3eddd, 90)) then
        --    res1 = true -- 冒险手册
        --end
        --if res1 == false then
        res2 = baseUtils.TomatoOCRText(tomatoOCR, 626, 379, 711, 405, "冒险手册")
        if res2 == false then
            res3 = baseUtils.TomatoOCRText(tomatoOCR, 627, 381, 710, 403, "新手试炼")
        end
        --end
        if res2 or res3 then
            --logUtils.log("已返回首页")
            commonVar["needHome"] = 0
            commonVar["fighting"] = 0
            return
        end

        -- 开始异步处理返回首页
        commonVar["needHome"] = 1

        -- 点击首页-冒险
        res = baseUtils.TomatoOCRTap(tomatoOCR, 327, 1205, 389, 1233, "冒险")

        -- 异地登录
        --loginRes = startUp.anotherLogin()
        --if loginRes then
        --    return
        --end

        res7 = dailyTask.quitTeam()
        if res7 == false then
            --判断战败页
            shilianTask.fightFail()
        end
        -- 判断宝箱开启
        shilianTask.openTreasure()

        -- 判断是否已在首页
        baseUtils.mSleep3(500)
    end
end

-- 日常任务聚合
function dailyTask.dailyTask()
    if 功能开关["日常功能开关"] ~= nil and 功能开关["日常功能开关"] == 0 then
        return
    end

    -- 日常相关

    -- 活动

    -- 领取相关
    -- 邮件领取
    dailyTask.youJian()
    -- 招式创造
    dailyTask.zhaoShiChuangZao()
    -- 骑兽乐园
    dailyTask.qiShouLeYuan()

    -- 冒险手册
end

function dailyTask.dailyTaskEnd()
    if 功能开关["日常功能开关"] ~= nil and 功能开关["日常功能开关"] == 0 then
        return
    end

    -- 日常相关

    -- 活动
    -- 摸鱼时间到
    dailyTask.huoDongMoYu()
    -- 火力全开
    dailyTask.huoLiQuanKai()
    -- BBQ派对
    dailyTask.BBQParty()
    -- 宝藏湖
    dailyTask.baoZangHu()
    -- 登录好礼
    dailyTask.dengLuHaoLi()
    -- 限时特惠
    dailyTask.XianShiTeHui()

    -- 前往新地图
    dailyTask.newMap()

    -- 冒险手册
    dailyTask.maoXianShouCe()
end

function dailyTask.dengLuHaoLi()
    if 功能开关["登录好礼"] == 0 then
        return
    end

    baseUtils.toast("日常 - 登录好礼 - 开始", 0.5)

    -- 返回首页
    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRTap(tomatoOCR, 12, 1110, 91, 1135, "旅行活动", 40, -20)
    if res == false then
        return
    end

    x, y = findMultiColorInRegionFuzzy(0xccb580,
        "26|34|0xf8d693,26|42|0xac8b5e,56|31|0xf9d49a,69|26|0xf9d899,80|-2|0xf8e093,81|12|0xf1e0a1,79|27|0xf8d995,72|39|0xf8d495,57|68|0xae6d2b,90|77|0xad6a22,109|69|0xe8decc,108|63|0xeae1cf,121|64|0xeee6d5,126|73|0xdac6b1",
        80, 0, 0, 720, 1280, { orient = 2 }) -- 登录好礼
    if x == -1 then
        return
    end
    baseUtils.tapSleep(x, y)

    x, y = findMultiColorInRegionFuzzy(0xfae4d3,
        "8|0|0xfae4d4,17|0|0xf2a94a,28|0|0xfdf3ec,34|0|0xf8d7bd,48|0|0xf2a94a,51|8|0xf2a94a,43|8|0xf2a94a,33|8|0xf4be89,20|8|0xffffff,-4|8|0xf2a94a,-15|8|0xf2a94a,-18|0|0xf2a94a,-21|-8|0xf1a849,37|12|0xf2a94a",
        80, 0, 0, 720, 1280, { orient = 2 }) -- 领取按钮
    if x ~= -1 then
        baseUtils.tapSleep(x, y)
        baseUtils.tapSleep(355, 1005) -- 点击空白处关闭
        baseUtils.tapSleep(350, 1145) -- 点击空白处关闭
    end
end

-- 邮件领取
function dailyTask.youJian()
    if 功能开关["邮件领取"] ~= nil and 功能开关["邮件领取"] == 0 then
        return
    end

    if 任务记录["邮件领取-完成"] == 1 then
        return
    end

    baseUtils.toast("日常 - 邮件领取 - 开始", 0.5)

    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        -- 返回首页
        dailyTask.homePage()

        res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
        --判断是否在营地页面
        local hd1 = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
        local hd2 = baseUtils.TomatoOCRText(tomatoOCR, 11, 1111, 92, 1134, "旅行活动")
        if hd1 == false and hd2 == false then
            return
        end
    end

    baseUtils.tapSleep(300, 740, 4) -- 邮件
    res = baseUtils.TomatoOCRTap(tomatoOCR, 463, 1030, 510, 1061, "领取")
    if res == false then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 85, 1186, 141, 1222, "返回")
        return
    else
        任务记录["邮件领取-完成"] = 1
    end
    baseUtils.mSleep3(2000)
    baseUtils.tapSleep(120, 1030) -- 点击空白处
    baseUtils.tapSleep(110, 1204) -- 点击返回
    --res = baseUtils.TomatoOCRTap(tomatoOCR, 85, 1186, 141, 1222, "返回")
    --res = baseUtils.TomatoOCRTap(tomatoOCR, 84, 1187, 140, 1219, "返回")
end

-- 骑兽乐园
function dailyTask.qiShouLeYuan()
    if 功能开关["骑兽乐园"] ~= nil and 功能开关["骑兽乐园"] == 0 then
        return
    end

    if 任务记录["日常-骑兽乐园-完成"] == 1 then
        baseUtils.toast("日常 - 骑兽乐园 - 已完成")
        return
    end

    baseUtils.toast("日常 - 骑兽乐园 - 开始", 0.5)

    --判断是否在营地页面
    res1 = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    res2 = baseUtils.TomatoOCRTap(tomatoOCR, 512, 1136, 611, 1162, "骑兽乐园")
    if res == false and res2 == false then
        -- 返回首页
        dailyTask.homePage()

        res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
        --判断是否在营地页面
        local hd1 = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
        local hd2 = baseUtils.TomatoOCRText(tomatoOCR, 11, 1111, 92, 1134, "旅行活动")
        if hd1 == false and hd2 == false then
            return
        end

        baseUtils.tapSleep(200, 545, 4) -- 芙芙小铺
        res2 = baseUtils.TomatoOCRTap(tomatoOCR, 512, 1136, 611, 1162, "骑兽乐园")
    end

    if res2 then
        baseUtils.tapSleep(188, 321, 4) -- 点击门票（固定位置）
        baseUtils.tapSleep(550, 1080)   -- 点击空白处关闭

        -- 兑换门票
        local needCount = tonumber(功能开关["钻石兑换门票次数"])
        if needCount == nil then
            needCount = 0
        end
        if needCount > 0 then
            local count = 0
            while count < 5 do
                res = baseUtils.TomatoOCRTap(tomatoOCR, 570, 261, 645, 285, "兑换门票")
                res, buyCount = baseUtils.TomatoOCRText(tomatoOCR, 377, 944, 389, 959, "已购买次数") -- 1/9
                buyCount = tonumber(buyCount)
                if buyCount == nil or buyCount >= needCount then
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 70, 1202, 122, 1232, "返回") -- 返回芙芙小铺，继续
                    break
                end
                res = baseUtils.TomatoOCRTap(tomatoOCR, 318, 876, 398, 898, "购买道具")
                baseUtils.tapSleep(550, 1080) -- 点击空白处关闭
                count = count + 1
            end
        end
        任务记录["日常-骑兽乐园-完成"] = 1
    end

    -- 骑兽探索
    local needCount = tonumber(功能开关["骑兽乐园-探索次数"])
    if needCount == nil then
        needCount = 0
    end
    if needCount > 0 then
        attempt = 0
        while attempt < needCount do
            res = baseUtils.TomatoOCRTap(tomatoOCR, 204, 917, 245, 940, "探索")
            baseUtils.mSleep3(2000)
            res = baseUtils.TomatoOCRTap(tomatoOCR, 597, 28, 642, 53, "跳过") -- 跳过动画
            baseUtils.mSleep3(2000)
            res = baseUtils.TomatoOCRTap(tomatoOCR, 597, 28, 642, 53, "跳过") -- 跳过动画
            baseUtils.tapSleep(90, 980, 3) -- 点击空白处
            baseUtils.tapSleep(90, 980) -- 点击空白处
            attempt = attempt + 1
        end
    end
end

-- 招式创造
function dailyTask.zhaoShiChuangZao()
    if 功能开关["招式创造"] ~= nil and 功能开关["招式创造"] == 0 then
        return
    end

    if 任务记录["日常-招式创造-完成"] == 1 then
        baseUtils.toast("日常 - 招式创造 - 已完成")
        return
    end

    baseUtils.toast("日常 - 招式创造 - 开始", 0.5)

    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        -- 返回首页
        dailyTask.homePage()

        res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
        --判断是否在营地页面
        local hd1 = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
        local hd2 = baseUtils.TomatoOCRText(tomatoOCR, 11, 1111, 92, 1134, "旅行活动")
        if hd1 == false and hd2 == false then
            return
        end
    end

    baseUtils.tapSleep(200, 545, 4) -- 芙芙小铺
    res = baseUtils.TomatoOCRTap(tomatoOCR, 389, 1133, 489, 1163, "招式创造")
    if res then
        x, y = findMultiColorInRegionFuzzy(0x9297bb,
            "-1|2|0xd6cce0,-3|3|0xdebfec,-3|8|0xf5fcf1,16|11|0x71829f,24|11|0x455d81,30|11|0x243b59,30|17|0x425a78,27|15|0x8c8763,20|18|0xa1bec7,19|25|0xf9f1d6,19|30|0xf0c5c0,19|32|0xe6dee1,31|32|0x93a685",
            80, 0, 0, 720, 1280, { orient = 2 })
        if x ~= -1 then
            baseUtils.tapSleep(x, y, 5)
            baseUtils.tapSleep(185, 1024) -- 点击空白处关闭
            任务记录["日常-招式创造-完成"] = 1
        end
    end

    -- 兑换卢恩
    local needCount = tonumber(功能开关["钻石兑换卢恩次数"])
    if needCount == nil then
        needCount = 0
    end
    if needCount > 0 then
        local count = 0
        while count < 5 do
            res = baseUtils.TomatoOCRTap(tomatoOCR, 568, 260, 645, 285, "兑换卢恩")
            res, buyCount = baseUtils.TomatoOCRText(tomatoOCR, 375, 944, 387, 960, "已购买次数") -- 1/9
            buyCount = tonumber(buyCount)
            if buyCount == nil or buyCount >= needCount then
                res = baseUtils.TomatoOCRTap(tomatoOCR, 70, 1202, 122, 1232, "返回") -- 返回芙芙小铺，继续
                break
            end
            res = baseUtils.TomatoOCRTap(tomatoOCR, 318, 876, 398, 898, "购买道具")
            if res then
                baseUtils.tapSleep(185, 1024) -- 点击空白处关闭
                任务记录["日常-招式创造-完成"] = 1
            end
            count = count + 1
        end
    end

    -- 讲述故事
    local needCount = tonumber(功能开关["招式创造-讲述次数"])
    if needCount == nil then
        needCount = 0
    end
    if needCount > 0 then
        attempt = 0
        while attempt < needCount do
            res = baseUtils.TomatoOCRTap(tomatoOCR, 319, 1062, 398, 1083, "自动讲述")
            baseUtils.mSleep3(2000)
            res = baseUtils.TomatoOCRTap(tomatoOCR, 359, 969, 399, 992, "收取") -- 一键收取
            baseUtils.tapSleep(170, 1090) -- 点击空白处
            attempt = attempt + 1
        end
    end

    --res = baseUtils.TomatoOCRTap(tomatoOCR, 69, 1198, 124, 1234, "返回") -- 返回营地
    --res = baseUtils.TomatoOCRText(tomatoOCR, 468, 625, 504, 645, "收取") -- 返回营地时，一键收取提示
    --if res then
    --    res = baseUtils.TomatoOCRTap(tomatoOCR, 454, 728, 509, 758, "确定") -- 返回营地时，一键收取提示
    --end
end

-- 宝藏湖
function dailyTask.baoZangHu()
    if 功能开关["宝藏湖"] ~= nil and 功能开关["宝藏湖"] == 0 then
        return
    end

    baseUtils.toast("日常 - 宝藏湖 - 开始", 0.5)

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 20, 937, 84, 960, "宝藏湖")
    if res == false then
        return
    end

    --res, cili = baseUtils.TomatoOCRText(tomatoOCR, 612, 82, 658, 102, "可用磁力")
    --dialog(cili)
    --cili = tonumber(cili)
    --if cili ~= nil and cili >= 50 then -- 磁力＞50时，可进行大容量充磁
    res = baseUtils.TomatoOCRTap(tomatoOCR, 395, 1076, 496, 1100, "大容量充磁")
    baseUtils.mSleep3(8000)       --等待动画
    baseUtils.tapSleep(360, 1040) -- 点击空白处
    baseUtils.tapSleep(360, 1040) -- 点击空白处

    baseUtils.tapSleep(75, 325)   -- 领取回收物进度奖励
    baseUtils.tapSleep(76, 335)   -- 领取回收物进度奖励
    baseUtils.tapSleep(360, 1040) -- 点击空白处
    --end


    res = baseUtils.TomatoOCRTap(tomatoOCR, 554, 1239, 636, 1265, "伊尼兰特")
    if res then
        --res, cili = baseUtils.TomatoOCRText(tomatoOCR, 612, 82, 658, 102, "可用磁力")
        --cili = tonumber(cili)
        --if cili ~= nil and cili >= 0 then -- 磁力＞0时，可进行高压充磁
        res = baseUtils.TomatoOCRTap(tomatoOCR, 321, 1073, 402, 1096, "高压充磁", 10, 10)
        baseUtils.mSleep3(8000)       --等待动画
        baseUtils.tapSleep(360, 1040) -- 点击空白处
        baseUtils.tapSleep(360, 1040) -- 点击空白处
        --end
    end
end

-- 限时特惠
function dailyTask.XianShiTeHui()
    if 功能开关["限时特惠"] ~= nil and 功能开关["限时特惠"] == 0 then
        return
    end

    baseUtils.toast("日常 - 限时特惠 - 开始", 0.5)

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 96, 1024, 176, 1046, "限时特惠") -- 进入BBQ派对
    if res == false then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 96, 938, 178, 960, "限时特惠") -- 进入BBQ派对
        if res == false then
            return
        end
    end

    baseUtils.tapSleep(595, 150)  -- 点击特惠宝箱
    baseUtils.tapSleep(350, 1125) -- 点击空白处
end

-- BBQ派对
function dailyTask.BBQParty()
    if 功能开关["BBQ派对"] ~= nil and 功能开关["BBQ派对"] == 0 then
        return
    end

    baseUtils.toast("日常 - BBQ派对 - 开始", 0.5)

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 96, 1024, 176, 1046, "BBQ派对") -- 进入BBQ派对
    if res == false then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 96, 938, 178, 960, "BBQ派对") -- 进入BBQ派对
        if res == false then
            return
        end
    end

    while true do
        res, availableCount = baseUtils.TomatoOCRText(tomatoOCR, 615, 81, 653, 102, "烤刷数量") -- 1/9
        availableCount = tonumber(availableCount)
        if availableCount == nil or availableCount == 0 then
            res = baseUtils.TomatoOCRText(tomatoOCR, 96, 1200, 129, 1232, "回") -- 返回
            break
        end

        res = baseUtils.TomatoOCRTap(tomatoOCR, 433, 1093, 533, 11236, "连续烧烤")
        baseUtils.mSleep3(5000)
        baseUtils.tapSleep(360, 1220) -- 点击空白处
    end
end

-- 火力全开
function dailyTask.huoLiQuanKai()
    if 功能开关["火力全开"] ~= nil and 功能开关["火力全开"] == 0 then
        return
    end

    baseUtils.toast("日常 - 火力全开 - 开始", 0.5)

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 98, 1022, 177, 1048, "火力全开") -- 进入火力全开
    if res == false then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 96, 938, 178, 960, "火力全开") -- 进入火力全开
        if res == false then
            return
        end
    end
    x, y = findMultiColorInRegionFuzzy(0xf4593e,
        "0|6|0xf45f42,0|3|0xf76143,-2|3|0xf96244,-2|6|0xf45e42,-1|8|0xef5c40,0|9|0xed5b40,4|7|0xf25d42,4|4|0xfa6243,1|7|0xf15e41,0|6|0xf45f42",
        80, 77, 871, 649, 1044, { orient = 2 })
    if x ~= -1 then
        baseUtils.tapSleep(x, y)  -- 领取次数累计奖励
    end
    baseUtils.tapSleep(480, 1100) -- 点击空白处
end

-- 冒险手册
function dailyTask.maoXianShouCe()
    if 功能开关["冒险手册领取"] ~= nil and 功能开关["冒险手册领取"] == 0 then
        return
    end

    baseUtils.toast("日常 - 冒险手册领取 - 开始", 0.5)

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 626, 379, 711, 405, "冒险手册", 30, -20)
    if res == false then
        --baseUtils.toast("识别冒险手册失败")
        return
    end

    --主线领取
    res = baseUtils.TomatoOCRTap(tomatoOCR, 156, 1101, 206, 1129, "主线")
    while 1 do
        x, y = findMultiColorInRegionFuzzy(0xf3a84b,
            "15|0|0xf3a84b,34|0|0xf3a84b,48|0|0xf3a84b,56|0|0xf3a84b,65|0|0xf3a84b,65|8|0xf3a84b,65|15|0xf3a84b,45|24|0xf3a84b,25|24|0xf3a84b,3|24|0xf3a84b,30|15|0xf3a84b,38|15|0xf4b36f,59|12|0xf3a84b,77|14|0xf3a84b",
            80, 0, 0, 720, 1280, { orient = 2 }) -- 识别黄色领取按钮
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            baseUtils.tapSleep(320, 1180) -- 点击空白处关闭
        else
            break
        end
    end

    -- 日常领取
    res = baseUtils.TomatoOCRTap(tomatoOCR, 274, 1102, 326, 1130, "每日")
    if res then
        x, y = findMultiColorInRegionFuzzy(0xfffefe,
            "6|0|0xfdf6f0,13|0|0xfadfcb,22|0|0xfffffe,32|0|0xfefaf7,39|0|0xf6c091,39|7|0xf3a84b,36|7|0xffffff,25|7|0xfceade,16|7|0xffffff,7|7|0xfceee5,-1|7|0xf9dbc5,0|12|0xf5bb85,11|12|0xfbe7d9,16|12|0xfcede2,22|11|0xffffff,32|11|0xfefaf7",
            90, 0, 0, 720, 1280, { orient = 2 }) -- 识别黄色领取按钮
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            baseUtils.tapSleep(357, 1224) -- 点击空白处关闭

            -- 点击宝箱（从右到左）
            baseUtils.tapSleep(570, 390)
            baseUtils.tapSleep(490, 390)
            baseUtils.tapSleep(410, 390)
            baseUtils.tapSleep(330, 390)
            baseUtils.tapSleep(250, 390)
        end
    end

    -- 每周领取
    res = baseUtils.TomatoOCRTap(tomatoOCR, 394, 1099, 448, 1132, "每周")
    if res then
        x, y = findMultiColorInRegionFuzzy(0xfffefe,
            "6|0|0xfdf6f0,13|0|0xfadfcb,22|0|0xfffffe,32|0|0xfefaf7,39|0|0xf6c091,39|7|0xf3a84b,36|7|0xffffff,25|7|0xfceade,16|7|0xffffff,7|7|0xfceee5,-1|7|0xf9dbc5,0|12|0xf5bb85,11|12|0xfbe7d9,16|12|0xfcede2,22|11|0xffffff,32|11|0xfefaf7",
            90, 0, 0, 720, 1280, { orient = 2 }) -- 识别黄色领取按钮
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            baseUtils.tapSleep(357, 1224) -- 点击空白处关闭

            -- 点击宝箱（从右到左）
            baseUtils.tapSleep(570, 390)
            baseUtils.tapSleep(490, 390)
            baseUtils.tapSleep(410, 390)
            baseUtils.tapSleep(330, 390)
            baseUtils.tapSleep(250, 390)
        end
    end

    -- 成就领取
    res = baseUtils.TomatoOCRTap(tomatoOCR, 514, 1099, 570, 1132, "成就")
    while 1 do
        x, y = findMultiColorInRegionFuzzy(0xfefbf8,
            "21|0|0xf4b574,32|0|0xf3a84b,32|7|0xf3a84b,25|7|0xfffefd,14|7|0xffffff,9|7|0xf3a950,-4|7|0xf8d4b7,-12|7|0xf3a84b,-12|20|0xf3a84b,-2|19|0xf3a84b,8|19|0xf3a84b,22|19|0xf3a84b",
            90, 0, 0, 720, 1280, { orient = 2 }) -- 识别黄色领取按钮
        if x ~= -1 then
            baseUtils.tapSleep(x, y, 3)
            baseUtils.tapSleep(360, 1070) -- 点击空白处关闭
            baseUtils.tapSleep(360, 1070) -- 点击空白处关闭（再次点击，避免成就升级页）
        else
            break
        end
    end
end

-- 新关卡挑战
function dailyTask.newMap()
    if 功能开关["自动挑战首领"] ~= nil and 功能开关["自动挑战首领"] == 1 then
        baseUtils.toast("日常 - 挑战首领 - 开始")
        dailyTask.homePage()
        res = baseUtils.TomatoOCRTap(tomatoOCR, 633, 766, 694, 788, "挑战首领")
        if res then
            baseUtils.mSleep3(10 * 1000) -- 等待动画
        end
    end

    if 功能开关["自动换图"] ~= nil and 功能开关["自动换图"] == 1 then
        baseUtils.toast("日常 - 切换地图 - 开始")
        dailyTask.homePage()
        res1 = baseUtils.TomatoOCRText(tomatoOCR, 589, 215, 680, 230, "新关卡已解锁")
        res2 = baseUtils.TomatoOCRText(tomatoOCR, 589, 215, 680, 230, "新地图已解锁")
        if res1 or res2 then
            --if true then
            -- 地图入口切换

            -- 结伴入口切换
            res = baseUtils.TomatoOCRTap(tomatoOCR, 647, 450, 689, 474, "结伴")
            res = baseUtils.TomatoOCRTap(tomatoOCR, 373, 1106, 471, 1141, "关卡大厅")

            local totalCount = 5
            local count = 0
            while count < totalCount do
                -- 第1图红标
                x, y = findMultiColorInRegionFuzzy(0xfe6554,
                    "1|-4|0xfc684c,4|-3|0xfd694d,4|-5|0xfc684c,4|-10|0xfc684c,4|-13|0xfe7760,3|-18|0xfecac1,5|-20|0xfc6c4d,11|-20|0xfdfaf6,13|-20|0xfdfaf6,13|-19|0xfff9f9,12|-19|0xfff9f9,12|-12|0xfd664a,21|-13|0xfc694c,19|-24|0xfedcd5,14|-26|0xfd5e45,14|-27|0xffb1a8,14|-21|0xfdf9f5",
                    80, 0, 0, 720, 1280, { orient = 2 })
                -- 第2图红标
                if x == -1 then
                    x, y = findMultiColorInRegionFuzzy(0xff664b,
                        "-2|-5|0xfb694c,7|-5|0xff664e,5|-6|0xfff9f9,2|-8|0xfff5ef,5|-8|0xfdf5f0,4|-12|0xfff8f7,12|-14|0xfc694c,12|-18|0xfc694c,15|-8|0xfc694c,15|3|0xfe6a4a,14|4|0xfc694c,4|1|0xfd664a",
                        80, 0, 0, 720, 1280, { orient = 2 })
                end

                if x ~= -1 then
                    --当前地图（不在下方第1个，就是右边紧挨着；只需判断两次）
                    if x > 400 then
                        baseUtils.tapSleep(x - 250, y + 220) -- 下行第1个
                    else
                        baseUtils.tapSleep(x + 230, y + 0)   -- 右侧第1个
                        res = baseUtils.TomatoOCRText(tomatoOCR, 321, 1022, 394, 1044, "前往地图")
                    end

                    --切换地图
                    res = baseUtils.TomatoOCRText(tomatoOCR, 321, 1022, 394, 1044, "前往地图")
                    if res == false then
                        baseUtils.tapSleep(x + 0, y + 165)      -- 切换下一地图
                        if x < 280 then
                            baseUtils.tapSleep(x + 50, y + 250) -- 最后一关在第一个位置，换地图后下方第1图）
                        end

                        if x > 280 and x < 400 then
                            baseUtils.tapSleep(x - 100, y + 250) -- 下行第1个（最后一关在第二个位置，换地图后下方第1图）
                        end

                        if x > 400 then
                            baseUtils.tapSleep(x - 250, y + 220) -- 最后一关在第三个位置，换地图后下行第1个
                        end
                    end

                    res = baseUtils.TomatoOCRTap(tomatoOCR, 321, 1022, 394, 1044, "前往地图")
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 330, 1027, 389, 1058, "前往")

                    res = baseUtils.TomatoOCRText(tomatoOCR, 422, 622, 494, 646, "单人前往")
                    if res then
                        if 功能开关["队员不满足单飞"] == 1 then
                            res = baseUtils.TomatoOCRTap(tomatoOCR, 187, 727, 284, 757, "离队前往")
                        else
                            res = baseUtils.TomatoOCRTap(tomatoOCR, 435, 727, 529, 759, "留在队伍")
                        end
                        break
                    end
                else
                    moveTo(500, 800, 500, 300, 30, 50, 1, 1)
                    baseUtils.mSleep3(4000);
                end
                count = count + 1
            end
        end
    end

    if 功能开关["单飞后寻找结伴"] ~= nil and 功能开关["单飞后寻找结伴"] == 1 then
        baseUtils.toast("日常 - 寻找结伴 - 开始")
        dailyTask.homePage()
        res = baseUtils.TomatoOCRTap(tomatoOCR, 646, 451, 689, 474, "结伴", 10, -10)
        if res then
            x, y = findMultiColorInRegionFuzzy(0x0dccf6,
                "6|0|0x00c7ff,18|0|0xd3e5d1,25|0|0xc0dabd,37|0|0x79bb70,45|0|0x4eae3b,53|0|0xcee2cc,62|0|0x4eae3b,72|0|0xedf4ec,72|7|0xc8dec5,60|7|0xa3cc9f,52|7|0xbad7b7,45|7|0x4eae3b,7|8|0xecd649,1|6|0xead669,-7|4|0x78a644,4|6|0xdcde6c,13|5|0x4eae3b",
                80, 0, 0, 720, 1280, { orient = 2 }) -- 组队增益图标高亮 - 已在队伍中
            if x ~= -1 then
                baseUtils.toast("日常 - 寻找结伴 - 已有结伴")
            else
                res = baseUtils.TomatoOCRTap(tomatoOCR, 408, 1037, 509, 1068, "寻找队伍")
                x, y = findMultiColorInRegionFuzzy(0x7da2e2,
                    "28|0|0xb2c4eb,37|0|0xcdd8f1,49|0|0x7da2e2,65|0|0x7da2e2,65|10|0x7da2e2,39|10|0xedf1fa,32|10|0xa1b9e8,25|10|0xe5eaf8,22|10|0xecf0f9,15|10|0x7da2e2,4|9|0x7da2e2,-2|9|0x7da2e2,7|17|0x7da2e2,27|17|0x7da2e2",
                    80, 0, 0, 720, 1280, { orient = 2 }) -- 加入按钮
                if x ~= -1 then
                    baseUtils.tapSleep(x, y)
                    baseUtils.toast("日常 - 寻找结伴 - 加入队伍")
                    baseUtils.mSleep3(4 * 1000) -- 等待动画
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 359, 741, 391, 775, "确认跟随")
                end
            end
        end
    end
end

-- 活动 - 摸鱼
function dailyTask.huoDongMoYu()
    if 功能开关["摸鱼时间到"] ~= nil and 功能开关["摸鱼时间到"] == 0 then
        return
    end

    baseUtils.toast("日常 - 摸鱼时间到 - 开始")

    local totalCount = 3
    local count = 0
    while count < totalCount do
        count = count + 1
        dailyTask.homePage()

        res = baseUtils.TomatoOCRTap(tomatoOCR, 566, 379, 609, 404, "摸鱼")
        if res == false then
            return
        end
        res = baseUtils.TomatoOCRTap(tomatoOCR, 325, 1095, 427, 1128, "开始匹配")
        res = baseUtils.TomatoOCRTap(tomatoOCR, 451, 603, 505, 635, "准备")
        local attempts = 0    -- 初始化尝试次数
        local maxAttempts = 3 -- 设置最大尝试次数

        while attempts < maxAttempts do
            resStart = baseUtils.TomatoOCRTap(tomatoOCR, 451, 603, 505, 635, "准备")
            res = baseUtils.TomatoOCRTap(tomatoOCR, 325, 1095, 427, 1128, "开始匹配")
            if resStart then
                logUtils.log("匹配成功 - 已准备")
                baseUtils.mSleep3(15 * 1000) -- 等待进入
                break
            else
                logUtils.log("匹配中")
            end
            attempts = attempts + 1
            baseUtils.mSleep3(5 * 1000) -- 可以根据需要添加适当的延迟
        end

        if resStart then
            local attempts = 0     -- 初始化尝试次数
            local maxAttempts = 30 -- 设置最大尝试次数
            while attempts < maxAttempts do
                res = baseUtils.TomatoOCRText(tomatoOCR, 19, 1104, 94, 1128, "点击输入")
                if res then
                    logUtils.log("摸鱼中")
                else
                    baseUtils.mSleep3(5 * 1000) -- 摸鱼结束，等待结算页
                    break
                end
                attempts = attempts + 1
                baseUtils.mSleep3(5 * 1000) -- 可以根据需要添加适当的延迟
            end
        end

        res = baseUtils.TomatoOCRTap(tomatoOCR, 313, 1105, 411, 1136, "领取奖励")
        baseUtils.tapSleep(360, 1100, 1) -- 点击空白处关闭
        baseUtils.mSleep3(2000)
        baseUtils.tapSleep(365, 1245, 1) -- 点击空白处关闭
    end
end

-- 首页退出组队
function dailyTask.quitTeam()
    local res1 = false
    local res2 = false
    local res3 = false
    local res4 = false
    res1 = baseUtils.TomatoOCRTap(tomatoOCR, 635, 628, 705, 653, "正在组队")
    if res1 == false then
        res2 = baseUtils.TomatoOCRTap(tomatoOCR, 631, 558, 699, 581, "正在组队")
        if res2 == false then
            res3 = baseUtils.TomatoOCRTap(tomatoOCR, 632, 570, 684, 598, "匹配中")
            if res3 == false then
                res4 = baseUtils.TomatoOCRTap(tomatoOCR, 311, 1156, 407, 1182, "匹配中") -- 大暴走匹配中
            end
        end
    end

    if res1 or res2 or res3 or res4 then
        -- 超时取消匹配
        x, y = findMultiColorInRegionFuzzy(0xfffefd,
            "7|0|0xf9dcc7,15|0|0xf6c69d,40|0|0xf5bd89,52|-1|0xfffefd,53|7|0xffffff,47|7|0xfadfcc,39|7|0xf3a84d,32|7|0xfcf0e7,27|7|0xffffff,23|7|0xfefcfa,5|7|0xfffefe,6|14|0xffffff,23|14|0xfef9f6,38|14|0xffffff",
            75, 0, 0, 720, 1280, { orient = 2 }) -- 匹配中
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            baseUtils.toast("取消匹配")
            return true
        end
        if x == -1 then
            x2, y2 = findMultiColorInRegionFuzzy(0xf3a84b,
                "14|0|0xf3aa55,47|-1|0xfffdfc,67|-1|0xfae1cf,85|-1|0xf3a84b,98|-1|0xf3a84b,105|-1|0xf3a84b,92|13|0xf3a84b,86|13|0xf3a84b,77|13|0xf3a84b,56|10|0xffffff,17|10|0xffffff,17|21|0xf3a84b,-3|19|0xf3a84b,-8|11|0xf3a94d",
                75, 0, 0, 720, 1280, { orient = 2 }) -- 匹配中
            if x2 ~= -1 then
                baseUtils.tapSleep(x, y)
                baseUtils.toast("取消匹配")
                return true
            end
        end
        if x == -1 and x2 == -1 then
            x3, y3 = findMultiColorInRegionFuzzy(0xf3a84b,
                "13|0|0xf3a84b,24|0|0xffffff,36|0|0xf3a84b,53|0|0xf3a84b,64|0|0xfffffe,67|0|0xfef7f2,78|0|0xfef9f6,95|0|0xf3a84b,112|0|0xf3a84b,110|10|0xf9c078,101|10|0xf3a84b,90|10|0xf3a84b,68|10|0xf3a84b,57|10|0xfdf3ec,39|10|0xf6c295",
                80, 0, 0, 720, 1280, { orient = 2 })
            if x3 ~= -1 then
                baseUtils.tapSleep(x, y)
                baseUtils.toast("取消匹配")
                return true
            end
        end
        res4 = baseUtils.TomatoOCRTap(tomatoOCR, 311, 1156, 407, 1182, "匹配中") -- 大暴走匹配中
        if res4 then
            baseUtils.toast("取消匹配")
            return true
        end

        res = baseUtils.TomatoOCRTap(tomatoOCR, 501, 191, 581, 217, "离开队伍")
        if res == false then
            baseUtils.tapSleep(540, 200, 0.8)
        end
        res = baseUtils.TomatoOCRTap(tomatoOCR, 329, 726, 391, 761, "确定")
        if res == false then
            baseUtils.tapSleep(360, 740, 0.8)
        end
        if res then
            baseUtils.toast("退出组队", 0.5)
            return true
        end
    end
    return false
end

return dailyTask
