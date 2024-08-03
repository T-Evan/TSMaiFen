local dailyTask = {}

-- 返回首页
function dailyTask.homePage()
    -- 判断是否已在首页
    res = baseUtils.TomatoOCRText(tomatoOCR, 626, 379, 711, 405, "冒险手册")
    if res then
        logUtils.log("已返回首页")
        return
    end

    -- 判断返回按钮
    shilianTask.openTreasure()
    res1 = baseUtils.TomatoOCRTap(tomatoOCR, 67, 1187, 120, 1218, "返回")
    res2 = baseUtils.TomatoOCRTap(tomatoOCR, 70, 1200, 123, 1231, "返回")
    res3 = baseUtils.TomatoOCRTap(tomatoOCR, 171, 1189, 200, 1216, "回")
    res4 = baseUtils.TomatoOCRTap(tomatoOCR, 98, 1202, 128, 1231, "回")
    res5 = baseUtils.TomatoOCRTap(tomatoOCR, 93, 1186, 127, 1217, "回")
    --res6 = baseUtils.TomatoOCRTap(tomatoOCR, 213, 604, 266, 635, "拒绝") -- 避免错误时机匹配成功（存在多次拒绝导致的匹配惩罚）
    res6 = shilianTask.WaitFight()
    res7 = dailyTask.quitTeam()
    if res1 == false and res2 == false and res3 == false and res4 == false and res5 == false and res6 == false and res7 == false then
        res1 = baseUtils.TomatoOCRTap(tomatoOCR, 289, 1067, 430, 1094, "点击空白处关闭")
        res2 = baseUtils.TomatoOCRTap(tomatoOCR, 279, 1079, 440, 1099, "点击空白处可领取奖励", 30, 100)
        res3 = baseUtils.TomatoOCRTap(tomatoOCR, 266, 863, 453, 890, "点击空白处可领取奖励", 30, 100)
        res4 = baseUtils.TomatoOCRTap(tomatoOCR, 296, 1207, 424, 1232, "点击空白处关闭", 30, 100)

        if res1 == false and res2 == false and res3 == false and res4 == false then
            -- 判断战败页
            shilianTask.fightFail()
        end
    end

    -- 点击首页-冒险
    res = baseUtils.TomatoOCRTap(tomatoOCR, 327, 1205, 389, 1233, "冒险")

    -- 判断是否已在首页
    return dailyTask.homePage()
end

-- 日常任务聚合
function dailyTask.dailyTask()
    if 功能开关["日常功能开关"] ~= nil and 功能开关["日常功能开关"] == 0 then
        return
    end

    -- 日常相关
    -- 前往新地图
    dailyTask.newMap()

    -- 活动
    -- 摸鱼时间到
    dailyTask.huoDongMoYu()
    -- 火力全开
    dailyTask.huoLiQuanKai()
    -- 宝藏湖
    dailyTask.baoZangHu()

    -- 领取相关
    -- 邮件领取
    dailyTask.youJian()
    -- 招式创造
    dailyTask.zhaoShiChuangZao()
    -- 骑兽乐园
    dailyTask.qiShouLeYuan()

    -- 冒险手册
    dailyTask.maoXianShouCe()
end

-- 邮件领取
function dailyTask.youJian()
    if 功能开关["邮件领取"] ~= nil and 功能开关["邮件领取"] == 0 then
        return
    end

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    baseUtils.tapSleep(300, 740, 4) -- 邮件
    res = baseUtils.TomatoOCRTap(tomatoOCR, 463, 1030, 510, 1061, "领取")
    baseUtils.tapSleep(350, 1170)   -- 点击空白处
end

-- 骑兽乐园
function dailyTask.qiShouLeYuan()
    if 功能开关["骑兽乐园"] ~= nil and 功能开关["骑兽乐园"] == 0 then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        dailyTask.homePage()

        res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
        --判断是否在营地页面
        res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
        if res == false then
            return
        end
    end

    baseUtils.tapSleep(200, 545, 4) -- 芙芙小铺
    res = baseUtils.TomatoOCRTap(tomatoOCR, 512, 1136, 611, 1162, "骑兽乐园")
    if res then
        baseUtils.tapSleep(188, 321, 5) -- 点击门票（固定位置）
        baseUtils.tapSleep(350, 540)    -- 点击空白处关闭

        -- 兑换门票
        local needCount = tonumber(功能开关["钻石兑换门票次数"])
        if needCount == nil then
            needCount = 0
        end
        if needCount > 0 then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 570, 261, 645, 285, "兑换门票")
            local count = 0
            while count < 5 do
                res, buyCount = baseUtils.TomatoOCRText(tomatoOCR, 377, 944, 389, 959, "已购买次数") -- 1/9
                buyCount = tonumber(buyCount)
                if buyCount == nil or buyCount >= needCount then
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 70, 1202, 122, 1232, "返回") -- 返回芙芙小铺，继续
                    break
                end
                res = baseUtils.TomatoOCRTap(tomatoOCR, 318, 876, 398, 898, "购买道具")
                count = count + 1
            end
        end
    end
end

-- 招式创造
function dailyTask.zhaoShiChuangZao()
    if 功能开关["招式创造"] ~= nil and 功能开关["招式创造"] == 0 then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        dailyTask.homePage()

        res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
        --判断是否在营地页面
        res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
        if res == false then
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
            baseUtils.tapSleep(190, 565) -- 点击空白处关闭
        end
    end

    -- 兑换卢恩
    local needCount = tonumber(功能开关["钻石兑换卢恩次数"])
    if needCount == nil then
        needCount = 0
    end
    if needCount > 0 then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 568, 260, 645, 285, "兑换卢恩")
        local count = 0
        while count < 5 do
            res, buyCount = baseUtils.TomatoOCRText(tomatoOCR, 375, 944, 387, 960, "已购买次数") -- 1/9
            buyCount = tonumber(buyCount)
            if buyCount == nil or buyCount >= needCount then
                res = baseUtils.TomatoOCRTap(tomatoOCR, 70, 1202, 122, 1232, "返回") -- 返回芙芙小铺，继续
                break
            end
            res = baseUtils.TomatoOCRTap(tomatoOCR, 318, 876, 398, 898, "购买道具")
            count = count + 1
        end
    end
end

-- 宝藏湖
function dailyTask.baoZangHu()
    if 功能开关["宝藏湖"] ~= nil and 功能开关["宝藏湖"] == 0 then
        return
    end

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 20, 937, 84, 960, "宝藏湖")

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

-- 火力全开
function dailyTask.huoLiQuanKai()
    if 功能开关["火力全开"] ~= nil and 功能开关["火力全开"] == 0 then
        return
    end

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 98, 1022, 177, 1048, "火力全开") -- 进入火力全开
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

    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 626, 379, 711, 405, "冒险手册", 30, -20)
    if res == false then
        baseUtils.log("识别冒险手册失败")
        return
    end

    --主线领取
    res = baseUtils.TomatoOCRTap(tomatoOCR, 156, 1101, 206, 1129, "主线")
    while 1 do
        x, y = findMultiColorInRegionFuzzy(0xfffefe,
            "6|0|0xfdf6f0,13|0|0xfadfcb,22|0|0xfffffe,32|0|0xfefaf7,39|0|0xf6c091,39|7|0xf3a84b,36|7|0xffffff,25|7|0xfceade,16|7|0xffffff,7|7|0xfceee5,-1|7|0xf9dbc5,0|12|0xf5bb85,11|12|0xfbe7d9,16|12|0xfcede2,22|11|0xffffff,32|11|0xfefaf7",
            90, 0, 0, 720, 1280, { orient = 2 }) -- 识别黄色领取按钮
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            baseUtils.tapSleep(360, 1100) -- 点击空白处关闭
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
            baseUtils.tapSleep(357, 1224) -- 点击空白处关闭
        else
            break
        end
    end
end

-- 新关卡挑战
function dailyTask.newMap()
    dailyTask.homePage()

    if 功能开关["自动挑战首领"] ~= nil and 功能开关["自动挑战首领"] == 1 then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 633, 766, 694, 788, "挑战首领")
        if res then
            baseUtils.mSleep3(10 * 1000) -- 等待动画
        end
    end

    if 功能开关["自动换图"] ~= nil and 功能开关["自动换图"] == 1 then
        res1 = baseUtils.TomatoOCRText(tomatoOCR, 589, 215, 680, 230, "新关卡已解锁")
        res2 = baseUtils.TomatoOCRText(tomatoOCR, 589, 215, 680, 230, "新地图已解锁")
        if res1 or res2 then
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
                    baseUtils.tapSleep(x + 0, y + 145)       -- 切换下一地图
                    if x > 400 then
                        baseUtils.tapSleep(x - 250, y + 220) -- 下行第1个
                    else
                        baseUtils.tapSleep(x + 230, y + 0)   -- 右侧第1个
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
                    end
                    break
                else
                    moveTo(500, 700, 500, 200, 80)
                    baseUtils.mSleep3(3500);
                end
                count = count + 1
            end
        end
    end
end

-- 活动 - 摸鱼
function dailyTask.huoDongMoYu()
    if 功能开关["摸鱼时间到"] ~= nil and 功能开关["摸鱼时间到"] == 0 then
        return
    end

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
    res1 = baseUtils.TomatoOCRTap(tomatoOCR, 635, 628, 705, 653, "正在组队")
    res2 = baseUtils.TomatoOCRTap(tomatoOCR, 631, 558, 699, 581, "正在组队")
    res3 = baseUtils.TomatoOCRTap(tomatoOCR, 632, 570, 684, 598, "匹配中")
    if res or res2 then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 501, 191, 581, 217, "离开队伍")
        res = baseUtils.TomatoOCRTap(tomatoOCR, 329, 726, 391, 761, "确定")
        return true
    end
    if res3 then
        -- 超时取消匹配
        res = baseUtils.TomatoOCRTap(tomatoOCR, 320, 692, 392, 716, "匹配中") -- 图1
        if res == false then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 323, 886, 394, 910, "匹配中") -- 图2
        end
        if res == false then
            res4 = baseUtils.TomatoOCRTap(tomatoOCR, 324, 1080, 392, 1103, "匹配中") -- 图3
        end
        return true
    end
    return false
end

return dailyTask
