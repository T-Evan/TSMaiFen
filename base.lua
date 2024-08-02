local baseUtils = {}

-- ai识别OCR
function baseUtils.initAiOCR()
    local json = ts.json
    local API = "Ac8GxgogTvmBrh1mpnMXrULP"
    local Secret = "mUkSGmw6eqgLx7CYW80w4RfonJMsqiSi"

    local tab = {
        language_type = "CHN_ENG",
        ocrType = 2
    }
    local code1, access_token = getAccessToken(API, Secret)
    if code1 then
        log("获取AIToken-成功")
    else
        log("获取AIToken-失败")
    end
    return access_token
end

function baseUtils.AiOCRText(x1, y1, x2, y2, keyWord)
    current_time = os.date("%Y-%m-%d", os.time()) --以时间戳命名进行截图
    local pic_name = userPath() .. current_time .. ".aiOCR.jpg"
    snapshot(pic_name, x1, y1, x2, y2)

    local code2, text = baiduAI(aiOCRToken, pic_name, tab)
    local ocrRes = ""
    if code2 and text ~= "" then
        ocrRes = json.decode(text)
        ocrRes = ocrRes.words_result[1].words
        if keyWord == ocrRes then
            logUtils.log("成功-" .. keyWord .. "|" .. ocrRes)
            return true
        else
            logUtils.log("失败-不匹配-" .. keyWord .. "|" .. ocrRes)
            return false
        end
    else
        logUtils.log("失败-未识别-" .. keyWord .. "|" .. ocrRes)
        return false
    end
end

-- 本地OCR
function baseUtils.initTomatoOCR()
    local tomatoOCR = require("TomatoOCRCore")
    -- 初始化-android-触动精灵
    --tomatoOCR.init("android")
    -- 初始化-android-触动小精灵
    tomatoOCR.init("android-x")

    local license =
    "gAAAAABmo1lIAAAAAGeaUIBr5x9E7spn_xedmP6VKb40BJaa9nSPCHpmoc7tABnFHWPOz24TrHhyuXdaVI95ANvi99C8LN90K0RqD83nbURChETd-8YmvnOd2AXfsM2ioQ==" -- 从群文件txt中获取
    local flag = tomatoOCR.setLicense(license)
    -- flag= 次数 或 到期日期 : 试用license或正式license

    local rec_type = "ch-3.0"
    -- 注：ch、ch-2.0、ch-3.0版可切换使用，对部分场景可适当调整
    -- "ch"：普通中英文识别，1.0版模型
    -- "ch-2.0"：普通中英文识别，2.0版模型
    -- "ch-3.0"：普通中英文识别，3.0版模型
    -- "cht"：繁体，"japan"：日语，"korean"：韩语
    tomatoOCR.setRecType(rec_type)

    tomatoOCR.setDetBoxType("rect")     -- 调整检测模型检测文本参数- 默认"rect": 由于手机上截图文本均为矩形文本，从该版本之后均改为rect，"quad"：可准确检测倾斜文本
    tomatoOCR.setDetUnclipRatio(1.9)    -- 调整检测模型检测文本参数 - 默认1.9: 值范围1.6-2.5之间
    tomatoOCR.setRecScoreThreshold(0.6) -- 识别得分过滤 - 默认0.1，值范围0.1-0.9之间
    tomatoOCR.setReturnType("json")
    -- 返回类型 - 默认"json": 包含得分、坐标和文字；
    -- "text"：纯文字；
    -- "num"：纯数字；
    -- 自定义输入想要返回的文本：".￥1234567890"，仅只返回这些内容

    local type = 3
    -- type 可传可不传
    -- type=0 : 只检测
    -- type=1 : 方向分类 + 识别
    -- type=2 : 只识别
    -- type=3 : 检测 + 识别

    -- 只检测文字位置：type=0
    -- 全屏识别: type=3或者不传type
    -- 截取单行文字识别：type=1或者type=2

    logUtils.log("加载ocr成功")

    return tomatoOCR
end

function baseUtils.TomatoOCRText(tomatoOCR, x1, y1, x2, y2, keyWord, returnType)
    returnType = returnType or "text"
    tomatoOCR.setReturnType(returnType)

    current_time = os.date("%Y-%m-%d", os.time()) --以时间戳命名进行截图
    local pic_name = userPath() .. current_time .. ".baseOCR.jpg"
    snapshot(pic_name, x1, y1, x2, y2)

    local ocrRes = tomatoOCR.ocrFile(pic_name, 3)
    if returnType == "text" and ocrRes ~= nil and ocrRes ~= "" then
        if keyWord == ocrRes then
            logUtils.log("o识别成功-" .. keyWord .. "|" .. ocrRes)
            return true, ocrRes
        else
            logUtils.log("o识别失败-不匹配-" .. keyWord .. "|" .. ocrRes)
            return false, ocrRes
        end
    elseif returnType == "json" then
        return true, ocrRes
    else
        logUtils.log("o识别失败-异常-" .. keyWord .. "|" .. ocrRes)
        return false, ocrRes
    end
end

-- 点击位置偏移 offsetX、offsetY
function baseUtils.TomatoOCRTap(tomatoOCR, x1, y1, x2, y2, keyWord, offsetX, offsetY, thresholdScore)
    thresholdScore = thresholdScore or 0.8 -- 如果 thresholdScore 未传入，则使用默认值 0.8
    offsetX = offsetX or 0
    offsetY = offsetY or 0
    tomatoOCR.setReturnType("json")

    current_time = os.date("%Y-%m-%d", os.time()) --以时间戳命名进行截图
    local pic_name = userPath() .. current_time .. ".baseOCRTap.jpg"
    snapshot(pic_name, x1, y1, x2, y2)

    local text = tomatoOCR.ocrFile(pic_name, 3)
    local ocrRes = ""
    if text == "" then
        logUtils.log("o点击失败-异常-" .. keyWord .. "|空")
        return false
    end
    local success, decodedText = pcall(function() return json.decode(text) end)
    if not success then
        -- JSON 解析失败，处理错误
        logUtils.log("o点击失败-JSON解析错误-" .. keyWord .. "|" .. decodedText)
        return false
    else
        -- JSON 解析成功，继续后续操作
        ocrRes = decodedText[1]
        if ocrRes.score > thresholdScore and keyWord == ocrRes.words then
            baseUtils.tapSleep(x1 + offsetX, y1 + offsetY, 1)
            logUtils.log("o点击成功-" .. keyWord .. "|" .. ocrRes.words)
            return true
        else
            logUtils.log("o点击失败-不匹配-" .. keyWord .. "|" .. ocrRes.words)
            return false
        end
    end
end

function baseUtils.TomatoFindTextTap(tomatoOCR, keyWord, offsetX, offsetY)
    offsetX = offsetX or 0
    offsetY = offsetY or 0
    res = tomatoOCR.findTapPoint(keyWord)
    logUtils.log("失败-未识别-" .. keyWord .. "|" .. res)
end

function baseUtils.tapSleep(x, y, ms)
    ms = ms or 2
    tap(x, y)
    baseUtils.mSleep3(ms * 1000)
end

--下载资源，未下载完成前请勿停止脚本或者重启服务否则文件将损坏
function baseUtils.loadRes()
    local files = {
        --{
        --    file = userPath() .. "/res/det.opt",
        --    url = "http://backupformyself.oss-cn-hongkong.aliyuncs.com/TSRes/det.opt"
        --},
        --{
        --    file = userPath() .. "/res/cls.opt",
        --    url = "http://backupformyself.oss-cn-hongkong.aliyuncs.com/TSRes/cls.opt"
        --},
        --{
        --    file = userPath() .. "/res/rec_v3.opt",
        --    url = "http://backupformyself.oss-cn-hongkong.aliyuncs.com/TSRes/rec_v3.opt"
        --},
         {
             file = userPath() .. "/res/rec.opt",
             url = "http://trs-res.oss-cn-beijing.aliyuncs.com/rec.opt"
         },
        --{
        --    file = userPath() .. "/res/rec_korean.opt",
        --    url = "http://backupformyself.oss-cn-hongkong.aliyuncs.com/TSRes/rec_korean.opt"
        --},
        --{
        --    file = userPath() .. "/res/rec_japan.opt",
        --    url = "http://backupformyself.oss-cn-hongkong.aliyuncs.com/TSRes/rec_japan.opt"
        --},
        {
            file = userPath() .. "/res/rec_cht.opt",
            url = "http://trs-res.oss-cn-beijing.aliyuncs.com/rec_cht.opt"
        }
    }

    deviceType, deviceName = getDeviceType();
    --dialog(deviceType)
    --dialog(deviceName)
    local length = #files
    if deviceName == "逍遥" then
        files[length + 1] = {
            file = userPath() .. "/res/TomatoOCR.opt",
            url = "http://trs-res.oss-cn-beijing.aliyuncs.com/TomatoOCR-x86.opt"
        }
    else
        files[length + 1] = {
            file = userPath() .. "/res/TomatoOCR.opt",
            url = "http://trs-res.oss-cn-beijing.aliyuncs.com/TomatoOCR-arm64.opt"
        }
    end

    logUtils.log("开始加载资源，请稍后")
    toast("开始加载资源")
    local ts = require("ts")
    for _, data in ipairs(files) do
        file = baseUtils.findFile(data.file)
        local size = getFileSize(data.file)
        if #file > 0 then
            if size < 10000 then
                dialog("资源加载错误，请清空资源后重试")
                lua_exit()
            end
            logUtils.log("资源已加载" .. data.file)
        else
            code, msg = ts.tsDownload(data.file, data.url)
            if code == 0 then
                logUtils.log("加载资源成功" .. data.file .. "|" .. data.url)
                toast("加载资源成功")
            else
                logUtils.log("加载资源init" .. data.file .. "|" .. data.url)
                toast("加载资源中")
            end
        end
    end
end

function baseUtils.mSleep3(t1, t2)
    if t2 == nil then
        mSleep(math.random(t1 * 0.8, t1 * 1.2))
    else
        mSleep(math.random(t1, t2))
    end
end

--查找文件
function baseUtils.findFile(path)
    local a = io.popen("find " .. path .. " -prune")
    local f = {}
    for l in a:lines() do
        table.insert(f, l)
    end
    a:close()
    return f
end

-- 安全相关


return baseUtils
