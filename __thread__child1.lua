while (true) do
    dialog("killdialog")
    res = baseUtils.TomatoOCRTap(tomatoOCR, 268, 869, 359, 888, "点击空白处", 30, 100)
    res2 = baseUtils.TomatoOCRTap(tomatoOCR, 279, 1079, 440, 1099, "点击空白处可领取奖励", 30, 100)
    res3 = baseUtils.TomatoOCRTap(tomatoOCR, 266, 863, 453, 890, "点击空白处可领取奖励", 30, 100)
    res4 = baseUtils.TomatoOCRTap(tomatoOCR, 296, 1207, 424, 1232, "点击空白处关闭", 30, 100)
    if res or res2 or res3 or res4 then
        baseUtils.mSleep3(5000)
        logUtils.log("发现弹窗-点击空白处")
        dialog("killdialog2")
    else
        baseUtils.mSleep3(5000)
    end
end
