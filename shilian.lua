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
    "火原",
    "下城"
}

local mapPoi = {
    ["原野"] = { "113", "235", "170", "268" },
    ["森林"] = { "114", "336", "171", "366" },
    ["沙漠"] = { "112", "435", "172", "468" },
    ["海湾"] = { "113", "535", "171", "567" },
    ["深林"] = { "110", "634", "176", "666" },
    ["冰原"] = { "113", "733", "172", "767" },
    ["火山"] = { "114", "271", "172", "304" },
    ["高原"] = { "112", "371", "172", "403" },
    ["绿洲"] = { "113", "470", "171", "503" },
    ["火原"] = { "112", "569", "173", "603" },
    ["下城"] = { "113", "669", "172", "702" }
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
    { "浴火燃墟伐木场", "激战构造体工厂", "无始无终燃烧塔" },
    { "魔偶师赌局" }
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
    ["魔偶师赌局"] = { "302", "373", "469", "401" },
}

-- 试炼
function shilianTask.shilian()
    if 功能开关["冒险功能开关"] == 0 then
        return
    end

    -- 开始试炼
    if 功能开关["秘境开关"] == 1 then
        if 功能开关["秘境地图"] == nil or 功能开关["秘境关卡"] == nil then
            return
        end
        while 1 do
            shilianTask.mijiing()
            --不开宝箱时无需循环
            --开启宝箱时循环至体力用尽
            if 功能开关["秘境-不开宝箱"] == 1 or 任务记录["试炼-秘境-体力消耗完成"] == 1 then
                break
            end
        end
    end

    if 功能开关["恶龙大通缉开关"] == 1 then
        --while 1 do
        shilianTask.elong()
        --if 任务记录["试炼-恶龙-完成次数"] >= 1 then
        --    break
        --end
        --end
    end

    if 功能开关["暴走史莱姆开关"] == 1 then
        shilianTask.daBaoZou()
    end
end

-- 恶龙大通缉
function shilianTask.elong()
    baseUtils.toast("恶龙任务 - 开始", 0.5)

    -- 返回首页
    dailyTask.homePage()
    -- 退出组队
    dailyTask.quitTeam()

    res = baseUtils.TomatoOCRTap(tomatoOCR, 650, 522, 688, 544, "试炼")
    if res then
        --res = baseUtils.TomatoOCRTap(tomatoOCR, 380, 112, 558, 154, "秘境之间") -- 低等级4图，区域错误；改为图色识别
        if (isColor(246, 554, 0xb13b35, 80) and isColor(254, 570, 0xfffcc4, 80) and isColor(260, 559, 0xaa3535, 80) and isColor(231, 566, 0x591715, 80) and isColor(229, 580, 0x8d2e2f, 80) and isColor(226, 575, 0xad3535, 80) and isColor(222, 570, 0xab3636, 80) and isColor(220, 560, 0x4e1216, 80) and isColor(312, 550, 0xfece7a, 80) and isColor(321, 543, 0xffd27b, 80)) then
            baseUtils.tapSleep(245, 555, 0.8)
        else
            x, y = findMultiColorInRegionFuzzy(0xb13a35,
                "-1|6|0xc9634d,-1|18|0xfde482,-1|33|0xffec75,-1|58|0xfffe82,-22|55|0x7c2f2d,-43|49|0xe7795b,-76|17|0xae3036,-84|5|0xfed47a,54|9|0xac3333",
                85, 0, 0, 720, 1280, { orient = 2 }) -- 恶龙大通缉
            if x ~= -1 then
                baseUtils.tapSleep(x, y)
            end
        end
    else
        --baseUtils.toast("恶龙任务 - 未找到试炼入口 - 重试", 2)
        res = baseUtils.TomatoOCRTap(tomatoOCR, 233, 1205, 281, 1234, "行李") -- 尝试点击旅人切换页面，解决长时间停留首页，试炼按钮异常消失的情况（反作弊策略？）
        return shilianTask.shilian()
    end

    -- 判断是否重复挑战（已开启过宝箱）
    x1, y1 = findMultiColorInRegionFuzzy(0x5f4319,
        "4|0|0x5f4319,16|0|0x5e4318,13|-10|0xc38533,-5|-7|0xdfa33e,-5|8|0x5f4319,-5|20|0xbf7e2a,-5|28|0xf3d082,12|28|0xe4c17f,19|27|0xffe7a5,19|18|0xe19a39,6|25|0x50caff,6|21|0xaaddff,5|17|0xa390aa",
        90, 0, 0, 720, 1280, { orient = 2 }) -- 识别开启状态宝箱
    x2, y2 = findMultiColorInRegionFuzzy(0x5f3019,
        "4|0|0x5f3019,8|0|0x5f3019,10|0|0x5f3019,13|0|0x5f3019,17|0|0x5f3019,20|0|0x5f3019,20|4|0x5f3019,20|10|0xe1b07d,19|20|0xe08a44,16|21|0xebbf8d,11|22|0xad856a,5|22|0xa24023,1|22|0xd58445,-4|21|0xca5b33,-4|13|0xd9653a,9|21|0x6f9cb9,9|18|0x57adec,12|20|0x3b69cd,10|13|0xc6a390",
        90, 157, 885, 157, 885, { orient = 7 })
    if x ~= -1 or x2 ~= -1 then
        if 功能开关["恶龙-重复挑战"] == 0 then
            baseUtils.toast("恶龙任务 - 已领取宝箱 - 退出挑战")
            return
        end
    end

    --判断是否添加佣兵
    if 功能开关["恶龙-添加佣兵"] == 1 then
        baseUtils.toast("恶龙任务 - 添加佣兵")
        x, y = findMultiColorInRegionFuzzy(0xc0a67b,
            "-3|-1|0x9f7b55,-8|0|0xa7875f,-18|0|0x9f7b55,-20|0|0xead5a3,-23|-1|0xa88860,-25|-1|0xd2bb8d,-38|-1|0xbca176,-51|-1|0xd5bd8f,-60|-1|0xbda277,-60|6|0xb2946b,-42|6|0xb99d73,-31|6|0xc2a77c,-26|6|0xaa8b62,-5|5|0xdcc696",
            85, 0, 0, 720, 1280, { orient = 2 }) -- 创建队伍
        if x ~= -1 then
            baseUtils.tapSleep(x, y)
            baseUtils.tapSleep(370, 818) -- 点击 创建队伍 - 添加佣兵
            res = baseUtils.TomatoOCRTap(tomatoOCR, 310, 875, 407, 907, "创建队伍") -- 创建队伍 - 创建队伍
            res = baseUtils.TomatoOCRTap(tomatoOCR, 333, 974, 383, 1006, "开始")
            任务记录["试炼-恶龙-完成次数"] = 任务记录["试炼-恶龙-完成次数"] + 1
            return shilianTask.fighting()
        end
    end

    x, y = findMultiColorInRegionFuzzy(0xffffff,
        "6|0|0x6e89bb,8|0|0xffffff,15|0|0x6584b9,19|0|0xffffff,35|0|0xfbfbfc,51|0|0x6785b9,70|0|0xffffff,70|6|0xfefefe,49|8|0x879bc4,40|8|0x6584b9,34|8|0xffffff,20|9|0xffffff,14|9|0x6584b9,6|9|0x6e89bb",
        85, 0, 0, 720, 1280, { orient = 2 }) -- 开始匹配
    if x ~= -1 then
        baseUtils.tapSleep(x, y)

        res = baseUtils.TomatoOCRText(tomatoOCR, 321, 491, 397, 514, "选择职业")
        if res then
            baseUtils.toast("恶龙任务 - 选择职业")
            if 功能开关["职能-优先输出"] == 1 then
                baseUtils.tapSleep(280, 665) -- 职能输出
            elseif 功能开关["职能-优先坦克"] == 1 or 功能开关["职能-优先治疗"] == 1 then
                baseUtils.tapSleep(435, 665) -- 坦克
            else
                baseUtils.tapSleep(280, 665) -- 职能输出
            end
            res = baseUtils.TomatoOCRTap(tomatoOCR, 332, 754, 387, 789, "确定")
        end
    end

    -- 判断正在匹配中 - 循环等待300s
    local totalWait = 150 * 1000 -- 30000 毫秒 = 30 秒
    local elapsed = 0
    while 1 do
        if elapsed > totalWait then
            baseUtils.toast("恶龙任务 - 匹配超时")
            x, y = findMultiColorInRegionFuzzy(0xfffefd,
                "7|0|0xf9dcc7,15|0|0xf6c69d,40|0|0xf5bd89,52|-1|0xfffefd,53|7|0xffffff,47|7|0xfadfcc,39|7|0xf3a84d,32|7|0xfcf0e7,27|7|0xffffff,23|7|0xfefcfa,5|7|0xfffefe,6|14|0xffffff,23|14|0xfef9f6,38|14|0xffffff",
                75, 0, 0, 720, 1280, { orient = 2 }) -- 匹配中
            if x == -1 then
                x, y = findMultiColorInRegionFuzzy(0xf3a84b,
                    "14|0|0xf3aa55,47|-1|0xfffdfc,67|-1|0xfae1cf,85|-1|0xf3a84b,98|-1|0xf3a84b,105|-1|0xf3a84b,92|13|0xf3a84b,86|13|0xf3a84b,77|13|0xf3a84b,56|10|0xffffff,17|10|0xffffff,17|21|0xf3a84b,-3|19|0xf3a84b,-8|11|0xf3a94d",
                    75, 0, 0, 720, 1280, { orient = 2 }) -- 匹配中
                if x == -1 then
                    x, y = findMultiColorInRegionFuzzy(0xf3a84b,
                        "13|0|0xf3a84b,24|0|0xffffff,36|0|0xf3a84b,53|0|0xf3a84b,64|0|0xfffffe,67|0|0xfef7f2,78|0|0xfef9f6,95|0|0xf3a84b,112|0|0xf3a84b,110|10|0xf9c078,101|10|0xf3a84b,90|10|0xf3a84b,68|10|0xf3a84b,57|10|0xfdf3ec,39|10|0xf6c295",
                        80, 0, 0, 720, 1280, { orient = 2 })
                end
            end
            if x ~= -1 then
                -- 超时取消匹配
                baseUtils.tapSleep(x, y)
                baseUtils.toast("恶龙任务 - 匹配超时 - 取消匹配")
            end
            break
        end
        --baseUtils.toast("恶龙任务 - 匹配中")

        -- 判断无合适队伍，重新开始匹配
        res = baseUtils.TomatoOCRText(tomatoOCR, 229, 621, 305, 646, "匹配超时")
        if res then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 454, 727, 508, 758, "确定")
            if res then
                baseUtils.toast("恶龙任务 - 匹配超时 - 无队伍")
                elapsed = 0
            end
        end

        res2 = false
        if (isColor(313, 1086, 0xf3a84b, 90) and isColor(321, 1086, 0xf3a84b, 90) and isColor(321, 1090, 0xf3a84b, 90) and isColor(314, 1090, 0xf3a84b, 90) and isColor(314, 1095, 0xf3a84b, 90) and isColor(321, 1094, 0xf3a84b, 90) and isColor(321, 1101, 0xf3a84b, 90) and isColor(313, 1101, 0xf3a84b, 90) and isColor(313, 1106, 0xf3a84b, 90) and isColor(322, 1106, 0xf3a84b, 90)) then
            res2 = true -- 第三图匹配中
        end
        if res2 == false then
            res3 = false
            if (isColor(311, 887, 0xf3a84b, 90) and isColor(315, 887, 0xf3a84b, 90) and isColor(315, 892, 0xf3a84b, 90) and isColor(308, 892, 0xf3a84b, 90) and isColor(308, 897, 0xf3a84b, 90) and isColor(312, 897, 0xf3a84b, 90) and isColor(317, 903, 0xf3a84b, 90) and isColor(317, 910, 0xf3a84b, 90) and isColor(309, 910, 0xf3a84b, 90) and isColor(303, 910, 0xf3a84b, 90)) then
                res3 = true -- 第二图匹配中
            end
            if res3 == false then
                res4 = false
                if (isColor(310, 782, 0xf3a84b, 90) and isColor(316, 781, 0xf3a84b, 90) and isColor(319, 781, 0xf3a84b, 90) and isColor(318, 792, 0xf3a84b, 90) and isColor(311, 792, 0xf3a84b, 90) and isColor(311, 793, 0xf3a84b, 90) and isColor(311, 804, 0xf3a84b, 90) and isColor(315, 802, 0xf3a84b, 90) and isColor(324, 802, 0xf3a84b, 90) and isColor(324, 805, 0xf3a84b, 90) and isColor(320, 806, 0xf3a84b, 90) and isColor(315, 806, 0xf3a84b, 90) and isColor(304, 806, 0xf3a84b, 90)) then
                    res4 = true -- 第一图匹配中
                end
                if res4 == false then
                    x, y = findMultiColorInRegionFuzzy(0xfffefd,
                        "7|0|0xf9dcc7,15|0|0xf6c69d,40|0|0xf5bd89,52|-1|0xfffefd,53|7|0xffffff,47|7|0xfadfcc,39|7|0xf3a84d,32|7|0xfcf0e7,27|7|0xffffff,23|7|0xfefcfa,5|7|0xfffefe,6|14|0xffffff,23|14|0xfef9f6,38|14|0xffffff",
                        75, 0, 0, 720, 1280, { orient = 2 }) -- 匹配中
                    if x == -1 then
                        x2, y2 = findMultiColorInRegionFuzzy(0xf3a84b,
                            "14|0|0xf3aa55,47|-1|0xfffdfc,67|-1|0xfae1cf,85|-1|0xf3a84b,98|-1|0xf3a84b,105|-1|0xf3a84b,92|13|0xf3a84b,86|13|0xf3a84b,77|13|0xf3a84b,56|10|0xffffff,17|10|0xffffff,17|21|0xf3a84b,-3|19|0xf3a84b,-8|11|0xf3a94d",
                            75, 0, 0, 720, 1280, { orient = 2 }) -- 匹配中
                        if x2 == -1 then
                            x3, y3 = findMultiColorInRegionFuzzy(0xf3a84b,
                                "13|0|0xf3a84b,24|0|0xffffff,36|0|0xf3a84b,53|0|0xf3a84b,64|0|0xfffffe,67|0|0xfef7f2,78|0|0xfef9f6,95|0|0xf3a84b,112|0|0xf3a84b,110|10|0xf9c078,101|10|0xf3a84b,90|10|0xf3a84b,68|10|0xf3a84b,57|10|0xfdf3ec,39|10|0xf6c295",
                                80, 0, 0, 720, 1280, { orient = 2 })
                        end
                    end
                end
            end
        end

        res1 = shilianTask.WaitFight()
        if res1 == true then
            任务记录["试炼-恶龙-完成次数"] = 任务记录["试炼-恶龙-完成次数"] + 1
        end
        if res1 == true or (x == -1 and x2 == -1 and x3 == -1 and res2 == false and res3 == false and res4 == false and res5 == false) then -- 成功准备战斗 或 未匹配到
            break
        end

        baseUtils.mSleep3(5 * 1000)
        elapsed = elapsed + 5 * 1000
    end
end

-- 暴走史莱姆
function shilianTask.daBaoZou()
    baseUtils.toast("暴走史莱姆任务 - 开始", 0.3)

    if 功能开关["暴走-进入房间后启动"] == 1 then
        local totalWait = 150 * 1000
        local elapsed = 0
        -- 等待进入战斗
        while elapsed <= totalWait do
            if elapsed >= totalWait then
                baseUtils.toast("进入战斗失败 - 队友未准备")
                return false
            end

            baseUtils.toast("请操作进入战斗")
            res, teamName1 = baseUtils.TomatoOCRText(tomatoOCR, 8, 148, 51, 163, "队友名称")
            local nameS1 = string.find(teamName1, "等级")
            res, teamName2 = baseUtils.TomatoOCRText(tomatoOCR, 8, 146, 52, 166, "队友名称")
            local nameS2 = string.find(teamName2, "等级")

            if (nameS1 or nameS2) then
                baseUtils.toast("进入战斗成功 - 开始战斗", 0.5)
                shilianTask.fightingBaoZou()
                return true
            end
            baseUtils.mSleep3(5000)
            elapsed = elapsed + 5 * 1000
        end
    end

    ---- 返回首页
    dailyTask.homePage()
    ---- 退出组队
    dailyTask.quitTeam()

    -- 开始暴走
    res = baseUtils.TomatoOCRTap(tomatoOCR, 556, 380, 618, 404, "大暴走", 30, -10)
    baseUtils.mSleep3(2000)
    if res == false then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 554, 464, 622, 487, "大暴走", 30, -10) -- 适配新手试炼 - 下方大暴走入口
        baseUtils.mSleep3(2000)
    end

    -- 结算前一次的宝箱（兜底）
    res = baseUtils.TomatoOCRTap(tomatoOCR, 333, 715, 384, 745, "开启") -- 领取宝箱
    if res then
        baseUtils.toast("开启宝箱")
        baseUtils.mSleep3(2000)
        baseUtils.tapSleep(125, 1050) -- 领取后，点击空白
        baseUtils.tapSleep(125, 1050) -- 领取后，点击空白
    end

    hdPage = baseUtils.TomatoOCRText(tomatoOCR, 383, 573, 436, 605, "大王")
    if hdPage == false then
        return
    end

    res = shilianTask.startFightBaoZou()
end

-- 大暴走（雷电大王）
function shilianTask.daBaoZouLeiDian()
    local 走位状态 = ""
    local 水走位 = function()
        走位状态 = "水"
        for i = 1, 3 do
            x, y = findMultiColorInRegionFuzzy(0x7ac2cf,
                "0|-3|0x7bbec4,0|-6|0x91cdcf,1|-1|0x83c9cf,3|-5|0x90cdcf,3|-7|0x9ad0cf,3|-8|0x9cd2cf,5|-8|0x9cd2cf,12|-13|0xaed7cf,23|-4|0x90cdcd,26|1|0x71becc,20|10|0x59b9cf,20|7|0x5fbdcf,18|2|0x73c3cf,18|12|0x58b9cf,16|12|0x58bacf,12|12|0x57bacf,7|13|0x58b9cf,5|13|0x5ab8cf",
                85, 17, 632, 200, 758, { orient = 7 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y, 0)
                走位状态 = "水√"
                break
            end
            x2, y2 = findMultiColorInRegionFuzzy(0x7ac2cf,
                "0|-3|0x7bbec4,0|-6|0x91cdcf,1|-1|0x83c9cf,3|-5|0x90cdcf,3|-7|0x9ad0cf,3|-8|0x9cd2cf,5|-8|0x9cd2cf,12|-13|0xaed7cf,23|-4|0x90cdcd,26|1|0x71becc,20|10|0x59b9cf,20|7|0x5fbdcf,18|2|0x73c3cf,18|12|0x58b9cf,16|12|0x58bacf,12|12|0x57bacf,7|13|0x58b9cf,5|13|0x5ab8cf",
                90, 17, 632, 200, 758, { orient = 7 })
            if x2 ~= -1 then
                baseUtils.tapSleep(x2, y2, 0)
                走位状态 = "水√"
                break
            end
        end
    end
    local 火走位 = function()
        走位状态 = "火"
        for i = 1, 3 do
            x, y = findMultiColorInRegionFuzzy(0xe2755e,
                "0|-4|0xe17d61,0|-18|0xdaac86,0|-15|0xe2ac85,3|-15|0xe2aa84,8|-20|0xe2b692,9|-14|0xe1a07f,16|-14|0xe1a581,17|-10|0xe29774,19|-8|0xe28d6e,19|-4|0xe17f60,17|3|0x47414b,17|1|0xdf6d52,16|1|0xbe6250,9|-2|0x323c4a,4|-2|0x323c4a,7|-3|0x323c4a,10|-6|0x323c4a,34|-4|0xe2645d,34|-12|0xd56755,-15|-15|0x744c4b,-16|-11|0xe26c58",
                75, 17, 632, 200, 758, { orient = 7 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y, 0)
                走位状态 = "火√"
                break
            end
        end
    end
    local 草走位 = function()
        走位状态 = "草"
        for i = 1, 3 do
            x, y = findMultiColorInRegionFuzzy(0xb5d6ab,
                "3|1|0xb1d6a8,6|1|0xb1d4a2,9|1|0x799a76,12|1|0xb5d5a8,17|1|0xb5d5a8,20|3|0x62876a,15|3|0xadd6a5,18|-6|0xcedab1,18|-9|0x2b4b42,18|-11|0x323d49,13|-11|0x323c4a,-2|-11|0x323c4a,-6|-17|0x69bd49,1|-20|0x66b536,12|-17|0x334847,18|-16|0x398134,24|-15|0x56a936,-14|2|0x386c38",
                85, 17, 632, 200, 758, { orient = 7 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y, 0)
                走位状态 = "草√"
                break
            end
        end
    end

    for i = 1, 5 do
        local boss状态 = commonVar["bossStatus"]
        local user状态 = commonVar["userStatus"]
        -- 识别开花
        if user状态 == "开花" then
            if boss状态 == "草" then
                水走位()
            elseif boss状态 == "水" then
                草走位()
            end
            break
        end

        -- 识别篝火
        if user状态 == "篝火" then
            if boss状态 == "火" then
                草走位()
            end
            if boss状态 == "草" then
                火走位()
            end
            break
        end

        -- 识别蒸汽
        if user状态 == "蒸汽" then
            if boss状态 == "火" then
                水走位()
            end
            if boss状态 == "水" then
                火走位()
            end
            break
        end
        if user状态 ~= "" then
            break
        end
    end
    if commonVar["bossStatus"] ~= "" and commonVar["userStatus"] ~= "" then
        baseUtils.toast(commonVar["bossStatus"] .. " + " .. commonVar["userStatus"] .. " = " .. 走位状态, 0.8)
    end
end

-- 秘境之间
function shilianTask.mijiing()
    baseUtils.toast("秘境任务 - 开始", 0.3)

    -- 返回首页
    dailyTask.homePage()
    -- 退出组队
    dailyTask.quitTeam()

    selectMap = map[功能开关["秘境地图"] + 1]
    selectStage = stage[功能开关["秘境地图"] + 1][功能开关["秘境关卡"] + 1]

    res = baseUtils.TomatoOCRTap(tomatoOCR, 650, 522, 688, 544, "试炼")
    if res then
        --res = baseUtils.TomatoOCRTap(tomatoOCR, 380, 112, 558, 154, "秘境之间") -- 低等级只有4张试炼图，区域识别错误；改为全局图色识别
        if (isColor(174, 111, 0xede3d1, 90) and isColor(181, 111, 0xf3eddd, 90) and isColor(188, 111, 0x887e74, 90) and isColor(205, 113, 0x797277, 90) and isColor(205, 125, 0xac8d7e, 90) and isColor(205, 137, 0xc98078, 90) and isColor(204, 154, 0x73424b, 90) and isColor(179, 176, 0xd4cfc5, 90) and isColor(179, 192, 0x1e1a2c, 90) and isColor(193, 193, 0x14111f, 90) and isColor(214, 193, 0x5d2330, 90) and isColor(227, 193, 0xb7424d, 90) and isColor(223, 203, 0x49323b, 90) and isColor(219, 207, 0x8c3540, 90)) then
            baseUtils.tapSleep(220, 170, 0.8) -- 5图秘境之间
        else
            x, y = findMultiColorInRegionFuzzy(0xe9faff,
                "0|20|0xbdefff,0|30|0xa1e9ff,11|29|0xa3e9fe,23|29|0xa4eaff,41|29|0x3b455a,53|29|0xa5eaff,53|20|0xbdefff,53|10|0xc1dfea,60|10|0xccebf6,69|10|0xccebf6,69|24|0x638090,68|31|0x9fe9ff,62|-5|0xf1fdff",
                80, 0, 0, 720, 1280, { orient = 2 }) -- 秘境之间
            if x ~= -1 then
                baseUtils.tapSleep(x, y, 1)
            end
        end
    else
        --baseUtils.toast("秘境任务 - 未找到试炼入口 - 重新尝试")
        res = baseUtils.TomatoOCRTap(tomatoOCR, 233, 1205, 281, 1234, "行李") -- 尝试点击旅人切换页面，解决长时间停留首页，试炼按钮异常消失的情况（反作弊策略？）
        return shilianTask.shilian()
    end

    --startUp.noticeCancel() -- 偶现异常处理
    shilianTask.openTreasure()

    res = shilianTask.changeMap(selectMap, selectStage)
    if res == false then
        return
    end
    --startUp.noticeCancel() -- 偶现异常处理
    res = shilianTask.startFight()
end

-- 切换地图
function shilianTask.changeMap(selectMap, selectStage)
    --baseUtils.toast("秘境任务 - 切换地图")

    baseUtils.tapSleep(74, 160, 2.5) -- 点击地图列表

    local mapPoi = mapPoi[selectMap]
    local mapNum = tonumber(功能开关["秘境地图"])
    if mapNum > 5 then -- 火山之后的地图，需翻页
        moveTo(150, 700, 150, 300, 100)
        baseUtils.mSleep3(2000);
    else
        -- 判断是否已在第一屏
        res = baseUtils.TomatoOCRText(tomatoOCR, 110, 235, 175, 267, "原野")
        if res then
        else
            -- 向上滚动第一屏
            moveTo(150, 300, 150, 700, 100)
            baseUtils.mSleep3(2000);
        end
    end
    res = baseUtils.TomatoOCRTap(tomatoOCR, mapPoi[1], mapPoi[2], mapPoi[3], mapPoi[4], selectMap, 3, 3)
    local stagePoi = stagePoi[selectStage]
    res = baseUtils.TomatoOCRTap(tomatoOCR, stagePoi[1], stagePoi[2], stagePoi[3], stagePoi[4], selectStage)
    if res == false then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 303, 342, 468, 371, selectStage)     -- 兼容默认识别第一图
        if res == false then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 304, 375, 468, 403, selectStage) -- 兼容默认识别第一图
        end
        if res == false then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 302, 535, 470, 568, selectStage) -- 兼容默认识别第二图
        end
        if res == false then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 287, 559, 501, 600, selectStage) -- 兼容默认识别第二图
        end
        if res == false then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 303, 731, 469, 759, selectStage) -- 兼容默认识别第三图
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

-- 大暴走战斗
function shilianTask.fightingBaoZou()
    local totalWait = 330 * 1000 -- 30000 毫秒 = 30 秒
    local elapsed = 0

    local teamShoutDone = 0
    while 1 do
        -- 识别战斗中状态
        res, teamName1 = baseUtils.TomatoOCRText(tomatoOCR, 10, 148, 50, 162, "队友名称") -- 队友2
        local teamNameStatus1 = string.find(teamName1, "等级") ~= nil
        res, teamName2 = baseUtils.TomatoOCRText(tomatoOCR, 10, 198, 51, 213, "队友名称") -- 队友3
        local teamNameStatus2 = string.find(teamName1, "等级") ~= nil
        fightStatus1 = baseUtils.TomatoOCRText(tomatoOCR, 645, 779, 688, 808, "喊话") -- 喊话

        --if (teamName1 ~= "" or teamName2 ~= "") then
        --if teamShoutDone == 0 then
        --    teamShoutDone = shilianTask.teamShout()
        --end

        -- 大暴走可跟队友影子继续战斗，无需判断队友是否在队伍中
        if teamNameStatus1 and teamNameStatus2 and fightStatus1 then
            toast("战斗中", 0.3)
            commonVar["fighting"] = 1
        else
            commonVar["fighting"] = 0
        end
        -- 战斗逻辑
        --循环10次，优先处理战斗中走位
        if teamNameStatus1 and teamNameStatus2 and fightStatus1 then
            for i = 1, 10 do
                if 功能开关["暴走-暴走雷电大王"] == 1 then
                    shilianTask.daBaoZouLeiDian()
                end
                -- 战斗结束
                res2 = baseUtils.TomatoOCRTap(tomatoOCR, 334, 1090, 385, 1117, "开启") -- 领取宝箱
                res3 = baseUtils.TomatoOCRTap(tomatoOCR, 332, 1067, 387, 1096, "开启") -- 领取宝箱
                if res2 or res3 then
                    baseUtils.toast("战斗结束 - 战斗胜利")
                    baseUtils.tapSleep(55, 1140) -- 领取后，点击空白
                    baseUtils.tapSleep(55, 1140) -- 领取后，点击空白
                    break
                end
            end
        end

        -- 判断是否战斗失败（战斗5分钟后）
        if teamNameStatus1 == false and teamNameStatus2 == false and fightStatus1 == false then
            commonVar["fighting"] = 0
            -- 战斗结束
            res1 = baseUtils.TomatoOCRTap(tomatoOCR, 333, 716, 384, 744, "开启") -- 领取宝箱
            res2 = baseUtils.TomatoOCRTap(tomatoOCR, 334, 1090, 385, 1117, "开启") -- 领取宝箱
            res3 = baseUtils.TomatoOCRTap(tomatoOCR, 332, 1067, 387, 1096, "开启") -- 领取宝箱
            if res1 or res2 or res3 then
                baseUtils.toast("战斗结束 - 战斗胜利")
                baseUtils.mSleep3(2000)
                baseUtils.tapSleep(55, 1140) -- 领取后，点击空白
                break
            end
            res3 = baseUtils.TomatoOCRText(tomatoOCR, 499, 191, 581, 215, "离开队伍") -- 已返回队伍
            if res3 then
                baseUtils.toast("战斗结束")
                break
            end
            quitStatus = dailyTask.quitTeam()
            if quitStatus then
                break
            end
            commonVar["fighting"] = 0
        end
    end
    commonVar["fighting"] = 0
end

-- 大暴走开始匹配
function shilianTask.startFightBaoZou()
    --创建队伍
    --if 功能开关["暴走-创建房间"] == 1 then
    --    resStart1 = baseUtils.TomatoOCRTap(tomatoOCR, 311, 697, 405, 725, "开始匹配") -- 图1
    --    if resStart1 == false then
    --        resStart2 = baseUtils.TomatoOCRTap(tomatoOCR, 309, 892, 407, 918, "开始匹配") -- 图2
    --        if resStart2 == false then
    --            resStart3 = baseUtils.TomatoOCRTap(tomatoOCR, 311, 1084, 405, 1116, "开始匹配") -- 图3
    --        end
    --    end
    --
    --    if resStart1 == false and resStart2 == false and resStart3 == false then
    --        return
    --    end
    --end

    -- 直接开始匹配
    res = baseUtils.TomatoOCRTap(tomatoOCR, 311, 1156, 407, 1182, "开始匹配", 40, -40)
    baseUtils.toast("大暴走 - 开始匹配", 0.5)

    -- 判断职业选择
    res = baseUtils.TomatoOCRText(tomatoOCR, 321, 491, 397, 514, "选择职业")
    if res then
        baseUtils.toast("大暴走 - 选择职业")
        if 功能开关["职能-优先输出"] == 1 then
            baseUtils.tapSleep(280, 665, 1) -- 职能输出
        elseif 功能开关["职能-优先坦克"] == 1 or 功能开关["职能-优先治疗"] == 1 then
            baseUtils.tapSleep(435, 665, 1) -- 坦克
        else
            baseUtils.tapSleep(280, 665, 1) -- 职能输出
        end
        res = baseUtils.TomatoOCRTap(tomatoOCR, 332, 754, 387, 789, "确定")
    end

    -- 判断正在匹配中 - 循环等待300s
    local totalWait = 150 * 1000 -- 30000 毫秒 = 30 秒
    local elapsed = 0
    while 1 do
        if elapsed > totalWait then
            -- 超时取消匹配
            res = baseUtils.TomatoOCRTap(tomatoOCR, 311, 1156, 407, 1182, "匹配中", 40, -40)
            if res == false then
                res = baseUtils.TomatoOCRTap(tomatoOCR, 325, 1156, 390, 1182, "匹配中", 40, -40)
                if res == false then
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 321, 1151, 393, 1185, "匹配中", 40, -40)
                end
            end
            break
        end
        --baseUtils.toast("秘境任务 - 匹配中")

        -- 判断无合适队伍，重新开始匹配
        res = baseUtils.TomatoOCRText(tomatoOCR, 231, 624, 305, 645, "匹配超时")
        if res then
            baseUtils.toast("大暴走 - 匹配超时 - 无合适队伍 - 重新匹配")
            res = baseUtils.TomatoOCRTap(tomatoOCR, 451, 727, 510, 757, "确定")
            if res then
                elapsed = 0
            end
        end

        waitStatus = baseUtils.TomatoOCRText(tomatoOCR, 311, 1156, 407, 1182, "匹配中")
        if waitStatus == false then
            waitStatus = baseUtils.TomatoOCRText(tomatoOCR, 325, 1156, 390, 1182, "匹配中")
            if waitStatus == false then
                res, waitTime = baseUtils.TomatoOCRText(tomatoOCR, 334, 1184, 383, 1201, "等待时间")
                if waitTime ~= "" then
                    waitStatus = true
                end
            end
        end

        res1 = shilianTask.WaitFight("暴走")
        if res1 == true or (waitStatus == false) then -- 成功准备战斗 或 未匹配到
            -- 超时取消匹配
            res = baseUtils.TomatoOCRTap(tomatoOCR, 311, 1156, 407, 1182, "匹配中", 40, -40)
            if res == false then
                res = baseUtils.TomatoOCRTap(tomatoOCR, 325, 1156, 390, 1182, "匹配中", 40, -40)
                if res == false then
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 321, 1151, 393, 1185, "匹配中", 40, -40)
                end
            end
            break
        end

        baseUtils.mSleep3(5 * 1000)
        elapsed = elapsed + 5 * 1000
    end
end

-- 开始匹配
function shilianTask.startFight()
    -- 识别剩余体力不足40时，尝试补充
    res2, availableTiLi = baseUtils.TomatoOCRText(tomatoOCR, 605, 81, 630, 100, "剩余体力") -- 20/60
    availableTiLi = tonumber(availableTiLi)
    if 功能开关["秘境-不开宝箱"] == 0 and (availableTiLi == nil or availableTiLi < 40) then -- 识别剩余体力不足40时，尝试补充
        shilianTask.tili()
    end

    -- 判断体力不足，退出挑战
    res2, availableTiLi = baseUtils.TomatoOCRText(tomatoOCR, 605, 81, 630, 100, "剩余体力") -- 20/60
    availableTiLi = tonumber(availableTiLi)
    if availableTiLi == nil or availableTiLi < 20 then -- 识别剩余体力不足20时
        -- 体力消耗完成
        任务记录["试炼-秘境-体力消耗完成"] = 1
        if 功能开关["秘境-体力不足继续挑战"] == 0 then
            baseUtils.toast("秘境任务 - 体力不足 - 退出挑战")
            return
        end
    end

    --判断是否添加佣兵
    if 功能开关["秘境-添加佣兵"] == 1 then
        baseUtils.toast("秘境任务 - 添加佣兵")
        x, y = findMultiColorInRegionFuzzy(0x9f7c55,
            "0|4|0xb1936a,-1|9|0xc0a57a,9|13|0x9f7c56,10|7|0xbea378,10|2|0xbea378,18|2|0xd0b88a,23|2|0xa07e57,27|1|0xaa8b62,27|7|0xae8f67,26|11|0xe9d4a2,35|7|0xebd6a4,39|6|0xefdba8,43|5|0xdcc595,45|4|0xf4e0ac,49|4|0xe9d4a2,53|4|0xd1ba8c,55|4|0xeedaa7,61|3|0xf4e0ac,63|5|0xc5ab80",
            85, 0, 0, 720, 1280, { orient = 2 }) -- 创建队伍
        if x ~= -1 then
            baseUtils.tapSleep(x, y)

            -- 判断体力用尽提示
            res1 = baseUtils.TomatoOCRText(tomatoOCR, 242, 598, 314, 616, "体力不足")
            if res1 then
                if 功能开关["秘境-体力不足继续挑战"] then
                    --baseUtils.toast("秘境任务 - 体力不足继续挑战")
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 334, 743, 385, 771, "确定")
                else
                    baseUtils.toast("秘境任务 - 体力不足")
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 64, 1200, 128, 1234, "返回")
                    shilianTask.tili()
                end
            end

            baseUtils.tapSleep(365, 820) -- 点击 创建队伍 - 添加佣兵
            res = baseUtils.TomatoOCRTap(tomatoOCR, 313, 876, 407, 907, "创建队伍") -- 创建队伍 - 创建队伍
            res = baseUtils.TomatoOCRTap(tomatoOCR, 333, 974, 383, 1006, "开始")

            -- 判断体力用尽提示
            res1 = baseUtils.TomatoOCRText(tomatoOCR, 242, 598, 314, 616, "体力不足")
            if res1 then
                if 功能开关["秘境-体力不足继续挑战"] then
                    --baseUtils.toast("秘境任务 - 体力不足继续挑战")
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 334, 743, 385, 771, "确定")
                else
                    baseUtils.toast("秘境任务 - 体力不足")
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 64, 1200, 128, 1234, "返回")
                    shilianTask.tili()
                end
            end

            return shilianTask.fighting()
        end
    end

    --判断是否创建房间
    if 功能开关["秘境-创建房间"] == 1 then
        baseUtils.toast("秘境任务 - 创建房间", 0.5)
        x, y = findMultiColorInRegionFuzzy(0x9f7c55,
            "0|4|0xb1936a,-1|9|0xc0a57a,9|13|0x9f7c56,10|7|0xbea378,10|2|0xbea378,18|2|0xd0b88a,23|2|0xa07e57,27|1|0xaa8b62,27|7|0xae8f67,26|11|0xe9d4a2,35|7|0xebd6a4,39|6|0xefdba8,43|5|0xdcc595,45|4|0xf4e0ac,49|4|0xe9d4a2,53|4|0xd1ba8c,55|4|0xeedaa7,61|3|0xf4e0ac,63|5|0xc5ab80",
            90, 0, 0, 720, 1280, { orient = 2 }) -- 创建队伍
        if x ~= -1 then
            baseUtils.tapSleep(x, y, 1)

            -- 判断体力用尽提示
            res1 = baseUtils.TomatoOCRText(tomatoOCR, 242, 598, 314, 616, "体力不足")
            if res1 then
                if 功能开关["秘境-体力不足继续挑战"] then
                    --baseUtils.toast("秘境任务 - 体力不足继续挑战")
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 334, 743, 385, 771, "确定")
                else
                    baseUtils.toast("秘境任务 - 体力不足")
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 64, 1200, 128, 1234, "返回")
                    shilianTask.tili()
                end
            end

            res = baseUtils.TomatoOCRTap(tomatoOCR, 313, 876, 407, 907, "创建队伍") -- 创建队伍 - 创建队伍

            --等待队员（120s超时）
            local totalWait = 120 * 1000 -- 30000 毫秒 = 30 秒
            local elapsed = 0
            local aleadyFightCt = 0
            local needFightCt = tonumber(功能开关["秘境-房间挑战次数"])
            if needFightCt == nil then
                needFightCt = 1
            end
            while 1 do
                shilianTask.openTreasure()
                --返回房间
                res1 = baseUtils.TomatoOCRTap(tomatoOCR, 635, 628, 705, 653, "正在组队")
                if res1 == false then
                    res2 = baseUtils.TomatoOCRTap(tomatoOCR, 631, 558, 699, 581, "正在组队")
                    if res2 == false then
                        res3 = baseUtils.TomatoOCRTap(tomatoOCR, 632, 570, 684, 598, "匹配中")
                    end
                end
                -- 返回房间 - 队伍满员，开始挑战提醒
                res = baseUtils.TomatoOCRText(tomatoOCR, 396, 622, 468, 650, "开启挑战") -- 队伍已满员，准备开启挑战
                if res then
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 455, 726, 509, 760, "确定") -- 队伍已满员，准备开启挑战 - 确定
                    res3 = baseUtils.TomatoOCRTap(tomatoOCR, 333, 974, 383, 1006, "开始")
                end

                -- 等待开始
                if aleadyFightCt >= needFightCt or elapsed > totalWait then
                    if aleadyFightCt >= needFightCt then
                        baseUtils.toast("秘境任务 - 挑战次数" .. aleadyFightCt .. "/" .. needFightCt .. "达成 - 结束")
                    end
                    if elapsed > totalWait then
                        baseUtils.toast("秘境任务 - 等待队友2min超时 - 结束")
                    end
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 502, 192, 581, 215, "离开队伍") -- 点击离开队伍
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 330, 728, 385, 759, "确定") -- 确定离开队伍
                    dailyTask.quitTeam()
                    break
                end
                res = baseUtils.TomatoOCRTap(tomatoOCR, 333, 974, 383, 1006, "开始")
                baseUtils.toast("秘境任务 - 创建房间 - 等待队友")
                if res then
                    baseUtils.toast("秘境任务 - 重复挑战第" .. aleadyFightCt + 1 .. "/" .. needFightCt .. "次")
                    -- 满员开始，退出循环
                    -- 判断体力用尽提示
                    res1 = baseUtils.TomatoOCRText(tomatoOCR, 242, 598, 314, 616, "体力不足")
                    if res1 then
                        if 功能开关["秘境-体力不足继续挑战"] then
                            --baseUtils.toast("秘境任务 - 体力不足继续挑战")
                            res = baseUtils.TomatoOCRTap(tomatoOCR, 334, 743, 385, 771, "确定")
                        else
                            baseUtils.toast("秘境任务 - 体力不足")
                            res = baseUtils.TomatoOCRTap(tomatoOCR, 64, 1200, 128, 1234, "返回")
                            shilianTask.tili()
                        end
                    end

                    -- 等待进入战斗
                    for i = 1, 4 do
                        --返回房间
                        res1 = baseUtils.TomatoOCRTap(tomatoOCR, 635, 628, 705, 653, "正在组队")
                        if res1 == false then
                            res2 = baseUtils.TomatoOCRTap(tomatoOCR, 631, 558, 699, 581, "正在组队")
                            if res2 == false then
                                res3 = baseUtils.TomatoOCRTap(tomatoOCR, 632, 570, 684, 598, "匹配中")
                            end
                        end
                        -- 返回房间 - 队伍满员，开始挑战提醒
                        res = baseUtils.TomatoOCRText(tomatoOCR, 396, 622, 468, 650, "开启挑战") -- 队伍已满员，准备开启挑战
                        if res then
                            res = baseUtils.TomatoOCRTap(tomatoOCR, 455, 726, 509, 760, "确定") -- 队伍已满员，准备开启挑战 - 确定
                            res3 = baseUtils.TomatoOCRTap(tomatoOCR, 333, 974, 383, 1006, "开始")
                        end

                        res = baseUtils.TomatoOCRTap(tomatoOCR, 333, 974, 383, 1006, "开始")
                        res, teamName1 = baseUtils.TomatoOCRText(tomatoOCR, 8, 148, 51, 163, "队友名称")
                        local nameS1 = string.find(teamName1, "等级")
                        res, teamName2 = baseUtils.TomatoOCRText(tomatoOCR, 8, 146, 52, 166, "队友名称")
                        local nameS2 = string.find(teamName2, "等级")

                        if (nameS1 or nameS2) then
                            baseUtils.toast("秘境任务 - 匹配成功 - 进入战斗")
                            shilianTask.fighting()
                            aleadyFightCt = aleadyFightCt + 1
                            elapsed = 0 -- 初始化等待队员时间
                            fightDone = 1
                            break
                        end
                        --进入战斗失败，重新匹配
                        baseUtils.mSleep3(5000)
                    end
                end
                -- 等待队员
                baseUtils.mSleep3(4 * 1000)
                elapsed = elapsed + 4 * 1000
            end
        end
        return
    end

    resStart1 = baseUtils.TomatoOCRTap(tomatoOCR, 311, 697, 405, 725, "开始匹配") -- 图1
    if resStart1 == false then
        resStart2 = baseUtils.TomatoOCRTap(tomatoOCR, 309, 892, 407, 918, "开始匹配") -- 图2
        if resStart2 == false then
            resStart3 = baseUtils.TomatoOCRTap(tomatoOCR, 311, 1084, 405, 1116, "开始匹配") -- 图3
        end
    end

    if resStart1 == false and resStart2 == false and resStart3 == false then
        return
    end
    baseUtils.toast("秘境任务 - 开始匹配", 0.5)

    -- 判断体力用尽提示
    res1 = baseUtils.TomatoOCRText(tomatoOCR, 242, 598, 314, 616, "体力不足")
    if res1 then
        if 功能开关["秘境-体力不足继续挑战"] then
            --baseUtils.toast("秘境任务 - 体力不足继续挑战")
            res = baseUtils.TomatoOCRTap(tomatoOCR, 334, 743, 385, 771, "确定")
        else
            baseUtils.toast("秘境任务 - 体力不足")
            res = baseUtils.TomatoOCRTap(tomatoOCR, 64, 1200, 128, 1234, "返回")
            shilianTask.tili()
        end
    end

    -- 判断职业选择
    res = baseUtils.TomatoOCRText(tomatoOCR, 321, 491, 397, 514, "选择职业")
    if res then
        baseUtils.toast("秘境任务 - 选择职业")
        if 功能开关["职能-优先输出"] == 1 then
            baseUtils.tapSleep(280, 665, 1) -- 职能输出
        elseif 功能开关["职能-优先坦克"] == 1 or 功能开关["职能-优先治疗"] == 1 then
            baseUtils.tapSleep(435, 665, 1) -- 坦克
        else
            baseUtils.tapSleep(280, 665, 1) -- 职能输出
        end
        res = baseUtils.TomatoOCRTap(tomatoOCR, 332, 754, 387, 789, "确定")
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
                if res == false then
                    res4 = baseUtils.TomatoOCRTap(tomatoOCR, 324, 1080, 392, 1103, "匹配中") -- 图3
                    if res4 == false then
                        x, y = findMultiColorInRegionFuzzy(0xf3a84b,
                            "-1|15|0xf3a84b,9|16|0xf3a84b,8|1|0xf3a84b,27|4|0xf3ab59,41|4|0xfdf1ea,57|5|0xfef9f6,67|1|0xffffff,74|6|0xf3a84b,85|5|0xf3a84b,96|7|0xf3a84b,92|15|0xf3a84b,80|11|0xf3a84b",
                            85, 0, 0, 720, 1280, { orient = 2 }) -- 匹配中
                        if x ~= -1 then
                            baseUtils.tapSleep(x, y)
                        end
                    end
                end
            end
            break
        end
        --baseUtils.toast("秘境任务 - 匹配中")

        -- 判断无合适队伍，重新开始匹配
        res = baseUtils.TomatoOCRText(tomatoOCR, 303, 607, 418, 632, "暂无合适队伍")
        if res then
            baseUtils.toast("秘境任务 - 匹配超时 - 无合适队伍")
            res = baseUtils.TomatoOCRTap(tomatoOCR, 210, 727, 262, 758, "取消")
            if res then
                elapsed = 0
            end
        end

        res2 = baseUtils.TomatoOCRText(tomatoOCR, 320, 692, 392, 716, "匹配中") -- 图1
        if res2 == false then
            res3 = baseUtils.TomatoOCRText(tomatoOCR, 323, 886, 394, 910, "匹配中") -- 图2
            if res3 == false then
                res4 = baseUtils.TomatoOCRText(tomatoOCR, 324, 1080, 392, 1103, "匹配中") -- 图3
                if res4 == false then
                    x, y = findMultiColorInRegionFuzzy(0xf3a84b,
                        "-1|15|0xf3a84b,9|16|0xf3a84b,8|1|0xf3a84b,27|4|0xf3ab59,41|4|0xfdf1ea,57|5|0xfef9f6,67|1|0xffffff,74|6|0xf3a84b,85|5|0xf3a84b,96|7|0xf3a84b,92|15|0xf3a84b,80|11|0xf3a84b",
                        85, 0, 0, 720, 1280, { orient = 2 }) -- 匹配中
                    if x ~= -1 then
                        res5 = true
                    end
                end
            end
        end

        res1 = shilianTask.WaitFight()
        if res1 == true or (res2 == false and res3 == false and res4 == false and res5 == false) then -- 成功准备战斗 或 未匹配到
            break
        end

        baseUtils.mSleep3(5 * 1000)
        elapsed = elapsed + 5 * 1000
    end
end

-- 等待匹配
function shilianTask.WaitFight(fightType)
    fightType = fightType or "秘境"
    local res1 = baseUtils.TomatoOCRTap(tomatoOCR, 457, 607, 502, 631, "准备") -- 秘境准备
    local res2 = baseUtils.TomatoOCRTap(tomatoOCR, 453, 650, 505, 684, "准备") -- 恶龙准备
    local res3 = false

    -- 队伍满员，开始挑战
    res = baseUtils.TomatoOCRText(tomatoOCR, 396, 622, 468, 650, "开启挑战") -- 队伍已满员，准备开启挑战
    if res then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 455, 726, 509, 760, "确定") -- 队伍已满员，准备开启挑战 - 确定
        res3 = baseUtils.TomatoOCRTap(tomatoOCR, 333, 974, 383, 1006, "开始")
    end

    if res1 == true or res2 == true or res3 == true then
        baseUtils.toast("匹配成功 - 等待进入战斗")
        local totalWait = 20 * 1000
        local elapsed = 0

        -- 等待进入战斗
        while elapsed <= totalWait do
            if elapsed >= totalWait then
                baseUtils.toast("进入战斗失败 - 队友未准备")
                return false
            end

            res = baseUtils.TomatoOCRTap(tomatoOCR, 333, 974, 383, 1006, "开始")
            res, teamName1 = baseUtils.TomatoOCRText(tomatoOCR, 8, 148, 51, 163, "队友名称")
            local nameS1 = string.find(teamName1, "等级")
            res, teamName2 = baseUtils.TomatoOCRText(tomatoOCR, 8, 146, 52, 166, "队友名称")
            local nameS2 = string.find(teamName2, "等级")

            if (nameS1 or nameS2) then
                baseUtils.toast("进入战斗成功 - 开始战斗", 0.5)
                if fightType == "秘境" then
                    shilianTask.fighting()
                end
                if fightType == "暴走" then
                    shilianTask.fightingBaoZou()
                end
                return true
            end
            baseUtils.mSleep3(5000)
            elapsed = elapsed + 5 * 1000
        end
    end

    return false
end

-- 购买体力
function shilianTask.tili()
    baseUtils.toast("体力购买 - 开始", 0.5)

    x, y = findMultiColorInRegionFuzzy(0xf6e681,
        "7|0|0xf4de74,3|0|0xf4e379,2|12|0xf2d266,3|5|0xf4d96c,-2|3|0xf4e079,-2|6|0xf2da73,10|8|0xf5dc82,6|10|0xefcf6f,3|13|0xdda365,7|12|0xd79760,10|10|0xd89761,11|-1|0xda9f60,9|2|0xd89f61",
        90, 0, 0, 720, 1280, { orient = 2 })
    if x == -1 then
        baseUtils.toast("体力购买 - 识别入口失败")
        return
    end

    baseUtils.tapSleep(690, 90) -- 点击补充体力加号

    attempt = 0
    while attempt < 3 do
        res, count = baseUtils.TomatoOCRText(tomatoOCR, 500, 817, 515, 834, "0")
        local buyCount = tonumber(count)
        if buyCount == nil then
            buyCount = 0
        end
        local needCount = tonumber(功能开关["补充体力次数"])
        if needCount == nil then
            needCount = 0
        end
        if buyCount < needCount then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 456, 873, 499, 898, "购买")
            baseUtils.toast("体力购买 - 成功")
        else
            break
        end
        attempt = attempt + 1
    end

    --baseUtils.toast("体力购买 - 结束")
    baseUtils.tapSleep(61, 1187) -- 返回

    return
end

-- 判断是否战斗中
function shilianTask.fighting()
    local totalWait = 300 * 1000 -- 30000 毫秒 = 30 秒
    local elapsed = 0

    local teamShoutDone = 0
    while 1 do
        if elapsed >= totalWait then
            baseUtils.toast("战斗结束 - 超时退出组队")
            shilianTask.quitTeam() -- 退出队伍
            break
        end

        -- 识别战斗中状态
        res, teamName1 = baseUtils.TomatoOCRText(tomatoOCR, 8, 148, 51, 163, "队友名称")
        res, teamName2 = baseUtils.TomatoOCRText(tomatoOCR, 8, 146, 52, 166, "队友名称")

        if (teamName1 ~= "" or teamName2 ~= "") then
            if teamShoutDone == 0 then
                teamShoutDone = shilianTask.teamShout()
            end

            -- 切换手动操作
            if 功能开关["通用-主动释放技能"] == 1 then
                if 功能开关["通用-三技能打断"] == 1 then
                    if (isColor(286, 268, 0x46f5fe, 80) or isColor(290, 268, 0x4bf4fd, 80) or isColor(294, 268, 0x52f3ff, 80) or isColor(294, 271, 0x52f3ff, 80) or isColor(289, 271, 0x4bf5fd, 80) or isColor(283, 271, 0x43f4fd, 80)) then
                        baseUtils.tapSleep(649, 953, 0.6) -- 3技能 -- 打断技
                        baseUtils.tapSleep(659, 942, 0.6) -- 3技能 -- 打断技
                    end
                    if (isColor(412, 268, 0xd7d7d7, 80) and isColor(425, 269, 0xd7d7d7, 80) and isColor(439, 266, 0xd7d7d7, 80) and isColor(449, 269, 0xd7d7d7, 80)) then
                        baseUtils.tapSleep(649, 953, 0.6) -- 3技能 -- 护盾技
                        baseUtils.tapSleep(659, 942, 0.6) -- 3技能 -- 护盾技
                    end
                else
                    baseUtils.tapSleep(649, 953, 0.6) -- 3技能
                    baseUtils.tapSleep(659, 942, 0.6) -- 3技能
                end
                res = baseUtils.TomatoOCRTap(tomatoOCR, 644, 878, 687, 902, "自动", 10, -10)
                --baseUtils.tapSleep(640, 1075, 0.5) -- 核心技能（自动释放）
                --baseUtils.tapSleep(644, 1080, 0.5) -- 核心技能
                baseUtils.tapSleep(511, 1076, 0.6) -- 1技能
                baseUtils.tapSleep(521, 1070, 0.6) -- 1技能
                baseUtils.tapSleep(543, 974, 0.6)  -- 2技能
                baseUtils.tapSleep(544, 962, 0.6)  -- 2技能
                baseUtils.tapSleep(421, 1077, 0.6) -- 宠物技能
                baseUtils.tapSleep(426, 1067, 0.6) -- 宠物技能
            else
                res = baseUtils.TomatoOCRTap(tomatoOCR, 644, 878, 687, 902, "手动", 10, -10)
            end

            baseUtils.toast("战斗中")
        else
            -- 战斗结束
            openStatus = shilianTask.openTreasure()
            if openStatus == 1 then
                baseUtils.toast("战斗结束 - 战斗胜利")
                break
            end

            -- 兼容恶龙战斗结算页
            res = baseUtils.TomatoOCRText(tomatoOCR, 309, 569, 411, 607, "战斗详情")
            if res then
                res = baseUtils.TomatoOCRText(tomatoOCR, 333, 1049, 384, 1077, "开启")
                if res then
                    baseUtils.tapSleep(365, 1135)
                    baseUtils.tapSleep(365, 1135)
                    baseUtils.tapSleep(365, 1135)
                    baseUtils.tapSleep(365, 1135, 3)
                else
                    baseUtils.tapSleep(365, 1135, 3)
                end
                baseUtils.toast("恶龙任务 - 战斗胜利 - 结算页返回房间")
                break
            end
            -- 兼容恶龙战斗后领取宝箱页
            x, y = findMultiColorInRegionFuzzy(0xb633bd,
                "12|0|0xffe6d3,18|0|0x9c5889,22|0|0xa94aae,27|0|0xaf3ccf,27|16|0x592720,27|36|0xd89c82,27|47|0xa930d3,33|47|0xb033cb,32|63|0xe5b1a4,23|60|0xa13dbb,-3|57|0xa24693,-3|43|0xae33dc,4|43|0xd8936c,9|43|0xbb7048,8|21|0x582720",
                80, 0, 0, 720, 1280, { orient = 2 })
            if x ~= -1 then
                baseUtils.tapSleep(112, 818) -- 点击空白处确认
                baseUtils.toast("恶龙任务 - 战斗胜利 - 房间页宝箱确认")
                break
            end
        end

        -- 判断是否战斗失败（战斗4分钟后）
        res, teamName1 = baseUtils.TomatoOCRText(tomatoOCR, 8, 148, 51, 163, "队友名称")
        res, teamName2 = baseUtils.TomatoOCRText(tomatoOCR, 8, 146, 52, 166, "队友名称")
        if elapsed > 240 * 1000 or (teamName1 == "" and teamName2 == "") then
            failStatus = shilianTask.fightFail()
            if failStatus then
                break
            end
        end
        baseUtils.mSleep3(3 * 1000)
        elapsed = elapsed + 3 * 1000
    end
end

-- 判断是否战斗失败
function shilianTask.fightFail()
    res1 = baseUtils.TomatoOCRText(tomatoOCR, 246, 459, 327, 482, "你被击败了")
    res2 = baseUtils.TomatoOCRText(tomatoOCR, 475, 1038, 527, 1065, "放弃")
    if res1 or res2 then
        baseUtils.toast("战斗结束 - 战斗失败")
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
    if 功能开关["喊话内容"] == "" then
        return 1
    end

    if (isColor(659, 367, 0xe2e1d1, 80) and isColor(662, 368, 0xe2dfd1, 80) and isColor(668, 368, 0xa1a099, 80) and isColor(664, 370, 0xe2dfd1, 80) and isColor(653, 370, 0xe2dece, 80) and isColor(656, 372, 0xe4e1d4, 80) and isColor(662, 372, 0xe2dfd1, 80) and isColor(674, 372, 0xe2ded1, 80) and isColor(678, 372, 0xe2ded1, 80) and isColor(679, 367, 0x7d8084, 80) and isColor(681, 373, 0xe1dfcf, 80) and isColor(679, 376, 0x797c81, 80) and isColor(676, 378, 0xe2e0d2, 80) and isColor(672, 386, 0xf3eddd, 80) and isColor(675, 386, 0xf3eddd, 80) and isColor(682, 385, 0xf3eddd, 80) and isColor(678, 389, 0xf3eddd, 80) and isColor(678, 392, 0xf3eddd, 80) and isColor(678, 399, 0xf3eddd, 80) and isColor(675, 399, 0xf3eddd, 80)) then
        -- 识别冒险手册
        -- 避免世界频道发言
        return 1
    end

    baseUtils.toast("队伍发言")

    res1 = baseUtils.TomatoOCRTap(tomatoOCR, 19, 1104, 94, 1128, "点击输入")
    if res1 == false then
        res2 = baseUtils.TomatoOCRTap(tomatoOCR, 19, 1102, 90, 1127, "点击输入")
    end
    baseUtils.mSleep3(2500) -- 等待输入法弹窗
    if res1 or res2 then
        --延迟 1 秒以便获取焦点，注意某些应用不获取焦点无法输入
        baseUtils.mSleep3(1000);
        --在输入框中输入字符串 "Welcome." 并回车；此函数在某些应用中无效，如支付宝、密码输入框等位置，甚至可能会导致目标应用闪退
        inputText(功能开关["喊话内容"])
        baseUtils.tapSleep(360, 104) -- 点击空白处确认输入
        res = baseUtils.TomatoOCRTap(tomatoOCR, 555, 1156, 603, 1188, "发送")
        if res then
            --确认关闭聊天框
            x, y = findMultiColorInRegionFuzzy(0xb5bdcb,
                "0|4|0xf5f0de,4|4|0xf1ebdd,-10|5|0xd5dbda,-10|7|0xf3efe1,-8|9|0xf2f2dd,-6|12|0xf2ebdd,-2|15|0xf4efdf,3|15|0xf4eede,6|12|0xf4eddf,9|9|0xf4ece0,14|10|0x6785bc,9|17|0x6484b9,2|22|0x6584b9,-11|18|0x6483b8,2|0|0xede8da,-13|1|0x6484b9,-3|-2|0x6685ba",
                80, 0, 0, 720, 1280, { orient = 2 })
            if x ~= -1 then
                baseUtils.tapSleep(x, y)
            end
            return 1
        end
    end
    --确认关闭聊天框
    x, y = findMultiColorInRegionFuzzy(0xb5bdcb,
        "0|4|0xf5f0de,4|4|0xf1ebdd,-10|5|0xd5dbda,-10|7|0xf3efe1,-8|9|0xf2f2dd,-6|12|0xf2ebdd,-2|15|0xf4efdf,3|15|0xf4eede,6|12|0xf4eddf,9|9|0xf4ece0,14|10|0x6785bc,9|17|0x6484b9,2|22|0x6584b9,-11|18|0x6483b8,2|0|0xede8da,-13|1|0x6484b9,-3|-2|0x6685ba",
        80, 0, 0, 720, 1280, { orient = 2 })
    if x ~= -1 then
        baseUtils.tapSleep(x, y)
    end
    return 0
end

-- 领取宝箱
function shilianTask.openTreasure()
    local isTreasue = 0 -- 是否在宝箱页

    res = baseUtils.TomatoOCRText(tomatoOCR, 300, 606, 417, 634, "宝箱尚未开启") -- 避免前置错误点击弹出宝箱尚未开启
    if res then
        res = baseUtils.TomatoOCRTap(tomatoOCR, 99, 1199, 128, 1234, "回") -- 关闭确认弹窗，返回待领取页
    end

    local res1 = false
    local res2 = false
    local res3 = false
    local res4 = false
    local res5 = false
    local res6 = false
    local res7 = false
    res1 = baseUtils.TomatoOCRText(tomatoOCR, 313, 622, 404, 656, "通关奖励") -- 战斗结束页。宝箱提示
    if res1 == false then
        res2 = baseUtils.TomatoOCRText(tomatoOCR, 267, 755, 313, 783, "开启") -- 战斗结束页。宝箱提示
        if res2 == false then
            res3 = baseUtils.TomatoOCRText(tomatoOCR, 273, 397, 360, 425, "是否开启") -- 结算页，宝箱提示
            if res3 == false then
                res4 = baseUtils.TomatoOCRText(tomatoOCR, 265, 457, 314, 488, "开启") -- 结算页，宝箱提示
                if res4 == false then
                    res5 = baseUtils.TomatoOCRText(tomatoOCR, 312, 563, 404, 596, "通关奖励") -- 战斗结束页。宝箱提示
                    if res5 == false then
                        res6 = baseUtils.TomatoOCRText(tomatoOCR, 309, 551, 406, 588, "通关奖励") -- 战斗结束页。宝箱提示
                        if res6 == false then
                            res7 = baseUtils.TomatoOCRText(tomatoOCR, 264, 453, 356, 482, "开启宝箱") -- 战斗结束页。宝箱提示
                            if res7 == false then
                                x, y = findMultiColorInRegionFuzzy(0xfbd4f9,
                                    "-19|7|0xc5c3ea,-9|7|0x7976c2,14|7|0xb9b7e1,7|7|0x8585cf,7|15|0xe2dbf6,-14|20|0xa09bd3,5|22|0x9996ce,18|22|0xcacaea,20|27|0x4b4b95,6|27|0xf5f8fe,-9|27|0xb6b4e0,-17|29|0x4b4b6e,-9|34|0x6a6a9d,15|34|0xe9dfed",
                                    90, 0, 0, 720, 1280, { orient = 2 }) -- 匹配友情币
                                if x ~= -1 then
                                    res8 = true
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if res1 or res2 or res3 or res4 or res5 or res6 or res7 or res8 then
        isTreasue = 1
    end

    if 功能开关["秘境-不开宝箱"] ~= nil and 功能开关["秘境-不开宝箱"] == 1 then
        openStatus = 0
        if isTreasue == 1 then
            if 功能开关["秘境-点赞队友"] ~= nil and 功能开关["秘境-点赞队友"] == 1 then
                toast("点赞队友")
                zan = 0
                while zan < 4 do
                    x, y = findMultiColorInRegionFuzzy(0xffffff,
                        "0|1|0xffffff,0|4|0xfefefe,-1|12|0xffffff,5|9|0xfefefe,5|6|0xffffff,5|3|0x82a6e2,-8|2|0x7da3e3,-7|5|0xffffff,-8|8|0xffffff,-8|13|0x94afe3,2|16|0x7ea2e3,8|12|0x7aa3e2,9|7|0x80a5e4",
                        75, 0, 0, 720, 1280, { orient = 2 })
                    if x ~= -1 then
                        baseUtils.tapSleep(x, y) -- 战斗结束页点赞队友
                    end
                    zan = zan + 1
                end
            end

            toast("返回房间")
            baseUtils.tapSleep(645, 1235, 3) -- 战斗结束页确认不领取
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
        if isTreasue == 1 then
            toast("点赞队友")
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
    if isTreasue == 1 then
        while attempts < maxAttempts do
            res = baseUtils.TomatoOCRText(tomatoOCR, 300, 606, 417, 634, "宝箱尚未开启") -- 避免前置错误点击弹出宝箱尚未开启
            if res then
                res = baseUtils.TomatoOCRTap(tomatoOCR, 99, 1199, 128, 1234, "回") -- 关闭确认弹窗，返回待领取页
            end

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
            res = baseUtils.TomatoOCRTap(tomatoOCR, 335, 755, 380, 777, "开启")
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
            --图色识别兜底
            if openStatus == 0 then
                x, y = findMultiColorInRegionFuzzy(0xf3a84b,
                    "41|0|0xf3a84b,35|12|0xf3a84b,21|12|0xf3a84b,12|12|0xf3a84b,6|12|0xf3a84b,3|26|0xf3a84b,49|7|0xf7c8a1,62|7|0xf9d7be,56|0|0xf9d7bd,67|0|0xf9dac3,85|0|0xf3a84b,105|0|0xf3a84b,117|1|0xf3a84b,128|26|0xf3a84b",
                    90, 0, 0, 720, 1280, { orient = 2 }) -- 开启
                if x ~= -1 then
                    baseUtils.tapSleep(x, y)
                    baseUtils.mSleep3(3500);
                    baseUtils.tapSleep(150, 1155)
                    openStatus = 1
                end
            end
        end
    end

    if openStatus == 1 then
        baseUtils.toast("开启宝箱 - 成功", 0.5)
    end

    -- 开启宝箱后，返回
    if openStatus == 1 or isTreasue == 1 then
        baseUtils.toast("返回房间", 0.5)
        res = baseUtils.TomatoOCRTap(tomatoOCR, 96, 1199, 130, 1232, "回") -- 返回
        res = baseUtils.TomatoOCRTap(tomatoOCR, 330, 726, 387, 759, "确定") -- 确定返回
        if res == false then
            res = baseUtils.TomatoOCRTap(tomatoOCR, 331, 727, 388, 761, "确定") -- 确定返回
        end
        if res == false then
            -- 识别战斗结束页提前返回
            local res1 = false
            local res2 = false
            local res3 = false
            res1 = baseUtils.TomatoOCRText(tomatoOCR, 313, 622, 404, 656, "通关奖励") -- 战斗结束页。宝箱提示
            if res1 == false then
                res2 = baseUtils.TomatoOCRText(tomatoOCR, 312, 563, 404, 596, "通关奖励") -- 战斗结束页。宝箱提示
                if res2 == false then
                    res3 = baseUtils.TomatoOCRText(tomatoOCR, 309, 551, 406, 588, "通关奖励") -- 战斗结束页。宝箱提示
                end
            end
            if res1 or res2 or res3 then
                baseUtils.tapSleep(645, 1235, 3) -- 战斗结束页确认不领取
                res = baseUtils.TomatoOCRTap(tomatoOCR, 329, 728, 386, 759, "确定") -- 战斗结束页确认退出
                if res == false then
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 96, 1199, 130, 1232, "回") -- 返回
                    res = baseUtils.TomatoOCRTap(tomatoOCR, 329, 728, 386, 759, "确定") -- 确定
                    if res == false then
                        res = baseUtils.TomatoOCRTap(tomatoOCR, 331, 727, 388, 761, "确定") -- 确定返回
                    end
                end
                openStatus = 1
            end
        end
    end
    return openStatus
end

return shilianTask
