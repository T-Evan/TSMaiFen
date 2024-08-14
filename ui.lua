local ts = require("ts")
local cjson = ts.json
w, h = getScreenSize()
MyTable = {
    ["style"] = "default",
    ["width"] = w,
    ["height"] = h,
    ["cancelname"] = "取消",
    ["okname"] = "开始",
    ["title"] = "挂机吧麦芬",
    ["titlealign"] = "center",
    ["align"] = "center",
    ["titlesize"] = 12,
    ["titles"] = "首页,日常,冒险,营地,旅团,其他",
    ["pagetype"] = "multi",
    ["selpage"] = 1,
    ["orient"] = 0,
    ["btnbkcolor"] = "255,255,255",
    ["bgcolor"] = "255,255,255",
    ["pagenumtype"] = "tab",
    ["config"] = "showuiConfig1.txt",
    ["timer"] = 99,
    ["rettype"] = "table",
    pages = {
        {
            {
                ["type"] = "Label",
                ["text"] = "点击右上角闹钟关闭倒计时↗",
                ["size"] = 10,
                ["align"] = "center",
                ["color"] = "255,0,0"
            },
            {
                ["type"] = "Label",
                ["text"] = "公告：Have Fun ！",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
            },
            {
                ["type"] = "Label",
                ["text"] = "=== 配置选择(首次使用必须先保存配置)",
                ["size"] = 15,
                ["align"] = "center",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
            },
            {
                ["type"] = "Label",
                ["text"] = "使用前请查看群说明！！",
                ["size"] = 12,
                ["align"] = "center",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
            },
            {
                ["type"] = "ComboBox", -- 必填，控件类型，下拉框
                ["id"] = "配置选择",
                -- 选填，无，控件ID 以 table 格式返回返回值时必填，否则无法获取返回值
                ["list"] = "默认配置,配置1,配置2,配置3,配置4", -- 必填，无，下拉框内容
                ["select"] = "0", -- 选填，0，默认选中项 ID
                ["width"] = 300,
                ["prompt"] = true
            },
            {
                ["type"] = "RadioGroup",
                -- 必填，控件类型，单选组合
                ["id"] = "配置更新",
                -- 选填，无，控件 ID，以 table 格式返回返回值时必填,否则无法获取返回值
                ["list"] = "启动时保存所选配置,读取配置并启动", -- 必填，无，多选组合内容
                ["select"] = "0", -- 选填，0，默认选中项 id
                -- 选填，无， 单选组合选项显示图片
                ["scale"] = 0.4, -- 选填，1，图片缩放比例
                ["countperline"] = 1,
            },
            {
                ["type"] = "Label",
                ["text"] = "=== 多账号配置（首次使用先保存登录账号）",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
            },
            {
                ["type"] = "Label",
                ["text"] = "使用前请查看群说明！！",
                ["size"] = 12,
                ["align"] = "center",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
            },
            {
                ["type"] = "Label",
                ["text"] = "选择启动账号（从该账号开始挂机）",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
            },
            {
                ["type"] = "ComboBox", -- 必填，控件类型，下拉框
                ["id"] = "选择启动账号",
                -- 选填，无，控件ID 以 table 格式返回返回值时必填，否则无法获取返回值
                ["list"] = "默认(不切换),账号1,账号2,账号3,账号4,账号5", -- 必填，无，下拉框内容
                ["select"] = "0", -- 选填，0，默认选中项 ID
                ["width"] = 300,
                ["prompt"] = true
            },
            {
                ["type"] = "Switch",
                ["id"] = "账号1开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                ["type"] = "Label",
                ["text"] = "账号1",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["nowrap"] = 1,
                ["width"] = -1,
            },
            {
                ["type"] = "Edit",
                ["id"] = "账号1",
                ["prompt"] = "备注",
                ["kbtype"] = "ascii",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["text"] = "",
                ["size"] = 10,
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "账号1配置",
                -- 必填，无 ，单选框内容
                ["list"] = "保存",
                -- 选填，0，默认选中项 ID
                ["select"] = "",
                ["width"] = -1,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Switch",
                ["id"] = "账号2开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                ["type"] = "Label",
                ["text"] = "账号2",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["nowrap"] = 1,
                ["width"] = -1,
            },
            {
                ["type"] = "Edit",
                ["id"] = "账号2",
                ["prompt"] = "备注",
                ["kbtype"] = "ascii",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["text"] = "",
                ["size"] = 10,
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "账号2配置",
                -- 必填，无 ，单选框内容
                ["list"] = "保存",
                -- 选填，0，默认选中项 ID
                ["select"] = "",
                ["width"] = -1,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Switch",
                ["id"] = "账号3开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                ["type"] = "Label",
                ["text"] = "账号3",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["nowrap"] = 1,
                ["width"] = -1,
            },
            {
                ["type"] = "Edit",
                ["id"] = "账号3",
                ["prompt"] = "备注",
                ["kbtype"] = "ascii",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["text"] = "",
                ["size"] = 10,
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "账号3配置",
                -- 必填，无 ，单选框内容
                ["list"] = "保存",
                -- 选填，0，默认选中项 ID
                ["select"] = "",
                ["width"] = -1,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Switch",
                ["id"] = "账号4开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                ["type"] = "Label",
                ["text"] = "账号4",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["nowrap"] = 1,
                ["width"] = -1,
            },
            {
                ["type"] = "Edit",
                ["id"] = "账号4",
                ["prompt"] = "备注",
                ["kbtype"] = "ascii",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["text"] = "",
                ["size"] = 10,
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "账号4配置",
                -- 必填，无 ，单选框内容
                ["list"] = "保存",
                -- 选填，0，默认选中项 ID
                ["select"] = "",
                ["width"] = -1,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Switch",
                ["id"] = "账号5开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                ["type"] = "Label",
                ["text"] = "账号5",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["nowrap"] = 1,
                ["width"] = -1,
            },
            {
                ["type"] = "Edit",
                ["id"] = "账号5",
                ["prompt"] = "备注",
                ["kbtype"] = "ascii",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["text"] = "",
                ["size"] = 10,
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "账号5配置",
                -- 必填，无 ，单选框内容
                ["list"] = "保存",
                -- 选填，0，默认选中项 ID
                ["select"] = "",
                ["width"] = -1,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Label",
                ["text"] = "定时",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
            },
            {
                ["type"] = "Label",
                ["text"] = "运行",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["nowrap"] = 1,
                ["width"] = -1,
            },
            {
                ["type"] = "Edit",
                ["id"] = "定时运行",
                ["prompt"] = "",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["text"] = "60",
                ["size"] = 10,
                ["width"] = -1,
                ["nowrap"] = 1,
            },
            {
                ["type"] = "Label",
                ["text"] = "分钟后休息",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["nowrap"] = 1,
                ["width"] = -1,
            },

            {
                ["type"] = "Edit",
                ["id"] = "定时休息",
                ["prompt"] = "",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["text"] = "5",
                ["size"] = 10,
                ["width"] = -1,
                ["nowrap"] = 1,
            },
            {
                ["type"] = "Label",
                ["text"] = "分钟",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["width"] = -1,
            },
            {
                ["type"] = "Label",
                ["text"] = "运行",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["nowrap"] = 1,
                ["width"] = -1,
            },
            {
                ["type"] = "Edit",
                ["id"] = "定时切号",
                ["prompt"] = "",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["text"] = "",
                ["size"] = 10,
                ["width"] = -1,
                ["nowrap"] = 1,
            },
            {
                ["type"] = "Label",
                ["text"] = "分钟后切换下一账号",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["width"] = -1,
            },
            {
                ["type"] = "Label",
                ["text"] = "顶号等待",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["nowrap"] = 1,
                ["width"] = -1,
            },
            {
                ["type"] = "Edit",
                ["id"] = "顶号等待",
                ["prompt"] = "",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["text"] = "15",
                ["size"] = 10,
                ["width"] = -1,
                ["nowrap"] = 1,
            },
            {
                ["type"] = "Label",
                ["text"] = "分钟后重新登录",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["width"] = -1,
            },
            {
                ["type"] = "Label",
                ["text"] = "运行",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["nowrap"] = 1,
                ["width"] = -1,
            },
            {
                ["type"] = "Edit",
                ["id"] = "定时切角色",
                ["prompt"] = "",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["text"] = "",
                ["size"] = 10,
                ["width"] = -1,
                ["nowrap"] = 1,
            },
            {
                ["type"] = "Label",
                ["text"] = "分钟后切换下一角色",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["width"] = -1,
            },
            {
                ["type"] = "Label",
                ["text"] = "选择启动角色（从该角色开始挂机）",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
            },
            {
                ["type"] = "ComboBox", -- 必填，控件类型，下拉框
                ["id"] = "选择启动角色",
                -- 选填，无，控件ID 以 table 格式返回返回值时必填，否则无法获取返回值
                ["list"] = "默认(不切换),角色1,角色2,角色3,角色4,角色5", -- 必填，无，下拉框内容
                ["select"] = "0", -- 选填，0，默认选中项 ID
                ["width"] = 300,
                ["prompt"] = true
            },
            {
                ["type"] = "Switch",
                ["id"] = "角色1开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                ["type"] = "Label",
                ["text"] = "角色1",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["width"] = -1,
            },
            {
                ["type"] = "Switch",
                ["id"] = "角色2开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                ["type"] = "Label",
                ["text"] = "角色2",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["width"] = -1,
            },
            {
                ["type"] = "Switch",
                ["id"] = "角色3开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                ["type"] = "Label",
                ["text"] = "角色3",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["width"] = -1,
            },
            {
                ["type"] = "Switch",
                ["id"] = "角色4开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                ["type"] = "Label",
                ["text"] = "角色4",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["width"] = -1,
            },
            {
                ["type"] = "Switch",
                ["id"] = "角色5开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 1
            },
            {
                ["type"] = "Label",
                ["text"] = "角色5",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,0,0",
                ["width"] = -1,
            },
        },
        {
            {
                ["type"] = "Label",
                ["text"] = "=== 开启日常功能",
                ["size"] = 16,
                ["align"] = "center",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
                ["nowrap"] = 1,
            },
            {
                ["type"] = "Switch",
                ["id"] = "日常功能开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "on",
                ["width"] = -1,
            },
            {
                ["type"] = "Label",
                ["text"] = "旅人相关",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "装备相关",
                -- 必填，无 ，单选框内容
                ["list"] = "自动强化装备,自动更换装备,满包裹分解装备,自动升级技能,领取猫猫包果木,猫猫包自动升温",
                -- 选填，0，默认选中项 ID
                ["select"] = "",
                ["width"] = 700,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Label",
                ["text"] = "钻石兑换果木次数",
                ["nowrap"] = 1, --下个控件不换行
                ["width"] = -1
            },
            {
                ["type"] = "Edit",
                ["id"] = "钻石兑换果木次数",
                ["prompt"] = "钻石兑换果木次数",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["size"] = 10,
                ["width"] = 250,
            },
            {
                ["type"] = "Label",
                ["text"] = "高级配置：",
                ["align"] = "left",
                ["valign"] = "top",
                ["width"] = -1
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "旅人高级配置",
                -- 必填，无 ，单选框内容
                ["list"] = "优先升级同一技能至下一阶段",
                -- 选填，0，默认选中项 ID
                ["select"] = "",
                ["width"] = -1,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "1"
            },
            {
                ["type"] = "Label",
                ["text"] = "战斗相关",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "战斗相关",
                -- 必填，无 ，单选框内容
                ["list"] = "自动挑战首领,自动换图,队员不满足单飞,单飞后寻找结伴",
                -- 选填，0，默认选中项 ID
                ["select"] = "0@1",
                ["width"] = 700,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Label",
                ["text"] = "领取相关",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "领取相关",
                -- 必填，无 ，单选框内容
                ["list"] = "冒险手册领取,邮件领取,招式创造,骑兽乐园",
                -- 选填，0，默认选中项 ID
                ["select"] = "",
                ["width"] = 700,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Label",
                ["text"] = "钻石兑换卢恩次数",
                ["nowrap"] = 1, --下个控件不换行
                ["width"] = -1
            },
            {
                ["type"] = "Edit",
                ["id"] = "钻石兑换卢恩次数",
                ["prompt"] = "钻石兑换卢恩次数",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["size"] = 10,
                ["width"] = 250,
            },
            {
                ["type"] = "Label",
                ["text"] = "讲述故事次数",
                ["nowrap"] = 1, --下个控件不换行
                ["width"] = -1
            },
            {
                ["type"] = "Edit",
                ["id"] = "讲述故事次数",
                ["prompt"] = "讲述故事次数",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["size"] = 10,
                ["width"] = 250,
            },
            {
                ["type"] = "Label",
                ["text"] = "钻石兑换门票次数",
                ["nowrap"] = 1, --下个控件不换行
                ["width"] = -1
            },
            {
                ["type"] = "Edit",
                ["id"] = "钻石兑换门票次数",
                ["prompt"] = "钻石兑换门票次数",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["size"] = 10,
                ["width"] = 250,
            },
            {
                ["type"] = "Label",
                ["text"] = "骑兽探索次数",
                ["nowrap"] = 1, --下个控件不换行
                ["width"] = -1
            },
            {
                ["type"] = "Edit",
                ["id"] = "骑兽探索次数",
                ["prompt"] = "骑兽探索次数",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["size"] = 10,
                ["width"] = 250,
            },
            {
                ["type"] = "Label",
                ["text"] = "活动相关",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "活动相关",
                -- 必填，无 ，单选框内容
                ["list"] = "摸鱼时间到,火力全开,宝藏湖,登录好礼,BBQ派对,限时特惠",
                -- 选填，0，默认选中项 ID
                ["select"] = "",
                ["width"] = 700,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            }
        },
        {
            {
                ["type"] = "Label",
                ["text"] = "=== 开启冒险功能",
                ["size"] = 16,
                ["align"] = "left",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
                ["nowrap"] = 1 --下个控件不换行
            },
            {
                ["type"] = "Switch",
                ["id"] = "冒险功能开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 0
            },
            {
                ["type"] = "Label",
                ["text"] = "秘境之间：",
                ["align"] = "left",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
                ["nowrap"] = 1 --下个控件不换行
            },
            {
                ["type"] = "Switch",
                ["id"] = "秘境开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 0
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "秘境关卡相关",
                -- 必填，无 ，单选框内容
                ["list"] = "不开宝箱,点赞队友,添加佣兵,无体力继续,创建房间",
                -- 选填，0，默认选中项 ID
                ["select"] = "1",
                ["width"] = 650,
                ["scale"] = "0.2",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Label",
                ["text"] = "建房重复挑战次数：",
                ["size"] = 12,
                ["align"] = "left",
                ["valign"] = "top",
                ["color"] = "0,0,0",
                ["width"] = -1,
                ["nowrap"] = 1, --下个控件不换行
            },
            {
                ["type"] = "Edit",
                ["id"] = "房间挑战次数",
                ["prompt"] = "房间挑战次数",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["size"] = 10,
                ["width"] = 250,
            },
            {
                ["type"] = "Label",
                ["text"] = "秘境关卡：",
                ["nowrap"] = 0
            },
            {
                ["type"] = "ComboBox", -- 必填，控件类型，下拉框
                ["id"] = "秘境地图",
                -- 选填，无，控件ID 以 table 格式返回返回值时必填，否则无法获取返回值
                ["list"] = "原野,森林,沙漠,海湾,深林,冰原,火山,高原,绿洲,火原", -- 必填，无，下拉框内容
                ["select"] = "0", -- 选填，0，默认选中项 ID
                ["data"] = "古遗迹上的幽影#" ..
                    "旧国之王的野心#" ..
                    "三宝齐聚黄金船#" ..
                    "海洋征服计划#" ..
                    "噩兆降临之谷#" ..
                    "永冻禁区矿场,尤弥尔深渊#" ..
                    "蒸汽炎池浴场,艾特拉之心#" ..
                    "雷电焦土深处,九王角斗场#" .. "溪谷大暴走,躁动绿洲之丘,白沙渊下的鼓动#" .. "浴火燃墟伐木场,激战构造体工厂,无始无终燃烧塔",
                ["source"] = "秘境关卡",
                ["nowrap"] = 1, --下个控件不换行
                ["width"] = 300,
                ["prompt"] = true
            },
            {
                ["type"] = "ComboBox", -- 必填，控件类型，下拉框
                ["id"] = "秘境关卡", -- 选填，无控件 ID，以 table 格式返回返回值时必填，否则无法获取返回值
                ["dataSource"] = "秘境关卡",
                ["select"] = "0", -- 选填，无，子选项下拉框默认选中项
                ["width"] = 500,
                ["prompt"] = true
            },
            {
                ["type"] = "Label",
                ["text"] = "补充体力次数（钻石）",
                ["nowrap"] = 1, --下个控件不换行
                ["width"] = -1
            },
            {
                ["type"] = "ComboBox", -- 必填，控件类型，下拉框
                ["id"] = "补充体力次数",
                -- 选填，无，控件ID 以 table 格式返回返回值时必填，否则无法获取返回值
                ["list"] = "0,1,2,3", -- 必填，无，下拉框内容
                ["select"] = "0",     -- 选填，0，默认选中项 ID
                ["width"] = 300,
                ["prompt"] = true
            },
            {
                ["type"] = "Label",
                ["text"] = "队伍喊话：",
                ["nowrap"] = 1, --下个控件不换行
                ["width"] = -1
            },
            {
                ["type"] = "Edit",
                ["id"] = "喊话内容",
                ["prompt"] = "喊话内容",
                ["kbtype"] = "ascii",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["size"] = 10,
                ["width"] = 250,
            },
            {
                ["type"] = "Label",
                ["text"] = "恶龙大通缉：",
                ["align"] = "left",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
                ["nowrap"] = 1 --下个控件不换行
            },
            {
                ["type"] = "Switch",
                ["id"] = "恶龙大通缉开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
                ["nowrap"] = 0
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "恶龙大通缉相关",
                -- 必填，无 ，单选框内容
                ["list"] = "添加佣兵,重复挑战",
                -- 选填，0，默认选中项 ID
                ["select"] = "1,2",
                ["width"] = 700,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Label",
                ["text"] = "暴走史莱姆：",
                ["align"] = "left",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
                ["nowrap"] = 1 --下个控件不换行
            },
            {
                ["type"] = "Switch",
                ["id"] = "暴走史莱姆开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
            },
            {
                ["type"] = "Label",
                ["text"] = "(！建议关闭队友特效/伤害/血条后使用)",
                ["align"] = "left",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
            },
            {
                ["type"] = "ComboBox", -- 必填，控件类型，下拉框
                ["id"] = "史莱姆地图",
                -- 选填，无，控件ID 以 table 格式返回返回值时必填，否则无法获取返回值
                ["list"] = "暴走雷电大王", -- 必填，无，下拉框内容
                ["select"] = "0", -- 选填，0，默认选中项 ID
                ["width"] = 300,
                ["prompt"] = true
            },
            {
                ["type"] = "Label",
                ["text"] = "职能相关：",
                ["align"] = "left",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "RadioGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "职能相关",
                -- 必填，无 ，单选框内容
                ["list"] = "职能优先输出,职能优先坦克,职能优先治疗",
                -- 选填，0，默认选中项 ID
                ["select"] = "1",
                ["width"] = 700,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Label",
                ["text"] = "通用配置：",
                ["align"] = "left",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "秘境通用配置",
                -- 必填，无 ，单选框内容
                ["list"] = "主动释放技能(自动点击技能释放),三技能自动开盾/打断(需开启主动释放)",
                -- 选填，0，默认选中项 ID
                ["select"] = "1",
                ["width"] = 700,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "1"
            },
        },
        {
            {
                ["type"] = "Label",
                ["text"] = "=== 开启营地功能",
                ["size"] = 16,
                ["align"] = "center",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
                ["nowrap"] = 1,
            },
            {
                ["type"] = "Switch",
                ["id"] = "营地功能开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
            },
            {
                ["type"] = "Label",
                ["text"] = "营地相关",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "营地相关",
                -- 必填，无 ，单选框内容
                ["list"] = "仓鼠百货,月签到,日礼包,月卡,星辰同行,纸飞机,秘宝收集,露营打卡点",
                -- 选填，0，默认选中项 ID
                ["select"] = "0@1",
                ["width"] = 700,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Label",
                ["text"] = "仓鼠百货付费购买",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "商店选项",
                -- 必填，无 ，单选框内容
                ["list"] = "星星经验,全价兽粮,超级成长零食(三折),黑烬突破石(五折),经验补剂(五折)",
                -- 选填，0，默认选中项 ID
                ["select"] = "",
                ["width"] = 700,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            },
            {
                ["type"] = "Label",
                ["text"] = "秘宝地图：",
                ["nowrap"] = 1, --下个控件不换行
                ["width"] = -1
            },
            {
                ["type"] = "ComboBox", -- 必填，控件类型，下拉框
                ["id"] = "秘宝地图",
                -- 选填，无，控件ID 以 table 格式返回返回值时必填，否则无法获取返回值
                ["list"] = "暗月深林,艾特拉火山,鲁尔绿洲,燃烧塔", -- 必填，无，下拉框内容
                ["select"] = "0", -- 选填，0，默认选中项 ID
                ["width"] = 300,
                ["prompt"] = true
            },
            {
                ["type"] = "Label",
                ["text"] = "秘宝钻石兑换次数：",
                ["size"] = 12,
                ["align"] = "left",
                ["valign"] = "top",
                ["color"] = "0,0,0",
                ["width"] = -1,
                ["nowrap"] = 1, --下个控件不换行
            },
            {
                ["type"] = "Edit",
                ["id"] = "能源兑换次数",
                ["prompt"] = "能源兑换次数",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["size"] = 10,
                ["width"] = 250,
            },
        },
        {
            {
                ["type"] = "Label",
                ["text"] = "=== 开启旅团功能",
                ["size"] = 16,
                ["align"] = "center",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
                ["nowrap"] = 1,
            },
            {
                ["type"] = "Switch",
                ["id"] = "旅团功能开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "旅团功能",
                ["size"] = 12,
                -- 必填，无 ，单选框内容
                ["list"] = "旅团浇树,旅团调查队,旅团任务,旅团许愿墙",
                -- 选填，0，默认选中项 ID
                ["select"] = "0",
                ["width"] = 700,
                ["scale"] = "0.3",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2",
                -- ["nowrap"] = 1, --下个控件不换行
            },
            {
                ["type"] = "Label",
                ["text"] = "付费浇灌次数：",
                ["size"] = 12,
                ["align"] = "left",
                ["valign"] = "top",
                ["color"] = "0,0,0",
                ["width"] = -1,
                ["nowrap"] = 1, --下个控件不换行
            },
            {
                ["type"] = "Edit",
                ["id"] = "付费浇灌次数",
                ["prompt"] = "付费浇灌次数",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["size"] = 10,
                ["width"] = 250,
            },
            {
                ["type"] = "Label",
                ["text"] = "调查队挑战次数：",
                ["size"] = 12,
                ["align"] = "left",
                ["valign"] = "top",
                ["color"] = "0,0,0",
                ["width"] = -1,
                ["nowrap"] = 1, --下个控件不换行
            },
            {
                ["type"] = "Edit",
                ["id"] = "调查队挑战次数",
                ["prompt"] = "调查队挑战次数",
                ["kbtype"] = "number",
                ["color"] = "0,0,0",
                ["align"] = "center",
                ["valign"] = "top",
                ["size"] = 10,
                ["width"] = 250,
            },
            {
                ["type"] = "Label",
                ["text"] = "旅团商店兑换(默认最大次数兑换)",
                ["size"] = 15,
                ["align"] = "left",
                ["color"] = "0,150,255",
                ["nowrap"] = 1,
                ["width"] = -1,
            },
            {
                ["type"] = "Switch",
                ["id"] = "旅团商店兑换开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
            },
            {
                --必填，控件类型，多选组合
                ["type"] = "CheckBoxGroup",
                -- 选填，无，控件 ID  以 table 格式返回返回值时必填，否则无法获取返回值
                ["id"] = "旅团商店选项",
                -- 必填，无 ，单选框内容
                ["list"] = "唤兽琴弦,全价兽粮,超级成长零食,原材料,史诗经验,优秀经验,普通经验,金币",
                -- 选填，0，默认选中项 ID
                ["select"] = "",
                ["width"] = 700,
                ["scale"] = "0.4",
                --选填，1，仅引擎版本支持 iOS v3.00-157 及 Android v2.3.6 及其以上版本
                ["countperline"] = "2"
            }
        },
        {
            {
                ["type"] = "Label",
                ["text"] = "=== 调试开关(请勿开启)",
                ["size"] = 16,
                ["align"] = "center",
                ["valign"] = "top",
                ["color"] = "0,150,255",
                ["width"] = -1,
                ["nowrap"] = 1,
            },
            {
                ["type"] = "Switch",
                ["id"] = "调试开关",
                ["size"] = "s",
                ["align"] = "left",
                ["valign"] = "top",
                ["state"] = "off",
                ["width"] = -1,
            }
        }
    }
}
MyJsonString = cjson.encode(MyTable)
UIret, values = showUI(MyJsonString)
功能开关 = {
    -- 日常
    ["日常功能开关"] = 0,
    ["自动强化装备"] = 0,
    ["自动更换装备"] = 0,
    ["满包裹分解装备"] = 0,
    ["自动升级技能"] = 0,
    ["优先升级同一技能"] = 0,
    ["猫猫包果木"] = 0,
    ["猫猫包自动升温"] = 0,
    ["钻石兑换果木次数"] = 0,
    ["秘宝地图"] = 0,
    ["能源兑换次数"] = 0,

    ["自动挑战首领"] = 0,
    ["自动换图"] = 0,
    ["队员不满足单飞"] = 0,
    ["单飞后寻找结伴"] = 0,

    ["冒险手册领取"] = 0,
    ["邮件领取"] = 0,
    ["招式创造"] = 0,
    ["招式创造-讲述次数"] = 0,
    ["骑兽乐园"] = 0,
    ["骑兽乐园-探索次数"] = 0,
    ["钻石兑换卢恩次数"] = 0,
    ["钻石兑换门票次数"] = 0,

    ["摸鱼时间到"] = 0,
    ["火力全开"] = 0,
    ["宝藏湖"] = 0,
    ["登录好礼"] = 0,
    ["BBQ派对"] = 0,
    ["限时特惠"] = 0,

    -- 冒险
    ["冒险功能开关"] = 0,
    ["秘境开关"] = 0,
    ["秘境地图"] = 0,
    ["秘境关卡"] = 0,
    ["补充体力次数"] = 0,
    ["秘境-不开宝箱"] = 0,
    ["秘境-点赞队友"] = 0,
    ["秘境-添加佣兵"] = 0,
    ["秘境-体力不足继续挑战"] = 0,
    ["秘境-创建房间"] = 0,
    ["秘境-房间挑战次数"] = 0,
    ["喊话内容"] = "",

    ["恶龙大通缉开关"] = 0,
    ["恶龙-添加佣兵"] = 0,
    ["恶龙-重复挑战"] = 0,

    ["暴走史莱姆开关"] = 0,
    ["暴走-暴走雷电大王"] = 0,

    ["职能-优先输出"] = 0,
    ["职能-优先坦克"] = 0,
    ["职能-优先治疗"] = 0,

    ["通用-主动释放技能"] = 0,
    ["通用-三技能打断"] = 0,

    -- 营地
    ["营地功能开关"] = 0,
    ["仓鼠百货"] = 0,
    ["月签到"] = 0,
    ["日礼包"] = 0,
    ["月卡"] = 0,
    ["星辰同行"] = 0,
    ["纸飞机"] = 0,
    ["露营打卡点"] = 0,
    ["商店-星星经验"] = 0,
    ["商店-全价兽粮"] = 0,
    ["商店-超级成长零食(三折)"] = 0,
    ["商店-黑烬突破石(五折)"] = 0,
    ["商店-经验补剂(五折)"] = 0,

    ["秘宝收集"] = 0,

    -- 旅团
    ["旅团功能开关"] = 0,
    ["旅团浇树"] = 0,
    ["付费浇树次数"] = 0,
    ["旅团调查队"] = 0,
    ["旅团任务"] = 0,
    ["旅团许愿墙"] = 0,
    ["调查队挑战次数"] = 0,
    ["旅团商店兑换开关"] = 0,
    ["旅团商店-唤兽琴弦"] = 0,
    ["旅团商店-全价兽粮"] = 0,
    ["旅团商店-超级成长零食"] = 0,
    ["旅团商店-原材料"] = 0,
    ["旅团商店-史诗经验"] = 0,
    ["旅团商店-优秀经验"] = 0,
    ["旅团商店-普通经验"] = 0,
    ["旅团商店-金币"] = 0,

    ["调试开关"] = 0,

    ["账号1开关"] = 0,
    ["账号1保存"] = 0,
    ["账号2开关"] = 0,
    ["账号2保存"] = 0,
    ["账号3开关"] = 0,
    ["账号3保存"] = 0,
    ["账号4开关"] = 0,
    ["账号4保存"] = 0,
    ["账号5开关"] = 0,
    ["账号5保存"] = 0,

    ["角色1开关"] = 0,
    ["角色2开关"] = 0,
    ["角色3开关"] = 0,
    ["角色4开关"] = 0,
    ["角色5开关"] = 0,

}
if UIret == 1 then
    功能开关["定时运行"] = values.定时运行
    功能开关["定时休息"] = values.定时休息
    功能开关["定时切号"] = values.定时切号
    功能开关["定时切角色"] = values.定时切角色
    功能开关["顶号等待"] = values.顶号等待

    功能开关["选择启动账号"] = values.选择启动账号
    功能开关["选择启动角色"] = values.选择启动角色
    if values.角色1开关 == "on" then
        功能开关["角色1开关"] = 1
    end
    if values.角色2开关 == "on" then
        功能开关["角色2开关"] = 1
    end
    if values.角色3开关 == "on" then
        功能开关["角色3开关"] = 1
    end
    if values.角色4开关 == "on" then
        功能开关["角色4开关"] = 1
    end
    if values.角色5开关 == "on" then
        功能开关["角色5开关"] = 1
    end

    if values.账号1开关 == "on" then
        功能开关["账号1开关"] = 1
    end
    local 账号1配置 = values.账号1配置
    账号1配置 = 账号1配置:split("@")
    for i = 1, #账号1配置, 1 do
        if 账号1配置[i] == "0" then
            功能开关["账号1保存"] = 1
        end
    end

    if values.账号2开关 == "on" then
        功能开关["账号2开关"] = 1
    end
    local 账号2配置 = values.账号2配置
    账号2配置 = 账号2配置:split("@")
    for i = 1, #账号2配置, 1 do
        if 账号2配置[i] == "0" then
            功能开关["账号2保存"] = 1
        end
    end

    if values.账号3开关 == "on" then
        功能开关["账号3开关"] = 1
    end
    local 账号3配置 = values.账号3配置
    账号3配置 = 账号3配置:split("@")
    for i = 1, #账号3配置, 1 do
        if 账号3配置[i] == "0" then
            功能开关["账号3保存"] = 1
        end
    end

    if values.账号4开关 == "on" then
        功能开关["账号4开关"] = 1
    end
    local 账号4配置 = values.账号4配置
    账号4配置 = 账号4配置:split("@")
    for i = 1, #账号4配置, 1 do
        if 账号4配置[i] == "0" then
            功能开关["账号4保存"] = 1
        end
    end

    if values.账号5开关 == "on" then
        功能开关["账号5开关"] = 1
    end
    local 账号5配置 = values.账号5配置
    账号5配置 = 账号5配置:split("@")
    for i = 1, #账号5配置, 1 do
        if 账号5配置[i] == "0" then
            功能开关["账号5保存"] = 1
        end
    end

    if values.日常功能开关 == "on" then
        功能开关["日常功能开关"] = 1
    end

    local 装备相关 = values.装备相关
    装备相关 = 装备相关:split("@")
    for i = 1, #装备相关, 1 do
        if 装备相关[i] == "0" then
            功能开关["自动强化装备"] = 1
        elseif 装备相关[i] == "1" then
            功能开关["自动更换装备"] = 1
        elseif 装备相关[i] == "2" then
            功能开关["满包裹分解装备"] = 1
        elseif 装备相关[i] == "3" then
            功能开关["自动升级技能"] = 1
        elseif 装备相关[i] == "4" then
            功能开关["猫猫包果木"] = 1
        elseif 装备相关[i] == "5" then
            功能开关["猫猫包自动升温"] = 1
        end
    end

    local 旅人高级配置 = values.旅人高级配置
    旅人高级配置 = 旅人高级配置:split("@")
    for i = 1, #旅人高级配置, 1 do
        if 旅人高级配置[i] == "0" then
            功能开关["优先升级同一技能"] = 1
        end
    end

    功能开关["钻石兑换果木次数"] = values.钻石兑换果木次数
    功能开关["能源兑换次数"] = values.能源兑换次数

    local 战斗相关 = values.战斗相关
    战斗相关 = 战斗相关:split("@")
    for i = 1, #战斗相关, 1 do
        if 战斗相关[i] == "0" then
            功能开关["自动挑战首领"] = 1
        elseif 战斗相关[i] == "1" then
            功能开关["自动换图"] = 1
        elseif 战斗相关[i] == "2" then
            功能开关["队员不满足单飞"] = 1
        elseif 战斗相关[i] == "3" then
            功能开关["单飞后寻找结伴"] = 1
        end
    end

    local 领取相关 = values.领取相关
    领取相关 = 领取相关:split("@")
    for i = 1, #领取相关, 1 do
        if 领取相关[i] == "0" then
            功能开关["冒险手册领取"] = 1
        end
        if 领取相关[i] == "1" then
            功能开关["邮件领取"] = 1
        end
        if 领取相关[i] == "2" then
            功能开关["招式创造"] = 1
        end
        if 领取相关[i] == "3" then
            功能开关["骑兽乐园"] = 1
        end
    end
    功能开关["钻石兑换卢恩次数"] = values.钻石兑换卢恩次数
    功能开关["钻石兑换门票次数"] = values.钻石兑换门票次数
    功能开关["招式创造-讲述次数"] = values.讲述故事次数
    功能开关["骑兽乐园-探索次数"] = values.骑兽探索次数

    local 活动相关 = values.活动相关
    活动相关 = 活动相关:split("@")
    for i = 1, #活动相关, 1 do
        if 活动相关[i] == "0" then
            功能开关["摸鱼时间到"] = 1
        end
        if 活动相关[i] == "1" then
            功能开关["火力全开"] = 1
        end
        if 活动相关[i] == "2" then
            功能开关["宝藏湖"] = 1
        end
        if 活动相关[i] == "3" then
            功能开关["登录好礼"] = 1
        end
        if 活动相关[i] == "4" then
            功能开关["BBQ派对"] = 1
        end
        if 活动相关[i] == "5" then
            功能开关["限时特惠"] = 1
        end
    end

    if values.冒险功能开关 == "on" then
        功能开关["冒险功能开关"] = 1
    end
    if values.秘境开关 == "on" then
        功能开关["秘境开关"] = 1
    end
    local 秘境关卡相关 = values.秘境关卡相关
    秘境关卡相关 = 秘境关卡相关:split("@")
    for i = 1, #秘境关卡相关, 1 do
        if 秘境关卡相关[i] == "0" then
            功能开关["秘境-不开宝箱"] = 1
        end
        if 秘境关卡相关[i] == "1" then
            功能开关["秘境-点赞队友"] = 1
        end
        if 秘境关卡相关[i] == "2" then
            功能开关["秘境-添加佣兵"] = 1
        end
        if 秘境关卡相关[i] == "3" then
            功能开关["秘境-体力不足继续挑战"] = 1
        end
        if 秘境关卡相关[i] == "4" then
            功能开关["秘境-创建房间"] = 1
        end
    end
    功能开关["秘境地图"] = values.秘境地图
    功能开关["秘境关卡"] = values.秘境关卡
    功能开关["补充体力次数"] = values.补充体力次数
    功能开关["秘境-房间挑战次数"] = values.房间挑战次数
    功能开关["喊话内容"] = values.喊话内容

    if values.恶龙大通缉开关 == "on" then
        功能开关["恶龙大通缉开关"] = 1
    end
    local 恶龙大通缉相关 = values.恶龙大通缉相关
    恶龙大通缉相关 = 恶龙大通缉相关:split("@")
    for i = 1, #恶龙大通缉相关, 1 do
        if 恶龙大通缉相关[i] == "0" then
            功能开关["恶龙-添加佣兵"] = 1
        end
        if 恶龙大通缉相关[i] == "1" then
            功能开关["恶龙-重复挑战"] = 1
        end
    end

    if values.暴走史莱姆开关 == "on" then
        功能开关["暴走史莱姆开关"] = 1
    end
    local 史莱姆地图 = values.史莱姆地图
    史莱姆地图 = 史莱姆地图:split("@")
    for i = 1, #史莱姆地图, 1 do
        if 史莱姆地图[i] == "0" then
            功能开关["暴走-暴走雷电大王"] = 1
        end
    end

    local 职能相关 = values.职能相关
    职能相关 = 职能相关:split("@")
    for i = 1, #职能相关, 1 do
        if 职能相关[i] == "0" then
            功能开关["职能-优先输出"] = 1
        end
        if 职能相关[i] == "1" then
            功能开关["职能-优先坦克"] = 1
        end
        if 职能相关[i] == "2" then
            功能开关["职能-优先治疗"] = 1
        end
        if 职能相关[i] == "3" then
            功能开关["通用-主动释放技能"] = 1
        end
    end

    local 秘境通用配置 = values.秘境通用配置
    秘境通用配置 = 秘境通用配置:split("@")
    for i = 1, #秘境通用配置, 1 do
        if 秘境通用配置[i] == "0" then
            功能开关["通用-主动释放技能"] = 1
        end
        if 秘境通用配置[i] == "1" then
            功能开关["通用-三技能打断"] = 1
        end
    end

    if values.营地功能开关 == "on" then
        功能开关["营地功能开关"] = 1
    end
    local 营地相关 = values.营地相关
    营地相关 = 营地相关:split("@")
    for i = 1, #营地相关, 1 do
        if 营地相关[i] == "0" then
            功能开关["仓鼠百货"] = 1
        end
        if 营地相关[i] == "1" then
            功能开关["月签到"] = 1
        end
        if 营地相关[i] == "2" then
            功能开关["日礼包"] = 1
        end
        if 营地相关[i] == "3" then
            功能开关["月卡"] = 1
        end
        if 营地相关[i] == "4" then
            功能开关["星辰同行"] = 1
        end
        if 营地相关[i] == "5" then
            功能开关["纸飞机"] = 1
        end
        if 营地相关[i] == "6" then
            功能开关["秘宝收集"] = 1
        end
        if 营地相关[i] == "7" then
            功能开关["露营打卡点"] = 1
        end
    end
    功能开关["秘宝地图"] = values.秘宝地图

    local 商店选项 = values.商店选项
    商店选项 = 商店选项:split("@")
    for i = 1, #商店选项, 1 do
        if 商店选项[i] == "0" then
            功能开关["商店-星星经验"] = 1
        end
        if 商店选项[i] == "1" then
            功能开关["商店-全价兽粮"] = 1
        end
        if 商店选项[i] == "2" then
            功能开关["商店-超级成长零食(三折)"] = 1
        end
        if 商店选项[i] == "3" then
            功能开关["商店-黑烬突破石(五折)"] = 1
        end
        if 商店选项[i] == "4" then
            功能开关["商店-经验补剂(五折)"] = 1
        end
    end

    if values.旅团功能开关 == "on" then
        功能开关["旅团功能开关"] = 1
    end
    local 旅团功能 = values.旅团功能
    旅团功能 = 旅团功能:split("@")
    for i = 1, #旅团功能, 1 do
        if 旅团功能[i] == "0" then
            功能开关["旅团浇树"] = 1
        end
        if 旅团功能[i] == "1" then
            功能开关["旅团调查队"] = 1
        end
        if 旅团功能[i] == "2" then
            功能开关["旅团任务"] = 1
        end
        if 旅团功能[i] == "3" then
            功能开关["旅团许愿墙"] = 1
        end
    end

    if values.旅团商店兑换开关 == "on" then
        功能开关["旅团商店兑换开关"] = 1
    end
    local 旅团商店选项 = values.旅团商店选项
    旅团商店选项 = 旅团商店选项:split("@")
    for i = 1, #旅团商店选项, 1 do
        if 旅团商店选项[i] == "0" then
            功能开关["旅团商店-唤兽琴弦"] = 1
        end
        if 旅团商店选项[i] == "1" then
            功能开关["旅团商店-全价兽粮"] = 1
        end
        if 旅团商店选项[i] == "2" then
            功能开关["旅团商店-超级成长零食"] = 1
        end
        if 旅团商店选项[i] == "3" then
            功能开关["旅团商店-原材料"] = 1
        end
        if 旅团商店选项[i] == "4" then
            功能开关["旅团商店-史诗经验"] = 1
        end
        if 旅团商店选项[i] == "5" then
            功能开关["旅团商店-优秀经验"] = 1
        end
        if 旅团商店选项[i] == "6" then
            功能开关["旅团商店-普通经验"] = 1
        end
        if 旅团商店选项[i] == "7" then
            功能开关["旅团商店-金币"] = 1
        end
    end

    功能开关["付费浇树次数"] = values.付费浇灌次数
    功能开关["调查队挑战次数"] = values.调查队挑战次数

    if values.调试开关 == "on" then
        功能开关["调试开关"] = 1
    end

    local 配置更新 = values.配置更新
    local 配置选择 = values.配置选择
    uiConfigFile = userPath() .. "/log/" .. "uiConfig" .. 配置选择 .. ".txt"
    if 配置更新 == "0" then
        -- 更新当前配置
        local json_str = json.encode(功能开关)
        writeFileString(uiConfigFile, json_str)
    elseif 配置更新 == "1" then -- 默认配置不需要从文件加载
        -- 读取当前配置并启动
        uiConfig = readFileString(uiConfigFile)
        local success, decodedText = pcall(function() return json.decode(uiConfig) end)
        if not success then
            dialog("配置加载错误")
            lua_exit()
        else
            功能开关 = decodedText
        end
    end

    --local json_str = json.encode(功能开关)
    --dialog(json_str)
else
    dialog("脚本退出，请重新设置功能开关")
    lua_exit()
end
