local shilianTask = {}

-- 定义环境和关卡名称的配对
local map = {
    "原野",
    "森林",
    "沙漠",
    "海湾",
    "深林",
    "冰原",
    "火山",
    "高原",
    "绿洲",
    "火原"
}

local mapPoi = {
    ["原野"] = { "113", "235", "170", "268" },
    ["森林"] = { "114", "336", "171", "366" },
    ["沙漠"] = { "112", "435", "172", "468" },
    ["海湾"] = { "113", "535", "171", "567" },
    ["深林"] = { "110", "634", "176", "666" },
    ["冰原"] = { "113", "733", "172", "767" },
    ["火山"] = { "111", "832", "170", "865" },
    ["高原"] = { "111", "932", "174", "960" },
    ["绿洲"] = { "113", "1032", "169", "1062" },
    ["火原"] = { "113", "671", "172", "701" }
}

local stage = {
    { "古遗迹上的幽影" },
    { "旧国之王的野心" },
    { "三宝齐聚黄金船" },
    { "海洋征服计划" },
    { "噩兆降临之谷" },
    { "永冻禁区矿场", "尤弥尔深渊" },
    { "蒸汽炎池浴场", "艾特拉之心" },
    { "雷电焦土深处", "九王角斗场" },
    { "溪谷大暴走", "躁动绿洲之丘", "白沙渊下的鼓动" },
    { "浴火燃墟伐木场", "激战构造体工厂", "无始无终燃烧塔" }
}


local stagePoi = {
    ["古遗迹上的幽影"] = { "302", "373", "468", "402" },
    ["旧国之王的野心"] = { "302", "373", "468", "402" },
    ["三宝齐聚黄金船"] = { "302", "373", "468", "402" },
    ["海洋征服计划"] = { "302", "373", "468", "402" },
    ["噩兆降临之谷"] = { "302", "373", "468", "402" },
    ["永冻禁区矿场"] = { "303", "373", "447", "401" },
    ["尤弥尔深渊"] = { "303", "567", "423", "596" },
    ["蒸汽炎池浴场"] = { "303", "373", "447", "401" },
    ["艾特拉之心"] = { "303", "567", "423", "596" },
    ["雷电焦土深处"] = { "303", "373", "447", "401" },
    ["九王角斗场"] = { "303", "567", "423", "596" },
    ["溪谷大暴走"] = { "302", "373", "469", "401" },
    ["躁动绿洲之丘"] = { "301", "568", "447", "596" },
    ["白沙渊下的鼓动"] = { "304", "759", "469", "792" },
    ["浴火燃墟伐木场"] = { "302", "373", "469", "401" },
    ["激战构造体工厂"] = { "301", "568", "447", "596" },
    ["无始无终燃烧塔"] = { "304", "759", "469", "792" },
}

-- 试炼
function shilianTask.shilian()
    if 秘境地图 == nil or 秘境关卡 == nil then
        return
    end

    if 功能开关["冒险功能开关"] == 0 then
        return
    end

    -- 开始试炼
    if 功能开关["秘境开关"] == 1 then
        shilianTask.mijiing()
    end

    if 功能开关["恶龙大通缉"] == 1 then
        shilianTask.mijiing()
    end
end

-- 秘境之间
function shilianTask.mijiing()
    -- 返回首页
    dailyTask.homePage()
    -- 退出组队
    dailyTask.quitTeam()

    selectMap = map[秘境地图 + 1]
    selectStage = stage[秘境地图 + 1][秘境关卡 + 1]

    res = baseUtils.TomatoOCRTap(tomatoOCR, 650, 522, 688, 544, "试炼")
    if res then
        --res = baseUtils.TomatoOCRTap(tomatoOCR, 380, 112, 558, 154, "秘境之间") -- 低等级4图，区域错误；改为图色识别
        x, y = findMultiColorInRegionFuzzy(0xe9faff,
            "0|20|0xbdefff,0|30|0xa1e9ff,11|29|0xa3e9fe,23|29|0xa4eaff,41|29|0x3b455a,53|29|0xa5eaff,53|20|0xbdefff,53|10|0xc1dfea,60|10|0xccebf6,69|10|0xccebf6,69|24|0x638090,68|31|0x9fe9ff,62|-5|0xf1fdff",
            80, 0, 0, 720, 1280, { orient = 2 })
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
        end
    else
        res = baseUtils.TomatoOCRTap(tomatoOCR, 233, 1205, 281, 1234, "行李") -- 尝试点击旅人切换页面，解决长时间停留首页，试炼按钮异常消失的情况（反作弊策略？）
        return shilianTask.shilian()
    end

    shilianTask.openTreasure()

    res = shilianTask.changeMap(selectMap, selectStage)
    if res == false then
        return
    end
    res = shilianTask.startFight()
end

-- 切换地图
function shilianTask.changeMap(selectMap, selectStage)
    baseUtils.tapSleep(74, 160) -- 点击地图列表

    local mapPoi = mapPoi[selectMap]
    local mapNum = tonumber(秘境地图)
    if mapNum > 8 then -- 火原之后的地图，需翻页
        moveTo(150, 700, 150, 300, 30)
        baseUtils.mSleep3(1500);
    else
        moveTo(150, 300, 150, 700, 30)
        baseUtils.mSleep3(1500);
    end
    res = baseUtils.TomatoOCRTap(tomatoOCR, mapPoi[1], mapPoi[2], mapPoi[3], mapPoi[4], selectMap, 3, 3)
    local stagePoi = stagePoi[selectStage]
    res = baseUtils.TomatoOCRTap(tomatoOCR, stagePoi[1], stagePoi[2], stagePoi[3], stagePoi[4], selectStage)
    if res == false then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 303, 342, 468, 371, selectMap)     -- 兼容默认识别第一图
        if res == false then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 304, 375, 468, 403, selectMap) -- 兼容默认识别第一图
        end
        if res == false then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 302, 535, 470, 568, selectMap) -- 兼容默认识别第二图
        end
        if res == false then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 303, 731, 469, 759, selectMap) -- 兼容默认识别第三图
        end
    end

    -- 判断是否切换成功
    res = baseUtils.TomatoOCRText(tomatoOCR, 329, 223, 388, 253, selectMap)
    if res then
        return true
    else
        return false
    end
end

-- 开始匹配
function shilianTask.startFight()
    -- 识别剩余体力不足40时，尝试补充
    res2, availableTiLi = baseUtils.TomatoOCRText(tomatoOCR, 605, 81, 630, 100, "剩余体力") -- 20/60
    availableTiLi = tonumber(availableTiLi)
    if availableTiLi == nil or availableTiLi < 40 then -- 识别剩余体力不足40时，尝试补充
        shilianTask.tili()
    end

    -- 判断体力不足，退出挑战
    res2, availableTiLi = baseUtils.TomatoOCRText(tomatoOCR, 605, 81, 630, 100, "剩余体力") -- 20/60
    availableTiLi = tonumber(availableTiLi)
    if availableTiLi == nil or availableTiLi < 20 then -- 识别剩余体力不足20时
        if 功能开关["秘境-体力不足继续挑战"] == false then
            return
        end
    end

    --判断是否添加佣兵
    if 功能开关["秘境-添加佣兵"] == 1 then
        x, y = findMultiColorInRegionFuzzy(0x9f7c55,
            "0|4|0xb1936a,-1|9|0xc0a57a,9|13|0x9f7c56,10|7|0xbea378,10|2|0xbea378,18|2|0xd0b88a,23|2|0xa07e57,27|1|0xaa8b62,27|7|0xae8f67,26|11|0xe9d4a2,35|7|0xebd6a4,39|6|0xefdba8,43|5|0xdcc595,45|4|0xf4e0ac,49|4|0xe9d4a2,53|4|0xd1ba8c,55|4|0xeedaa7,61|3|0xf4e0ac,63|5|0xc5ab80",
            90, 0, 0, 720, 1280, { orient = 2 }) -- 创建队伍
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            baseUtils.tapSleep(365, 820) -- 点击 创建队伍 - 添加佣兵
            res = baseUtils.TomatoOCRTap(tomatoOCR, 313, 876, 407, 907, "创建队伍") -- 创建队伍 - 创建队伍
            res = baseUtils.TomatoOCRTap(tomatoOCR, 333, 974, 383, 1006, "开始")

            -- 判断体力用尽提示
            res1 = baseUtils.TomatoOCRText(tomatoOCR, 242, 598, 314, 616, "体力不足")
            if res1 then
                if 功能开关["秘境-体力不足继续挑战"] then
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 334, 743, 385, 771, "确定")
                else
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 64, 1200, 128, 1234, "返回")
                    shilianTask.tili()
                end
            end

            return shilianTask.fighting()
        end
    end

    resStart1 = baseUtils.TomatoOCRTap(tomatoOCR, 311, 697, 405, 725, "开始匹配") -- 图1
    if resStart1 == false then
        resStart2 = baseUtils.TomatoOCRTap(tomatoOCR, 309, 892, 407, 918, "开始匹配") -- 图2
    end
    if resStart2 == false then
        resStart3 = baseUtils.TomatoOCRTap(tomatoOCR, 311, 1084, 405, 1116, "开始匹配") -- 图3
    end

    if resStart1 == false and resStart2 == false and resStart3 == false then
        return
    end


    -- 判断体力用尽提示
    res1 = baseUtils.TomatoOCRText(tomatoOCR, 242, 598, 314, 616, "体力不足")
    if res1 then
        if 功能开关["秘境-体力不足继续挑战"] then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 334, 743, 385, 771, "确定")
        else
            res = baseUtils.TomatoOCRTap(tomatoOCR, 64, 1200, 128, 1234, "返回")
            shilianTask.tili()
        end
    end

    -- 判断正在匹配中 - 循环等待300s
    local totalWait = 150 * 1000 -- 30000 毫秒 = 30 秒
    local elapsed = 0
    while 1 do
        if elapsed > totalWait then
            -- 超时取消匹配
            res = baseUtils.TomatoOCRTap(tomatoOCR, 320, 692, 392, 716, "匹配中") -- 图1
            if res == false then
                res = baseUtils.TomatoOCRTap(tomatoOCR, 323, 886, 394, 910, "匹配中") -- 图2
            end
            if res == false then
                res4 = baseUtils.TomatoOCRTap(tomatoOCR, 324, 1080, 392, 1103, "匹配中") -- 图3
            end
            break
        end
        logUtils.log("匹配中")

        -- 判断无合适队伍，重新开始匹配
        res = baseUtils.TomatoOCRText(tomatoOCR, 303, 607, 418, 632, "暂无合适队伍")
        if res then
            res = baseUtils.TomatoOCRText(tomatoOCR, 210, 727, 262, 758, "取消")
            if res then
                elapsed = 0
            end
        end

        res2 = baseUtils.TomatoOCRText(tomatoOCR, 320, 692, 392, 716, "匹配中") -- 图1
        res3 = baseUtils.TomatoOCRText(tomatoOCR, 323, 886, 394, 910, "匹配中") -- 图2
        res4 = baseUtils.TomatoOCRText(tomatoOCR, 324, 1080, 392, 1103, "匹配中") -- 图3
        res1 = shilianTask.WaitFight()
        if res1 == true or (res2 == false and res3 == false and res4 == false) then -- 成功准备战斗 或 未匹配到
            break
        end

        baseUtils.mSleep3(5 * 1000)
        elapsed = elapsed + 5 * 1000
    end
end

-- 等待匹配
function shilianTask.WaitFight()
    res1 = baseUtils.TomatoOCRTap(tomatoOCR, 457, 607, 502, 631, "准备")
    if res1 == true then
        local totalWait = 20 * 1000 -- 30000 毫秒 = 30 秒
        local elapsed = 0

        -- 等待进入战斗
        while elapsed <= totalWait do
            if elapsed == totalWait then
                logUtils.log("队友未准备,退出组队")
                res1 = false
                break
            end
            res1 = baseUtils.TomatoOCRText(tomatoOCR, 642, 461, 702, 483, "麦克风")
            res2 = baseUtils.TomatoOCRText(tomatoOCR, 649, 394, 692, 417, "语音")
            res3 = baseUtils.TomatoOCRText(tomatoOCR, 651, 319, 691, 342, "队伍")

            if res1 or res2 or res3 then
                logUtils.log("匹配成功，进入战斗")
                shilianTask.fighting()
                res1 = true
                return
            end
            baseUtils.mSleep3(5000)
            elapsed = elapsed + 5 * 1000
        end
    end
    return res1
end

-- 购买体力
function shilianTask.tili()
    x, y = findMultiColorInRegionFuzzy(0xf6e681,
        "7|0|0xf4de74,3|0|0xf4e379,2|12|0xf2d266,3|5|0xf4d96c,-2|3|0xf4e079,-2|6|0xf2da73,10|8|0xf5dc82,6|10|0xefcf6f,3|13|0xdda365,7|12|0xd79760,10|10|0xd89761,11|-1|0xda9f60,9|2|0xd89f61",
        90, 0, 0, 720, 1280, { orient = 2 })
    if x == -1 then
        logUtils.log("体力购买页匹配失败")
        return
    end

    baseUtils.tapSleep(690, 90) -- 点击补充体力加号

    while 1 do
        res, count = baseUtils.TomatoOCRText(tomatoOCR, 500, 817, 515, 834, "0")
        local bugCount = tonumber(count)
        if bugCount == nil then
            bugCount = 0
        end
        local needCount = tonumber(补充体力次数)
        if needCount == nil then
            needCount = 0
        end
        if bugCount < needCount then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 456, 873, 499, 898, "购买")
        else
            break
        end
    end

    baseUtils.tapSleep(61, 1187)

    return shilianTask.startFight()
end

-- 判断是否战斗中
function shilianTask.fighting()
    local totalWait = 300 * 1000 -- 30000 毫秒 = 30 秒
    local elapsed = 0

    while 1 do
        if elapsed >= totalWait then
            shilianTask.quitTeam() -- 退出队伍
            logUtils.log("战斗超时,退出组队")
            break
        end

        res1 = baseUtils.TomatoOCRText(tomatoOCR, 642, 461, 702, 483, "麦克风")
        res2 = baseUtils.TomatoOCRText(tomatoOCR, 649, 394, 692, 417, "语音")
        res3 = baseUtils.TomatoOCRText(tomatoOCR, 651, 319, 691, 342, "队伍")

        -- 战斗结束
        openStatus = shilianTask.openTreasure()

        if openStatus == 1 then
            logUtils.log("战斗胜利")
            break
        elseif res1 or res2 or res3 then
            logUtils.log("战斗中")
        end

        -- 判断是否战斗失败（战斗4分钟后）
        res, teamName = baseUtils.TomatoOCRText(tomatoOCR, 8, 148, 51, 163, "队友名称")
        if elapsed > 240 * 1000 or teamName == "" then
            shilianTask.fightFail()
            break
        end
        baseUtils.mSleep3(5 * 1000)
        elapsed = elapsed + 5 * 1000
    end
end

-- 判断是否战斗失败
function shilianTask.fightFail()
    res1 = baseUtils.TomatoOCRText(tomatoOCR, 246, 459, 327, 482, "你被击败了")
    res2 = baseUtils.TomatoOCRText(tomatoOCR, 475, 1038, 527, 1065, "放弃")
    if res1 or res2 then
        logUtils.log("战斗失败")
        res = baseUtils.TomatoOCRTap(tomatoOCR, 326, 745, 393, 778, "确认") -- 点击确认
        shilianTask.quitTeam() -- 退出队伍
        return true
    end
    return false
end

-- 战斗中退出组队
function shilianTask.quitTeam()
    res = baseUtils.TomatoOCRTap(tomatoOCR, 649, 319, 694, 342, "队伍")
    if res then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 501, 191, 581, 217, "离开队伍")
        res = baseUtils.TomatoOCRTap(tomatoOCR, 329, 726, 391, 761, "确定")
    end
end

-- 队伍喊话
function shilianTask.teamShout()
    res = baseUtils.TomatoOCRTap(tomatoOCR, 19, 1104, 94, 1128, "点击输入")
    if res then

    end
end

-- 领取宝箱
function shilianTask.openTreasure()
    if 功能开关["秘境-不开宝箱"] ~= nil and 功能开关["秘境-不开宝箱"] == 1 then
        openStatus = 0
        res1 = baseUtils.TomatoOCRText(tomatoOCR, 313, 622, 404, 656, "通关奖励") -- 战斗结束页。宝箱提示
        res2 = baseUtils.TomatoOCRText(tomatoOCR, 267, 755, 313, 783, "开启") -- 战斗结束页。宝箱提示
        res3 = baseUtils.TomatoOCRText(tomatoOCR, 273, 397, 360, 425, "是否开启") -- 结算页，宝箱提示
        res4 = baseUtils.TomatoOCRText(tomatoOCR, 265, 457, 314, 488, "开启") -- 结算页，宝箱提示
        --x, y = findMultiColorInRegionFuzzy(0xfae2d0,
        --    "8|0|0xfae2d0,24|0|0xffffff,28|10|0xf8d6bb,17|7|0xf8cfaf,9|7|0xffffff,0|7|0xfffefe,0|16|0xf3a84b,0|28|0xd99861,-1|35|0xe6bf6f,-7|32|0xf3d66a,-7|23|0xf5e57c,25|22|0xce8328",
        --    80, 0, 0, 720, 1280, { orient = 2 }) -- 宝箱图片
        if res1 or res2 or res3 or res4 then
            if 功能开关["秘境-点赞队友"] ~= nil and 功能开关["秘境-点赞队友"] == 1 then
                zan = 0
                while zan < 4 do
                    x, y = findMultiColorInRegionFuzzy(0xffffff,
                        "0|1|0xffffff,0|4|0xfefefe,-1|12|0xffffff,5|9|0xfefefe,5|6|0xffffff,5|3|0x82a6e2,-8|2|0x7da3e3,-7|5|0xffffff,-8|8|0xffffff,-8|13|0x94afe3,2|16|0x7ea2e3,8|12|0x7aa3e2,9|7|0x80a5e4",
                        80, 0, 0, 720, 1280, { orient = 2 })
                    if x ~= -1 then
                        baseUtils.tapSleep(x, y) -- 战斗结束页点赞队友
                    end
                    zan = zan + 1
                end
            end

            baseUtils.tapSleep(362, 1255, 3) -- 战斗结束页确认不领取
            res = baseUtils.TomatoOCRTap(tomatoOCR, 329, 728, 386, 759, "确定") -- 战斗结束页确认退出
            if res == false then
                res = baseUtils.TomatoOCRTap(tomatoOCR, 96, 1199, 130, 1232, "回") -- 返回
                res = baseUtils.TomatoOCRTap(tomatoOCR, 329, 728, 386, 759, "确定") -- 确定
                if res == false then
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 331, 727, 388, 761, "确定") -- 确定返回
                end
                if res then
                    openStatus = 1
                end
            else
                openStatus = 1
            end
        end
        return openStatus
    end

    -- 点赞队友
    if 功能开关["秘境-点赞队友"] ~= nil and 功能开关["秘境-点赞队友"] == 1 then
        res1 = baseUtils.TomatoOCRText(tomatoOCR, 267, 810, 440, 840, "开启宝箱获得奖励") -- 战斗结束页。宝箱提示
        res2 = baseUtils.TomatoOCRText(tomatoOCR, 267, 755, 313, 783, "开启") -- 战斗结束页。宝箱提示
        res3 = baseUtils.TomatoOCRText(tomatoOCR, 261, 455, 447, 491, "开启宝箱获得奖励") -- 结算页，宝箱提示
        res4 = baseUtils.TomatoOCRText(tomatoOCR, 265, 457, 314, 488, "开启") -- 结算页，宝箱提示
        --x, y = findMultiColorInRegionFuzzy(0xfae2d0,
        --    "8|0|0xfae2d0,24|0|0xffffff,28|10|0xf8d6bb,17|7|0xf8cfaf,9|7|0xffffff,0|7|0xfffefe,0|16|0xf3a84b,0|28|0xd99861,-1|35|0xe6bf6f,-7|32|0xf3d66a,-7|23|0xf5e57c,25|22|0xce8328",
        --    80, 0, 0, 720, 1280, { orient = 2 }) -- 宝箱图片
        if res1 or res2 or res3 or res4 then
            zan = 0
            while zan < 4 do
                x, y = findMultiColorInRegionFuzzy(0xffffff,
                    "0|1|0xffffff,0|4|0xfefefe,-1|12|0xffffff,5|9|0xfefefe,5|6|0xffffff,5|3|0x82a6e2,-8|2|0x7da3e3,-7|5|0xffffff,-8|8|0xffffff,-8|13|0x94afe3,2|16|0x7ea2e3,8|12|0x7aa3e2,9|7|0x80a5e4",
                    80, 0, 0, 720, 1280, { orient = 2 })
                if x ~= -1 then
                    baseUtils.tapSleep(x, y) -- 战斗结束页点赞队友
                end
                zan = zan + 1
            end
        end
    end

    local attempts = 0    -- 初始化尝试次数
    local maxAttempts = 2 -- 设置最大尝试次数

    local openStatus = 0
    while attempts < maxAttempts do
        attempts = attempts + 1
        -- 战斗结束页
        res = baseUtils.TomatoOCRTap(tomatoOCR, 219, 1103, 254, 1120, "开启") -- 战斗页，宝箱1
        if res then
            baseUtils.mSleep3(3500);
            baseUtils.tapSleep(340, 930)
            openStatus = 1
        end
        res = baseUtils.TomatoOCRTap(tomatoOCR, 462, 1102, 502, 1122, "开启") -- 战斗页，宝箱2
        if res then
            baseUtils.mSleep3(3500);
            baseUtils.tapSleep(340, 930)
            openStatus = 1
        end
        -- 结算页
        -- 结算页，单宝箱
        res = baseUtils.TomatoOCRTap(tomatoOCR, 340, 756, 380, 777, "开启")
        if res then
            baseUtils.mSleep3(3500);
            baseUtils.tapSleep(340, 930)
            openStatus = 1
        end

        -- 领取宝箱1
        res = baseUtils.TomatoOCRTap(tomatoOCR, 214, 748, 257, 767, "开启")
        if res then
            baseUtils.mSleep3(3500);
            baseUtils.tapSleep(340, 930)
            openStatus = 1
        end
        -- 领取宝箱2
        res = baseUtils.TomatoOCRTap(tomatoOCR, 460, 747, 503, 767, "开启")
        if res then
            baseUtils.mSleep3(3500);
            baseUtils.tapSleep(340, 930)
            openStatus = 1
        end
    end

    -- 开启宝箱后，返回
    if openStatus == 1 then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 96, 1199, 130, 1232, "回") -- 返回
        res = baseUtils.TomatoOCRTap(tomatoOCR, 330, 726, 387, 759, "确定") -- 确定返回
        if res == false then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 331, 727, 388, 761, "确定") -- 确定返回
        end
    end
    return openStatus
end

return shilianTask
