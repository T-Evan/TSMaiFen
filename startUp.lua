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
    res10 = baseUtils.TomatoOCRText(tomatoOCR, 627, 381, 710, 403, "新手试炼")
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
    elseif res3 or res4 or res8 or res9 or res10 then -- 已在游戏中
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
        baseUtils.tapSleep(340, 930, 1)
        baseUtils.tapSleep(340, 930, 1)
        baseUtils.tapSleep(340, 930)
        baseUtils.mSleep3(5 * 1000)

        local loopCount = 0
        while loopCount < 3 do -- 循环2次
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

--复制文件
function startUp.copyfile(path, to)
    os.execute("cp -rf " .. path .. " " .. to);
end

function startUp.multiAccount()
    local ts = require("ts")

    if 功能开关["账号1保存"] == 1 then
        flag = startUp.saveAccount("1")
    end

    if 功能开关["账号2保存"] == 1 then
        flag = startUp.saveAccount("2")
    end

    if 功能开关["账号3保存"] == 1 then
        flag = startUp.saveAccount("3")
    end

    if 功能开关["账号4保存"] == 1 then
        flag = startUp.saveAccount("4")
    end

    if 功能开关["账号5保存"] == 1 then
        flag = startUp.saveAccount("5")
    end

    --指定账号启动
    if 功能开关["选择启动账号"] ~= "0" then
        if 功能开关["选择启动账号"] == "1" then
            startUp.loadAccount("accountConfig1")
        end

        if 功能开关["选择启动账号"] == "2" then
            startUp.loadAccount("accountConfig2")
        end

        if 功能开关["选择启动账号"] == "3" then
            startUp.loadAccount("accountConfig3")
        end

        if 功能开关["选择启动账号"] == "4" then
            startUp.loadAccount("accountConfig4")
        end

        if 功能开关["选择启动账号"] == "5" then
            startUp.loadAccount("accountConfig5")
        end
    end
end

function startUp.saveAccount(accountName)
    oldPath1 = "/data/data/com.xd.cfbmf/shared_prefs/"
    newPath1 = userPath() .. "/log/" .. "/accountConfig" .. accountName .. "_shared_prefs/"
    ts.hlfs.removeDir(newPath1)           -- 删除文件夹
    creatflag = ts.hlfs.makeDir(newPath1) --新建文件夹
    flag1 = ts.hlfs.copyDir(oldPath1, newPath1)

    oldPath2 = "/data/data/com.xd.cfbmf/app_webview/"
    newPath2 = userPath() .. "/log/" .. "/accountConfig" .. accountName .. "_app_webview/"
    ts.hlfs.removeDir(newPath2)           -- 删除文件夹
    creatflag = ts.hlfs.makeDir(newPath2) --新建文件夹
    flag2 = ts.hlfs.copyDir(oldPath2, newPath2)

    --复制文件夹及里面所有文件
    if flag1 and flag2 then
        dialog("已保存账号" .. accountName .. "登录信息！请重启软件")
    else
        dialog("保存失败！请联系作者")
    end
    lua_exit()
    return true
end

function startUp.loadAccount(accountName)
    closeApp("com.xd.cfbmf") -- 重启应用让配置生效

    oldPath1 = "/data/data/com.xd.cfbmf/shared_prefs/"
    ts.hlfs.removeDir(oldPath1)           -- 删除文件夹
    creatflag = ts.hlfs.makeDir(oldPath1) --新建文件夹
    newPath1 = userPath() .. "/log/" .. "/" .. accountName .. "_shared_prefs/"
    flag = ts.hlfs.copyDir(newPath1, oldPath1)

    oldPath2 = "/data/data/com.xd.cfbmf/app_webview/"
    ts.hlfs.removeDir(oldPath2)           -- 删除文件夹
    creatflag = ts.hlfs.makeDir(oldPath2) --新建文件夹
    newPath2 = userPath() .. "/log/" .. "/" .. accountName .. "_app_webview/"
    flag = ts.hlfs.copyDir(newPath2, oldPath2)

    switchApp("com.xd.cfbmf")
end

-- 复制用户信息数据切换账号
function startUp.switchAccount()
    if 任务记录["当前任务账号"] ~= "0" then
        tmpAccount = tonumber(任务记录["当前任务账号"]) + 1 -- 从下一账号开始判断
        for i = tmpAccount, 5 do
            if 功能开关["账号" .. i .. "开关"] == 1 then
                startUp.loadAccount("accountConfig" .. i)
                任务记录["当前任务账号"] = i
                return
            end
        end

        -- 循环一遍后，重新执行
        for i = 1, 5 do
            if 功能开关["账号" .. i .. "开关"] == 1 then
                startUp.loadAccount("accountConfig" .. i)
                任务记录["当前任务账号"] = i
                return
            end
        end
    end
end

-- 升级成功/战斗胜利页确认
function startUp.noticeCancel()
    res1 = baseUtils.TomatoOCRText(tomatoOCR, 213, 521, 272, 584, "战") -- 战斗胜利
    res2 = baseUtils.TomatoOCRText(tomatoOCR, 448, 500, 503, 560, "利") -- 战斗胜利
    res3 = baseUtils.TomatoOCRText(tomatoOCR, 229, 436, 286, 497, "升") --升级成功
    res4 = baseUtils.TomatoOCRText(tomatoOCR, 301,1202,419,1229, "点击空白处关闭") --战斗失败
    if res1 or res2 or res3 or res4 then
        baseUtils.tapSleep(55, 1242) -- 点击空白处
        baseUtils.tapSleep(685, 1240) -- 点击空白处
        baseUtils.toast("发现弹窗 - 弹窗确认")
    end
end

-- taptap模拟操作切换账号（已废弃）
function startUp.switchAccountOld()
    --  切换taptap登录
    closeApp("com.taptap")
    startFlag = switchApp("com.taptap")
    if startFlag == 0 then
        dialog("未安装taptap，无法执行切号功能！", 3)
        lua_exit()
    end
    toast("切换账号中，请勿操作！", 2)
    baseUtils.mSleep3(5 * 1000)
    logUtils.log("启动taptap成功")

    -- 点击头像
    baseUtils.tapSleep(657, 97)
    -- 点击菜单
    baseUtils.tapSleep(666, 94)
    -- 下滑寻找"设置"
    moveTo(597, 1013, 603, 714, 100)
    baseUtils.mSleep3(2000)
    moveTo(597, 1013, 603, 714, 80)
    baseUtils.mSleep3(2000)
    -- 点击设置
    res = baseUtils.TomatoOCRTap(tomatoOCR, 240, 802, 303, 838, "设置")
    if res then
        -- 下滑寻找"切换和添加账号"
        moveTo(597, 1013, 603, 714, 100)
        baseUtils.mSleep3(2000)
        moveTo(597, 1013, 603, 714, 100)
        baseUtils.mSleep3(2000)
        res = baseUtils.TomatoOCRTap(tomatoOCR, 257, 1019, 460, 1067, "切换和添加账号")
        if res then
            res, phone0 = baseUtils.TomatoOCRText(tomatoOCR, 301, 398, 348, 420, "当前账号") -- 当前账号栏
            if phone0 == 功能开关["账号1"] then
                nextPhone = 功能开关["账号2"]
            elseif phone0 == 功能开关["账号2"] then
                nextPhone = 功能开关["账号3"]
            elseif phone0 == 功能开关["账号3"] then
                nextPhone = 功能开关["账号4"]
            elseif phone0 == 功能开关["账号4"] then
                nextPhone = 功能开关["账号1"]
            else
                dialog("当前登录账号未匹配到，请检查配置文件！", 3)
            end

            res = baseUtils.TomatoOCRText(tomatoOCR, 301, 398, 348, 420, nextPhone) -- 当前账号栏
            if res then
                toast("已登录下一账号")
            else
                res, phone1 = baseUtils.TomatoOCRTap(tomatoOCR, 270, 581, 326, 605, nextPhone) -- 账号1栏
                res, phone2 = baseUtils.TomatoOCRTap(tomatoOCR, 271, 724, 326, 751, nextPhone) -- 账号2栏
                res, phone3 = baseUtils.TomatoOCRTap(tomatoOCR, 271, 868, 323, 894, nextPhone) -- 账号3栏
            end
        end
    else
        toast("taptap切换账号失败，请联系作者", 3)
        return
    end

    -- 切换麦芬重新登录
    toast("切换账号中，请勿操作！", 2)
    closeApp("com.xd.cfbmf")
    startFlag = switchApp("com.xd.cfbmf")
    if startFlag == 0 then
        dialog("请先打开 出发吧麦芬 游戏主界面，再运行该脚本！", 3)
        lua_exit()
    end
    toast("启动游戏，等待10s", 2)
    baseUtils.mSleep3(8 * 1000)
    logUtils.log("启动app成功")

    -- 关闭公告
    res = baseUtils.TomatoOCRTap(tomatoOCR, 171, 1189, 200, 1216, "回")
    res = baseUtils.TomatoOCRTap(tomatoOCR, 98, 1202, 128, 1231, "回")
    res = baseUtils.TomatoOCRTap(tomatoOCR, 93, 1186, 127, 1217, "回")
    -- 识别是否进入首页
    for i = 1, 4 do
        res = baseUtils.TomatoOCRText(tomatoOCR, 282, 1017, 437, 1051, "开始冒险之旅")
        if res then
            -- 退出麦芬登录
            baseUtils.tapSleep(663, 173) -- 点击用户中心
            res = baseUtils.TomatoOCRTap(tomatoOCR, 318, 671, 399, 697, "退出登录")
            res = baseUtils.TomatoOCRTap(tomatoOCR, 468, 764, 501, 796, "认") -- 确认退出
            -- 重新登录
            res = baseUtils.TomatoOCRTap(tomatoOCR, 327, 817, 391, 858, "同意") -- 同意隐私政策
            res = baseUtils.TomatoOCRTap(tomatoOCR, 384, 991, 437, 1019, "登录") -- 点击taptap登录
            if res then
                baseUtils.tapSleep(361, 555) -- 点击一键登录
                res = baseUtils.TomatoOCRTap(tomatoOCR, 371, 734, 433, 771, "继续") -- 同意授权隐私政策
                if res then
                    toast("登录成功", 3)
                    baseUtils.mSleep3(5000)
                    break -- 确认登录
                end
            end
        end
        baseUtils.mSleep3(5000)
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
