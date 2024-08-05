local yingdiTask = {}

-- 营地任务聚合
function yingdiTask.yingdiTask()
    if 功能开关["营地功能开关"] == 0 then
        return
    end

    -- 每日商店
    yingdiTask.yingDiShop()

    -- 秘宝
    yingdiTask.yingDiMiBao()

    -- 露营打卡点
    yingdiTask.luYingDaKa()

    -- 月签到
    yingdiTask.yueqiandao()

    -- 日礼包
    yingdiTask.riLiBao()

    -- 月卡
    yingdiTask.yueKa()
end

function yingdiTask.yingdiTaskEnd()
    if 功能开关["营地功能开关"] == 0 then
        return
    end

    -- 纸翼大作战
    yingdiTask.zhiFeiJi()

    -- 星辰同行
    yingdiTask.xingChenTongXing()
end

-- 月卡
function yingdiTask.yueKa()
    if 功能开关["月卡"] == 0 then
        return
    end

    -- 返回首页
    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRTap(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 393, 1202, 439, 1229, "月卡")
    if res == true then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 333, 1054, 385, 1086, "领取")
        if res then
            baseUtils.tapSleep(60, 1135) -- 点击空白处关闭
        end
        -- 支付页兜底
        baseUtils.tapSleep(665, 142)
    end
    res = baseUtils.TomatoOCRTap(tomatoOCR, 91, 1184, 126, 1222, "回") -- 返回
end

-- 日礼包
function yingdiTask.riLiBao()
    if 功能开关["日礼包"] == 0 then
        return
    end

    -- 返回首页
    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRTap(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 286, 1202, 340, 1229, "礼包")
    if res == true then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 148, 671, 198, 700, "免费")
        if res then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 335, 694, 380, 719, "购买")
            if res then
                baseUtils.tapSleep(345, 1058) -- 点击空白处关闭
            end
        end
    end
end

-- 星辰同行
function yingdiTask.xingChenTongXing()
    if 功能开关["星辰同行"] == 0 then
        return
    end

    -- 返回首页
    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    res = baseUtils.TomatoOCRTap(tomatoOCR, 500, 1201, 545, 1228, "同行")
    if res == true then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 549, 313, 589, 336, "任务")
        res = baseUtils.TomatoOCRTap(tomatoOCR, 255, 1076, 350, 1104, "每日任务")
        res = baseUtils.TomatoOCRTap(tomatoOCR, 496, 304, 547, 332, "领取")
        baseUtils.tapSleep(345, 1058) -- 点击空白处关闭

        res = baseUtils.TomatoOCRTap(tomatoOCR, 374, 1077, 472, 1106, "每周任务")
        res = baseUtils.TomatoOCRTap(tomatoOCR, 496, 304, 547, 332, "领取")
        baseUtils.tapSleep(345, 1058) -- 点击空白处关闭

        res = baseUtils.TomatoOCRTap(tomatoOCR, 94, 1186, 125, 1217, "回") -- 返回活动首页
        res = baseUtils.TomatoOCRTap(tomatoOCR, 232, 1093, 283, 1124, "领取") -- 一键领取
        if res then
            baseUtils.tapSleep(232, 1093) -- 点击空白处
        end
    end
end

-- 活动 - 纸飞机
function yingdiTask.zhiFeiJi()
    if 功能开关["纸飞机"] == 0 then
        return
    end

    -- 返回首页
    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRTap(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    x, y = findMultiColorInRegionFuzzy(0xfcf7ab,
        "-5|12|0xfbf39d,3|14|0xfbf29b,15|15|0xfbf29a,63|9|0xb39767,63|27|0xfbee8a,16|62|0xefcbb7,34|62|0xe9b594,58|62|0xeab797,80|69|0xe39858,86|75|0xe39858,98|71|0xecc1a6,111|61|0xe3985a,119|61|0xe3985a,128|62|0xe39858",
        80, 0, 0, 720, 1280, { orient = 2 }) -- 纸飞机
    if x ~= -1 then
        baseUtils.tapSleep(x, y)
        res = baseUtils.TomatoOCRTap(tomatoOCR, 566, 228, 604, 250, "任务")
        res = baseUtils.TomatoOCRTap(tomatoOCR, 496, 304, 547, 332, "领取")
        baseUtils.tapSleep(345, 1058) -- 点击空白处关闭
        res = baseUtils.TomatoOCRTap(tomatoOCR, 94, 1186, 125, 1217, "回") -- 返回纸飞机首页
        res = baseUtils.TomatoOCRTap(tomatoOCR, 359, 1056, 409, 1087, "领取") -- 一键领取
    else
        -- 下翻第二屏，继续识别
        moveTo(680, 804, 680, 451, 120)
        moveTo(680, 804, 680, 451, 120)
        baseUtils.mSleep3(5000)
        x, y = findMultiColorInRegionFuzzy(0xfcf7ab,
            "-5|12|0xfbf39d,3|14|0xfbf29b,15|15|0xfbf29a,63|9|0xb39767,63|27|0xfbee8a,16|62|0xefcbb7,34|62|0xe9b594,58|62|0xeab797,80|69|0xe39858,86|75|0xe39858,98|71|0xecc1a6,111|61|0xe3985a,119|61|0xe3985a,128|62|0xe39858",
            80, 0, 0, 720, 1280, { orient = 2 }) -- 纸飞机
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            res = baseUtils.TomatoOCRTap(tomatoOCR, 566, 228, 604, 250, "任务")
            res = baseUtils.TomatoOCRTap(tomatoOCR, 496, 304, 547, 332, "领取")
            baseUtils.tapSleep(345, 1058) -- 点击空白处关闭
            res = baseUtils.TomatoOCRTap(tomatoOCR, 94, 1186, 125, 1217, "回") -- 返回纸飞机首页
            res = baseUtils.TomatoOCRTap(tomatoOCR, 359, 1056, 409, 1087, "领取") -- 一键领取
        end
    end
end

function yingdiTask.luYingDaKa()
    if 功能开关["露营打卡点"] == 0 then
        return
    end

    -- 返回首页
    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    x, y = findMultiColorInRegionFuzzy(0xc8b27f,
        "12|17|0xb19264,-14|17|0xfad498,54|13|0xfce2a4,65|-3|0xfbe1a6,65|24|0x884f24,91|18|0xfad498,91|-10|0xfce7ac,109|-10|0xfce7ac,116|21|0xfad295,116|-10|0xfce7ac,156|-9|0xfceaad,156|22|0xfad194,145|3|0xf0dda2,163|3|0xf0dda2,-10|60|0xc47a38,13|60|0xc47a38,46|60|0xd4ab8b,66|59|0xc47a37,92|55|0xe5d3be",
        80, 0, 0, 720, 1280, { orient = 2 }) -- 露营打卡点
    if x ~= -1 then
        baseUtils.tapSleep(x, y)
        x, y = findMultiColorInRegionFuzzy(0xf3a84b,
            "40|0|0xf9d7be,78|0|0xf3a84b,78|4|0xf3a84b,71|4|0xf3a84b,56|4|0xf4ae62,37|4|0xf3a84b,23|4|0xf8d2b3,12|6|0xf3a84b,12|17|0xf3a84b,34|17|0xfef7f3,47|17|0xfbe5d6,63|17|0xf3a84b,85|17|0xf3a84b,0|12|0xf3a84b",
            80, 0, 0, 720, 1280, { orient = 2 }) -- 领取按钮
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            baseUtils.tapSleep(35, 1054) -- 点击空白处关闭
        end
    else
        -- 下翻第二屏，继续识别
        moveTo(680, 804, 680, 451, 120)
        moveTo(680, 804, 680, 451, 120)
        baseUtils.mSleep3(5000)
        x, y = findMultiColorInRegionFuzzy(0xc8b27f,
            "12|17|0xb19264,-14|17|0xfad498,54|13|0xfce2a4,65|-3|0xfbe1a6,65|24|0x884f24,91|18|0xfad498,91|-10|0xfce7ac,109|-10|0xfce7ac,116|21|0xfad295,116|-10|0xfce7ac,156|-9|0xfceaad,156|22|0xfad194,145|3|0xf0dda2,163|3|0xf0dda2,-10|60|0xc47a38,13|60|0xc47a38,46|60|0xd4ab8b,66|59|0xc47a37,92|55|0xe5d3be",
            80, 0, 0, 720, 1280, { orient = 2 }) -- 露营打卡点
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            x, y = findMultiColorInRegionFuzzy(0xf3a84b,
                "40|0|0xf9d7be,78|0|0xf3a84b,78|4|0xf3a84b,71|4|0xf3a84b,56|4|0xf4ae62,37|4|0xf3a84b,23|4|0xf8d2b3,12|6|0xf3a84b,12|17|0xf3a84b,34|17|0xfef7f3,47|17|0xfbe5d6,63|17|0xf3a84b,85|17|0xf3a84b,0|12|0xf3a84b",
                80, 0, 0, 720, 1280, { orient = 2 }) -- 领取按钮
            if x ~= -1 then
                baseUtils.tapSleep(x, y)
                baseUtils.tapSleep(35, 1054) -- 点击空白处关闭
            end
        end
    end
end

function yingdiTask.yueqiandao()
    if 功能开关["月签到"] == 0 then
        return
    end

    -- 返回首页
    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    res = baseUtils.TomatoOCRTap(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    x, y = findMultiColorInRegionFuzzy(0xedc5a4,
        "-2|15|0xefc5a5,-29|15|0xecbf9b,-28|36|0xeae6de,4|36|0xf1e6dc,33|35|0xe8b58b,57|35|0x823e23,57|73|0xb8b8b8,26|70|0x823a1e,-1|60|0xedcdbd,-15|75|0x888883,-8|100|0xbcb0aa,5|96|0x474038,39|96|0x2a251f,68|96|0x9c9b97",
        80, 0, 0, 720, 1280, { orient = 2 })
    if x ~= -1 then
        baseUtils.tapSleep(x, y)
        res = baseUtils.TomatoOCRTap(tomatoOCR, 310, 977, 408, 1009, "点击签到")
        baseUtils.tapSleep(36, 1123) -- 点击空白处关闭
    else
        -- 下翻第二屏，继续识别
        moveTo(680, 804, 680, 451, 120)
        moveTo(680, 804, 680, 451, 120)
        baseUtils.mSleep3(5000)
        x, y = findMultiColorInRegionFuzzy(0xedc5a4,
            "-2|15|0xefc5a5,-29|15|0xecbf9b,-28|36|0xeae6de,4|36|0xf1e6dc,33|35|0xe8b58b,57|35|0x823e23,57|73|0xb8b8b8,26|70|0x823a1e,-1|60|0xedcdbd,-15|75|0x888883,-8|100|0xbcb0aa,5|96|0x474038,39|96|0x2a251f,68|96|0x9c9b97",
            80, 0, 0, 720, 1280, { orient = 2 })
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            res = baseUtils.TomatoOCRTap(tomatoOCR, 310, 977, 408, 1009, "点击签到")
            baseUtils.tapSleep(36, 1123) -- 点击空白处关闭
        end
    end
end

-- 秘宝地图选择
function yingdiTask.miBaoChangeMap(left, right)
    -- 抽取秘宝
    local map = {
        "暗月深林", "艾特拉火山", "鲁尔绿洲", "燃烧塔"
    }
    selectMap = map[功能开关["秘宝地图"] + 1]

    local findMap = false

    -- 先找右侧
    if left == 0 and right == 1 then
        moveTo(420, 200, 420, 600, 80)
        baseUtils.mSleep3(1500);
        moveTo(420, 400, 150, 400, 800)
        baseUtils.mSleep3(1500);
    end

    -- 再找左侧
    if left == 1 and right == 1 then
        moveTo(420, 200, 420, 600, 80)
        baseUtils.mSleep3(1500);
        moveTo(150, 400, 420, 400, 100)
        baseUtils.mSleep3(1500);
    end

    --暗月深林
    if selectMap == "暗月深林" then
        x, y = findMultiColorInRegionFuzzy(0x3e4483,
            "0|16|0x454784,-16|44|0x2e3a85,-4|46|0x253a88,4|49|0x1054a2,22|51|0x1287c3,48|51|0x163c8b,47|37|0x2b64a8,30|37|0x1592c8,46|26|0x1779bf,51|7|0x1972ba,51|-1|0x334587,37|-4|0x1d6cbe",
            80, 0, 0, 720, 1280, { orient = 2 })
        if x ~= -1 then
            baseUtils.tapSleep(x, y, 3)
            findMap = true
        end
    end

    --艾特拉火山
    if selectMap == "艾特拉火山" then
        x, y = findMultiColorInRegionFuzzy(0x7e462e,
            "-1|13|0x3f4658,-1|21|0x565a67,6|22|0xfbfbfc,16|22|0xffffff,36|22|0x3e4557,46|22|0xffffff,68|22|0x3d4557,68|9|0x76422e,68|-2|0xb87852,56|-2|0xc7855a,48|-2|0xbf8058,38|-2|0x6f412e",
            80, 0, 0, 720, 1280, { orient = 2 })
        if x ~= -1 then
            baseUtils.tapSleep(x, y, 3)
            findMap = true
        end
    end

    --鲁尔绿洲
    if selectMap == "鲁尔绿洲" then
        x, y = findMultiColorInRegionFuzzy(0xbaae93,
            "42|-4|0xaecada,42|10|0xa58638,32|14|0xbfccd2,62|14|0xb79358,62|6|0xd8b884,73|5|0xd8b783,73|-7|0xc0a675,78|19|0xbaa05c,82|19|0xcfc488,80|33|0xb5ac6f,66|33|0xb3b387,46|34|0xaccbcc,15|33|0x9fb628,0|33|0xd9bc8b,36|-27|0xabc6d9",
            80, 0, 0, 720, 1280, { orient = 2 })
        if x ~= -1 then
            baseUtils.tapSleep(x, y, 3)
            findMap = true
        end
    end

    --燃烧塔
    if selectMap == "燃烧塔" then
        x, y = findMultiColorInRegionFuzzy(0xaa4731,
            "2|6|0x9c3b2b,14|6|0x87382a,19|14|0x68271f,6|14|0x712520,6|26|0x742921,25|26|0x903c2d,23|37|0xffffff,32|38|0xfcfcfc,45|36|0x82858d,45|39|0xcecfd1,67|1|0xf88f5f",
            80, 0, 0, 720, 1280, { orient = 2 })
        if x ~= -1 then
            baseUtils.tapSleep(x, y, 3)
            findMap = true
        end
    end

    if findMap == false then
        -- 左右均为找到
        if left == 1 and right == 1 then
            return findMap
        end

        -- 再找左侧
        if right == 1 then
            return yingdiTask.miBaoChangeMap(1, 1)
        end

        -- 先找右侧（等级低的区域在右侧）
        return yingdiTask.miBaoChangeMap(0, 1)
    end
    return findMap
end

-- 秘宝
function yingdiTask.yingDiMiBao()
    if 功能开关["秘宝收集"] == 0 then
        return
    end

    -- 返回首页
    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
    --判断是否在营地页面
    res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
    if res == false then
        return
    end

    baseUtils.tapSleep(330, 170, 4) -- 秘宝

    -- 领取秘宝能量
    x, y = findMultiColorInRegionFuzzy(0xffffff,
        "3|5|0x84dbfe,-1|7|0x8ae5ff,7|2|0x7ccafe,5|12|0xe0fcff,0|12|0xf0fefe,-2|24|0xffffff,4|24|0xffffff,9|24|0xb8b9bb,15|24|0xc2c3c5,19|29|0x606167,6|28|0x5b5f69,-4|29|0x5b5f69,-9|29|0x6a6e76,-13|18|0x595b61",
        80, 0, 0, 720, 1280, { orient = 2 })
    if x ~= -1 then
        baseUtils.tapSleep(x, y)
        baseUtils.tapSleep(360, 1100) -- 点击空白处关闭
    end

    -- 购买秘宝能量
    res, availableNengLiang = baseUtils.TomatoOCRText(tomatoOCR, 607, 80, 660, 104, "剩余能量") -- 210
    availableNengLiang = tonumber(availableNengLiang)
    if availableNengLiang == nil or availableNengLiang < 200 then -- 识别剩余体力不足200时，尝试补充
        needNengLiang = true
    end

    if needNengLiang then
        baseUtils.tapSleep(690, 90, 3)
        local needCount = tonumber(功能开关["能源兑换次数"])
        if needCount == nil then
            needCount = 0
        end
        while 1 do
            res, buyCount = baseUtils.TomatoOCRText(tomatoOCR, 497, 817, 510, 834, "已购买次数") -- 1/9
            buyCount = tonumber(buyCount)
            if buyCount == nil or buyCount >= needCount then
                res = baseUtils.TomatoOCRTap(tomatoOCR, 94, 1186, 125, 1218, "回") -- 返回秘宝首页，等待抽取
                break
            end
            res = baseUtils.TomatoOCRTap(tomatoOCR, 456, 873, 498, 893, "购买")
        end
    end


    findMap = yingdiTask.miBaoChangeMap()

    if findMap then
        while 1 do
            res, availableNengLiang = baseUtils.TomatoOCRText(tomatoOCR, 607, 80, 660, 104, "剩余能量") -- 210
            availableNengLiang = tonumber(availableNengLiang)
            if availableNengLiang == nil or availableNengLiang < 50 then -- 识别剩余体力不足100时，退出寻宝循环
                break
            end

            if availableNengLiang >= 100 then
                baseUtils.tapSleep(580, 880) -- 拉满10次
            end
            res = baseUtils.TomatoOCRTap(tomatoOCR, 331, 1119, 386, 1147, "寻宝")
            if res then
                -- 判断能源是否用尽
                res = baseUtils.TomatoOCRText(tomatoOCR, 316, 343, 404, 370, "补充能源")
                if res then
                    return
                end

                baseUtils.tapSleep(620, 90)
                baseUtils.tapSleep(620, 90)
                baseUtils.tapSleep(620, 90)
                res = baseUtils.TomatoOCRTap(tomatoOCR, 586, 77, 631, 105, "跳过")
                baseUtils.tapSleep(360, 1100, 1) -- 点击空白处关闭
            end
        end
    end
end

-- 每日商店
function yingdiTask.yingDiShop()
    if 功能开关["仓鼠百货"] == 0 then
        return
    end

    if 任务记录["仓鼠百货-完成"] == 1 then
        return
    end

    -- 返回首页
    dailyTask.homePage()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 267, 1207, 359, 1232, "仓鼠百货")
    if res == false then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 125, 1202, 187, 1234, "营地")
        --判断是否在营地页面
        res = baseUtils.TomatoOCRText(tomatoOCR, 12, 1110, 91, 1135, "旅行活动")
        if res == false then
            return
        end
        baseUtils.tapSleep(475, 285, 3) -- 商店
    end

    -- 开始购买
    res = baseUtils.TomatoOCRText(tomatoOCR, 122, 694, 184, 718, "已售罄")
    if res == false then
        baseUtils.tapSleep(145, 630)     -- 金币箱
        baseUtils.tapSleep(360, 825)     -- 购买
        baseUtils.tapSleep(360, 1100, 1) -- 点击空白处关闭
    end

    if 功能开关["商店-星星经验"] == 1 then
        res = baseUtils.TomatoOCRText(tomatoOCR, 261, 695, 320, 717, "已售罄")
        if res == false then
            baseUtils.tapSleep(290, 630) -- 星星经验
            res = baseUtils.TomatoOCRTap(tomatoOCR, 466, 767, 523, 794, "最大", 2, 2) -- 最大
            baseUtils.tapSleep(360, 825) -- 购买
            baseUtils.tapSleep(360, 1100, 1) -- 点击空白处关闭
        end
    end

    if 功能开关["商店-全价兽粮"] == 1 then
        res = baseUtils.TomatoOCRText(tomatoOCR, 397, 695, 463, 720, "已售罄")
        if res == false then
            baseUtils.tapSleep(430, 630) -- 全价兽粮
            res = baseUtils.TomatoOCRTap(tomatoOCR, 471, 785, 519, 810, "最大", 2, 2) -- 最大
            baseUtils.tapSleep(360, 855) -- 购买
            baseUtils.tapSleep(360, 1100, 1) -- 点击空白处关闭
        end
    end

    -- 自用不需要
    -- baseUtils.tapSleep(565, 635) -- 原材料
    -- res = baseUtils.TomatoOCRTap(tomatoOCR, 468,784,521,812, "最大") -- 最大
    -- baseUtils.tapSleep(360, 855) -- 购买
    -- baseUtils.tapSleep(360, 1100, 1) -- 点击空白处关闭

    if 功能开关["商店-超级成长零食(三折)"] == 1 then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 99, 765, 208, 792, "超级成长零食") -- 超级成长零食（三折）
        res = baseUtils.TomatoOCRTap(tomatoOCR, 471, 767, 515, 793, "最大", 2, 2) -- 最大
        res = baseUtils.TomatoOCRTap(tomatoOCR, 470, 770, 515, 793, "最大", 2, 2) -- 最大
        if res then
            baseUtils.tapSleep(360, 820) -- 购买
            baseUtils.tapSleep(360, 1100, 1) -- 点击空白处关闭
        end
    end

    if 功能开关["商店-黑烬突破石(五折)"] == 1 then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 243, 764, 343, 789, "黑烬突破石") -- 黑烬突破石（五折）
        if res then
            baseUtils.tapSleep(360, 820) -- 购买
            baseUtils.tapSleep(360, 1100, 1) -- 点击空白处关闭
        end
    end

    if 功能开关["商店-经验补剂(五折)"] == 1 then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 386, 764, 472, 788, "经验补剂") -- 经验补剂（五折）
        if res then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 470, 784, 514, 812, "最大", 2, 2) -- 最大
            if res then
                baseUtils.tapSleep(360, 855) -- 购买
                baseUtils.tapSleep(360, 1100, 1) -- 点击空白处关闭
            end
        end
    end

    任务记录["仓鼠百货-完成"] = 1
end

return yingdiTask
