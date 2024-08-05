local startUp = {}

-- 启动app
function startUp.startApp()
    local flag = deviceIsLock() --判断屏幕是否锁定
    if flag ~= 0 then
        unlockDevice()          --解锁屏幕
    end

    --luaExitIfCall(true) --如果电话进入自动终止脚本

    runFlag2 = isFrontApp("com.xd.cfbmf")
    if runFlag2 == 0 then
        startFlag = switchApp("com.xd.cfbmf")
        if startFlag == 0 then
            dialog("请先打开 出发吧麦芬 游戏主界面，再运行该脚本！", 3)
            lua_exit()
        end
        toast("启动游戏，等待15s", 2)
        baseUtils.mSleep3(15 * 1000)
        logUtils.log("启动app成功")
    else
        logUtils.log("app运行中")
    end

    -- local w, h = getScreenSize() --获取屏幕分辨率函数
    -- if w ~= 720 and h ~= 1280 then --获取的屏幕分辨率如果满足W.H 则。
    --     dialog("该脚本不支持此分辨率的设备，当前只支持720 X 1280分辨率", 5)
    --     --提示
    --     lua_exit() --退出脚本
    -- end

    -- 识别是否进入首页
    res1 = baseUtils.TomatoOCRText(tomatoOCR, 84, 1192, 139, 1225, "返回") -- 公告
    res2 = baseUtils.TomatoOCRText(tomatoOCR, 282, 1017, 437, 1051, "开始冒险之旅")
    res3 = baseUtils.TomatoOCRTap(tomatoOCR, 327, 1205, 389, 1233, "冒险")
    res4 = baseUtils.TomatoOCRText(tomatoOCR, 626, 379, 711, 405, "冒险手册")
    --x, y = findMultiColorInRegionFuzzy(0xffffff,
    --    "2|1|0xffffff,2|2|0xffffff,2|4|0xffffff,1|5|0x87b58b,-1|4|0x9fbea2,-5|5|0xffffff,-7|5|0x93bb8c,-7|13|0xffffff,-9|17|0xfefffe,-10|17|0xfefffe,-11|18|0xeaefea,17|18|0xffffff,21|22|0xc4c0b6,21|21|0xffffff,22|8|0xfdfefd",
    --    90, 308, 0, 718, 128, { orient = 2 })
    --if x ~= -1 then
    --    res4 = true -- 匹配到右上角钻石按钮，说明已进入游戏
    --end

    res5 = baseUtils.TomatoOCRTap(tomatoOCR, 171, 1189, 200, 1216, "回")
    res6 = baseUtils.TomatoOCRTap(tomatoOCR, 98, 1202, 128, 1231, "回")
    res7 = baseUtils.TomatoOCRTap(tomatoOCR, 93, 1186, 127, 1217, "回")

    res8 = baseUtils.TomatoOCRText(tomatoOCR, 457, 607, 502, 631, "准备") -- 秘境准备
    res9 = baseUtils.TomatoOCRText(tomatoOCR, 453, 650, 505, 684, "准备") -- 恶龙准备

    if res1 == false and res2 == false and res3 == false and res4 == false and res5 == false and res6 == false and res7 == false then -- 在登录页面
        baseUtils.mSleep3(5000)
        return startUp.startApp()
    elseif res3 or res4 or res8 or res9 then -- 已在游戏中
        toast("已进入游戏，返回首页", 1)
        baseUtils.mSleep3(1000)
        return dailyTask.homePage()
    else
        toast("准备进入游戏", 1)
        baseUtils.mSleep3(1000)
        return startUp.logIn()
    end
end

function startUp.logIn()
    -- 开始冒险
    res = baseUtils.TomatoOCRTap(tomatoOCR, 84, 1192, 139, 1225, "返回") -- 关闭公告
    res1 = baseUtils.TomatoOCRTap(tomatoOCR, 282, 1017, 437, 1051, "开始冒险之旅")
    res2 = baseUtils.TomatoOCRTap(tomatoOCR, 302, 1199, 414, 1231, "开始冒险")

    -- 跳过启动动画
    if res1 or res2 then
        baseUtils.tapSleep(340, 930)
        baseUtils.tapSleep(340, 930)
        baseUtils.tapSleep(340, 930)
        baseUtils.mSleep3(10 * 1000)

        local loopCount = 0
        while loopCount < 2 do -- 循环2次
            loopCount = loopCount + 1
            -- 领取离线奖励
            res = baseUtils.TomatoOCRTap(tomatoOCR, 268, 869, 359, 888, "点击空白处", 30, 100)
            -- 领取离线奖励 - 确认
            res = baseUtils.TomatoOCRTap(tomatoOCR, 279, 1079, 440, 1099, "点击空白处可领取奖励", 30, 100)
            res = baseUtils.TomatoOCRTap(tomatoOCR, 279, 1079, 440, 1099, "点击空白处可领取奖励", 30, 100)
            res = baseUtils.TomatoOCRTap(tomatoOCR, 329, 726, 391, 761, "返回") -- 关闭公告
            res = baseUtils.TomatoOCRTap(tomatoOCR, 215, 1068, 274, 1102, "确定") -- 战斗胜利页
            baseUtils.mSleep3(3000)
        end
    else
        return startUp.startApp()
    end

    res = baseUtils.TomatoOCRText(tomatoOCR, 626, 379, 711, 405, "冒险手册")
    if res == false then
        return startUp.startApp()
    end
end

--local function killdialog()
--    while true do
--        dialog("killdialog")
--        res = baseUtils.TomatoOCRTap(tomatoOCR, 268, 869, 359, 888, "点击空白处", 30, 100)
--        res2 = baseUtils.TomatoOCRTap(tomatoOCR, 279, 1079, 440, 1099, "点击空白处可领取奖励", 30, 100)
--        res3 = baseUtils.TomatoOCRTap(tomatoOCR, 266, 863, 453, 890, "点击空白处可领取奖励", 30, 100)
--        res4 = baseUtils.TomatoOCRTap(tomatoOCR, 296, 1207, 424, 1232, "点击空白处关闭", 30, 100)
--        if res or res2 or res3 or res4 then
--            logUtils.log("发现弹窗-点击空白处")
--            dialog("killdialog2")
--            --mSleep(5000)
--        else
--            --mSleep(5000)
--        end
--    end
--end
--
--local error_handler = {
--    callBack = function()
--        if global_app_exit_reason == "userExit" then
--            logUtils.log("用户退出", time)
--        else
--            logUtils.log("发生未知异常", time)
--        end
--    end,
--    errorBack = function(err)
--        logUtils.log("协程错误了:" .. err, 0)
--    end,
--    catchBack = function(exp)
--        if exp.msg ~= "userExit" then
--            logUtils.log("协程异常了\n" .. json.encode(exp), 0)
--        else
--            global_app_exit_reason = "userExit"
--        end
--    end
--}

--local function error_handler(err)
--    dialog(err)
--    if global_app_exit_reason == "userExit" then
--        logUtils.log("用户退出", time)
--    else
--        logUtils.log("发生未知异常", time)
--    end
--    if err ~= "" then
--        logUtils.log("协程异常了\n" .. json.encode(err), 0)
--    else
--        global_app_exit_reason = "userExit"
--    end
--end
--
--local newProductor = coroutine.create(killdialog)
---- 使用xpcall来捕获协程错误
--xpcall(function()
--    coroutine.resume(newProductor)
--end, error_handler)

return startUp
