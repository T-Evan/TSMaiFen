
-- 本页函数具有通用性,可移植
-- 引入常用的库,以保证函数库可以独立使用,多次引入不影响效率
local ts = ts or require("ts") --苏泽库升级版
require("TSLib")


----------------------------------------------------------------------------
-- 函数名称 : nlog
-- 函数功能 : 注意是小写,nLog前面添加时间,table乱序更容易找顺序
-- 函数参数 : 
-- 函数返回 : 无

function nLog3(text)
	toast()
	nLog("["..os.date("%H:%M:%S")..string.sub(ts.ms(),11).."]  "..text)
end


----------------------------------------------------------------------------
-- 函数名称 : tap3
-- 函数功能 : 模糊点击,按下抬起一次,随机停留时间,替代精确点击tap(x,y,ms,pic)  https://wenku.baidu.com/view/a8660cb558fb770bf78a55bc.html
-- 函数参数 : 两种格式: 1.(table x,...)传入table格式 2.(number x,number y)传入xy坐标格式
-- 函数返回 : 无

function tap3(x,y)
	local x1,y1
	if type(x) == "table" then 
		x1,y1 = x[1],x[2]
	else
		x1,y1 = x,y
	end
	x1,y1 = x1 + math.random(-10,10) , y1 + math.random(-10,10)  --模糊20像素
	tap(x1,y1,math.random(100,500)) 
	nLog3(" -模糊点击：("..x1..","..y1..")")
end


----------------------------------------------------------------------------
-- 函数名称 : randomsTap3
-- 函数功能 : 模糊滑动点击,按下-抖动-滑动随机坐标-抬起,有滑动过程,随机停留时间
-- 函数参数 : 两种格式: 1.(table x,...)传入table格式 2.(number x,number y)传入xy坐标格式
-- 函数返回 : 无

function randomsTap3(x,y)
	local x1,y1
	if type(x) == "table" then 
		x1,y1 = x[1],x[2]
	else
		x1,y1 = x,y
	end
	randomsTap(x1,y1,20)
	nLog3(" -模糊抖动点击：("..x1..","..y1..")")
end


----------------------------------------------------------------------------
-- 函数名称 : moveTo3
-- 函数功能 : 模糊滑动,直线滑动
-- 函数参数 : (number x1,number y1, number x2,number y2)从坐标x1y1移动到x2y2, 坐标值会随机模糊,抬起时间也模糊
-- 函数返回 : 无

function moveTo3(x1,y1,x2,y2)
	local x1,y1,x2,y2 = x1 + math.random(-20,20),y1 + math.random(-20,20),x2 + math.random(-20,20),y2 + math.random(-20,20)  --模糊20像素
	touch():on(x1,y1):Step(1):Delay(16):move(x2,y2):Step(1):Delay(20):move(x2+1,y2):off()
	nLog3(" -移动: "..x1..","..y1.." - "..x2..","..y2)
end


----------------------------------------------------------------------------
-- 函数名称 : isColor3
-- 函数功能 : 找色,和原版一样,第一个参数可以为table
-- 函数参数 : 两种格式: 1.(table x,...)传入table格式 2.(number x,number y)传入xy坐标格式
-- 函数返回 : boolean值

function isColor3(x,y,c)
	local x1,y1
	if type(x) == "table" then 
		x1,y1,c = x[1],x[2],x[3]
	else
		x1,y1,c = x,y,c
	end
	--nLog3(" -模糊找色："..x1..","..y1)
	return isColor(x1,y1,c,90) 
end


----------------------------------------------------------------------------
-- 函数名称 : isColorTap3
-- 函数功能 : 找色并点击
-- 函数参数 : 两种格式: 1.(table x,...)传入table格式 2.(number x,number y)传入xy坐标格式
-- 函数返回 : boolean值

function isColorTap3(x,y,c)
	local x1,y1
	if type(x) == "table" then 
		x1,y1,c = x[1],x[2],x[3]
	else
		x1,y1,c = x,y,c
	end
	if isColor(x1,y1,c,90) == true then
		tap3(x1,y1)
		return true
	else
		return false
	end
end


----------------------------------------------------------------------------
-- 函数名称 : mSleep3
-- 函数功能 : 模糊延迟,增加延迟的不确定性
-- 函数参数 : (number t1,number t2) ,模糊t1-t2的毫秒范围,t2可以省略,只有t1时也是模糊延迟
-- 函数返回 : 无

function mSleep3(t1,t2)
	if t2 == nil then
		mSleep(math.random(t1*0.8,t1*1.2))
	else
		mSleep(math.random(t1,t2))
	end
end


----------------------------------------------------------------------------
-- 函数名称 : wakeupDevice
-- 函数功能 : 黑屏或者密码界面-解锁手机到亮屏,上次锁屏时的app界面,如果要在设备自启动时解锁屏幕直接使用 unlockDevice 函数即可
-- 函数参数 : (string password)锁屏密码
-- 函数返回 : 无

function wakeupDevice(password)
	password = password or ""
	flag = deviceIsLock(); 
	if flag == 0 then
		nLog3(" -唤醒设备,设备未锁定");
	else
		unlockDevice(password); 
		sysver = getOSVer();    --获取系统版本
		local t = strSplit(sysver,".") -- 拆分系统版本
		if tonumber(t[1]) >= 10 then  -- 如果大版本大于等于 10 按下 Home 键
			pressHomeKey(0)
		end
		nLog3(" -唤醒设备,设备解锁成功"); 
	end
end


----------------------------------------------------------------------------
-- 函数名称 : waitingApp
-- 函数功能 : 唤醒或启动app到前台
-- 函数参数 : (string bundid,number time)
-- 函数返回 : boolean值

function waitingApp(bid,time)
	time = time or 5000 -- 等待超时时间
	if frontAppBid() == bid then 
		return true
	end
	if runApp(bid) == 0 then
		mSleep(time)
		return true
	end
	return false
end


----------------------------------------------------------------------------
-- 函数名称 : waitingAndClick
-- 函数功能 : 等待页面,可点击某个point, 默认为0层,也可以是其它层
-- 函数参数 : (string page,number time),page:等待出现的页面,point:页面上的点,click:出现并点击,sleeptime:等待间隔，timeout:等待超时时间
-- 函数返回 : boolean值

function waitingAndClick(page,point,timeout,sleeptime)
	sleeptime = sleeptime or 1000  --1秒循环一次
	timeout = timeout or 5000  --超时时5秒

	if type(pages[page][point]) ~= "table" then 
		error(" -错误: waitingAndClick参数 "..page.." 或 "..point.." 不存在!")
	end

	local layer = pages[page][point].layer or 0  -- 获取同层
	local alltime = 0
	local miss = 0
	while true do
		for k,v in pairs(pages[page]) do
			if v.layer == layer and isColor3(v.xycolor) == false then  --同层的点要全部找到
				nLog3(" -错误: waitingAndClick同层 "..page.."."..k.." 未找到!")
				miss = 1
				return false
				--break
			end
			if type(v.click) ~= "table" then  --补全缺省的click = {}
				v.click = v.xycolor
			end
		end	
		if miss == 0 then 
			--nLog3(" ---正确: 查找 "..page.."."..point.." 找到啦!!!")
			break 
		end
		miss = 0
		if alltime >= timeout then
			nLog3(" -错误: waitingAndClick超时: "..page.."."..point.." 未找到!")
			return false
		end
		mSleep(sleeptime)
		alltime = alltime + sleeptime
	end
	nLog3(" -正确: waitingAndClick等待: "..page.."."..point.." 找到了!")
	randomsTap3( pages[page][point].click)
	return true
end


----------------------------------------------------------------------------
-- 函数名称 : waitingPage
-- 函数功能 : 等待页面, 默认为0层
-- 函数参数 : (string page,number time),page:等待出现的页面,sleeptime:等待间隔，timeout:等待超时时间
-- 函数返回 : boolean值

function waitingPage(page,point,timeout,sleeptime)
	sleeptime = sleeptime or 1000  --1秒循环一次
	timeout = timeout or 5000  --超时时5秒

	local layer = 0  
	if type(point) == "string" then
		if type(pages[page][point]) ~= "table" then 
			error(" -错误: isPage参数 "..page.." 或 "..point.." 不存在!")
		end
		layer = pages[page][point].layer   -- 获取同层
	end

	local alltime = 0
	local miss = 0
	while true do
		for k,v in pairs(pages[page]) do
			if v.layer == layer and isColor3(v.xycolor) == false then  --同层的点要全部找到
				nLog3(" -错误: isPage同层 "..page.."."..k.." 未找到!")
				miss = 1
				return false
				--break
			end
		end	
		if miss == 0 then 
			--nLog3(" ---正确: 查找 "..page.."."..point.." 找到啦!!!")
			break 
		end
		miss = 0
		if alltime >= timeout then
			nLog3(" -错误: isPage超时: "..page.." 未找到!")
			return false
		end
		mSleep(sleeptime)
		alltime = alltime + sleeptime
	end
	nLog3(" -正确: isPage等待: "..page.." 找到了!")
	return true
end


----------------------------------------------------------------------------
-- 函数名称 : frontPage
-- 函数功能 : 查找并返回前台页面,用来找页面和层,注意:有可能0层和1层同时出现,这里只能检测到0层
-- 函数参数 : (number timeout,number sleeptime) 
-- 函数返回 : (string page, number layer) 返回两个参数, 未找到都返回nil

function frontPage(timeout,sleeptime)
	sleeptime = sleeptime or 1000  --1秒循环一次
	timeout = timeout or 5000  --超时5秒

	local alltime = 0
	local miss = 0
	while true do
		for k,v in pairs(pages) do

			for k2,v2 in pairs(v) do 
				if v2.layer == 0 then --只检查0层
					if isColor3(v2.xycolor) == true then 
						--nLog3(" -正确: 找点 "..k.."."..k2.." 找到了!!!")
						miss = 0
					else
						--nLog3(" -错误: 找点 "..k.."."..k2.." 未找到!")
						miss = 1
						break -- 本层出错,本层跳出for k2v2, 循环下一层
					end
				end
			end
			nLog3(" -miss: "..miss)
			if miss == 0 then 
				nLog3(" -正确: frontPage: "..k.." 0层的点全部找到了!")
				return k
			end
		end
		miss = 0
		if alltime >= timeout then
			nLog3(" -错误: frontPage: 超时未找到页面!")
			return nil,nil
		end
		mSleep(sleeptime)
		alltime = alltime + sleeptime
	end	
end


----------------------------------------------------------------------------
-- 函数名称 : gotoPage
-- 函数功能 : 自动等待并点击,page1到page2
-- 函数参数 : string 起始页,string 目的页
-- 函数返回 : true或false

function gotoPage(page1,page2)

	local links = getLinks(page1,page2)
	if type(links) == "table" then
		for k2,v2 in ipairs(links) do
			if type(v2[2]) ~= nil then
				if waitingAndClick(v2[1],v2[2]) == false then
					return false
				end
			else
				waitingPage(v2[1])
			end
		end
		return true
	end
	return false
end


----------------------------------------------------------------------------
-- 函数名称 : getLinks
-- 函数功能 : 和上面的list配合使用,自动计算页面到页面的链表,返回table数组类型 参考:https://blog.csdn.net/GeekTalnex/article/details/79821809
-- 函数参数 : string 起始页,string 目的页
-- 函数返回 : table格式的有序链表,找不到路径返回0

function getLinks(page3,page4)

	node = {} -- 页到页,邻接节点二维数组,1代表可达，0或者nil代表不可达
	visited = {} --遍历过得记录
	for k,v in pairs(pages) do --page
		node[k] = {}
		for k1,v1 in pairs(v) do --point
			if type(v1.link) == "table" and type(pages[v1.link[1]]) == "table" then  -- 判断link是否存在,并剪枝,剪枝后不存在孤岛
				--nLog3(" -压入node: "..k.." . "..v1.link[1])
				node[k][k1] = v1.link[1]
			end
		end
	end

	visited = clone(node) -- 全局的,被访问过则标记2
	allPath = {} -- 全局的
	local i = 5  -- 这里不是很完美,5次循环找线路,不重复的线路
	while i >= 0 do
		--toast()
		--nLog3(" --------------------i: " .. i)
		links(page3,page4)
		i = i - 1
	end

	if #allPath ~= 0 then -- 选最小的一行,通过全局变量allPath传递参数
		local count1,count2 = 100
		local minList = ""
		for k2,v2 in pairs(allPath) do 
			_, count2 = string.gsub(v2, ",", ",")  
			if count2 <= count1 then
				count1 = count2
				minList = v2
			end
		end

		local minLinks = strSplit(minList,",") 
		for k3,v3 in ipairs(minLinks) do
			minLinks[k3] = strSplit(v3,".")
		end
		return minLinks
		-- nLog3(" ------minListjson: " .. ts.json.encode(minTable))
	end
	return 0
end


----------------------------------------------------------------------------
-- 函数名称 : links
-- 函数功能 : 链表,配合getlinks使用,用来找目的地,找出页到页(点到页就好找了),暂不考虑太复杂的,遗憾的是这不是最短路径
-- 函数参数 : string 起始页,string 目的页
-- 函数返回 : string,用allPath这个全局变量传值

function links(page1,page2)

	if path == nil then
		path = page1
	end
	local break1 = 0
	for k2,v2 in pairs(node[page1]) do 
		if v2 == page2 then 
			path = path.."."..k2..","..v2
			--nLog3(" ----正确: 找到page2了: " .. path)
			table.insert(allPath,path)
			break1 = 1
			break 
		end
	end
	if break1 == 0 then
		for k2,v2 in pairs(node[page1]) do 
			if string.find(path,v2) == nil and visited[page1][k2] ~= 2 then  -- 判断path中没有k2防止闭环,判断是否已访问过(=2)
				--nLog3(" -循环: page1:"..page1.." => k2:" .. k2)
				path = path.."."..k2..","..v2
				visited[page1][k2] = 2
				--nLog3(" -压入: path: " .. path)
				return links(v2,page2)
			else
				--nLog3(" -跳过: page1:"..page1.." => k2:" .. k2) -- 跳过,进入下一行
			end
		end
	end
	path = nil --页到页的路径, 结尾找不到page2时,重置path
	return 0 --找不到就输出
end


----------------------------------------------------------------------------
-- 函数名称 : clone
-- 函数功能 : 复制table,不是引用,有个系统函数,deepCopyTable 深度复制表
-- 函数参数 : 
-- 函数返回 : table

function clone(tbl)
	local ts = require("ts")  --扩展库再加载一次,反正也不影响速度
	return ts.json.decode(ts.json.encode(tbl))
end


----------------------------------------------------------------------------
-- 函数名称 : printTable
-- 函数功能 : 递归迭代打印table的key和value,
-- 函数参数 : (table 欲打印的表,number 每行缩进)
-- 函数返回 : 无

function printTable(t, i)
	local indent ="" 
	i = i or 1
	for j = 0, i do 
		indent = indent .. "    "
	end
	for k, v in pairs(t) do 
		if (type(v) == "table") then   --type(v)返回类型名("nil"，"number", "string", "boolean", "table", "function", "thread", "userdata")
			toast("")
			nLog3(indent ..  k .."")
			printTable(v, i + 1) -- 递归调用
		else 
			toast("")
			nLog3(indent .. k .. "=" .. v)
		end
	end
end


----------------------------------------------------------------------------
-- 函数名称 : getServerVer
-- 函数功能 : 获取服务器脚本版本,对比本地版本是否升级,
-- 函数参数 : 默认为最新版
-- 函数返回 : json

function getServerVer() 
	local localver = 1.0
	local path = "/var/mobile/Media/TouchSprite/lua/main.lua"
	local str, code = szocket.http.request("http://192.168.0.112");
	nLog3("检查更新: http://192.168.0.112")
	if code == 200 then
		local wwwver = string.split(str, "|")
		if tonumber(wwwver[1]) > localver then 
			if downFile(wwwver[2],path) then 
				nLog3(" -版本更新:"..localver.." -> "..wwwver[1].."成功!")
				mSleep(500);
				lua_restart(); 
			end
		end
	end
	nLog3(" -没有版本可更新")
end


----------------------------------------------------------------------------
-- 函数名称 : clearEditor
-- 函数功能 : 清空输入框内容
-- 函数参数 : 
-- 函数返回 : 

function clearEditor()
	for i =1, 20 do pressBackspace() mSleep(10) end
	for i =1, 20 do pressDel() mSleep(10) end
	mSleep(1000)
end


----------------------------------------------------------------------------
-- 函数名称 : isNetworkConnected
-- 函数功能 : 
-- 函数参数 : 
-- 函数返回 : 

function isNetworkConnected()
	local t = ts.getNetType()
	if t == "NO NETWORK" then return false end
	local r = httpGet("http://quan.suning.com/getSysTime.do") 
	if not r then return false end
	return true
end


----------------------------------------------------------------------------
-- 函数名称 : restartWIFI
-- 函数功能 : 
-- 函数参数 : 
-- 函数返回 : 

function restartWIFI()
	toast("正在重启网络....",1)
	setWifiEnable(false)    --关闭 WiFi
	mSleep(1000)
	setWifiEnable(true)    --打开 WiFi
	local ttt= os.time()
	while (os.time() -ttt < 10) do if ts.getNetType() == "WiFi" then sdebug("网络重启成功") toast("网络重启成功",1)return true end end
	toast("网络重启失败",1)
	return false
end


----------------------------------------------------------------------------
-- 函数名称 : getTime
-- 函数功能 : 获取网络时间 返回 年,月,日,时,分,秒
-- 函数参数 : 
-- 函数返回 : 

function getTime()--获取网络时间 返回 年,月,日,时,分,秒
	local c_time = getNetTime()
	c_time = os.date("%Y-%m-%d %H:%M:%S",c_time)
	return  string.match(c_time,"(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
end
function getYear()
	local year = getTime()
	if year then return tonumber(year) end
	return 1970
end
function getMonth()
	local _,month = getTime()
	if month then return tonumber(month) end
	return 1
end
function getDay()
	local _,_,day =getTime()
	if day then return tonumber(day) end
	return 1
end
function getHour()
	local _,_,_,hour =getTime()
	if hour then return tonumber(hour) end
	return 1
end
function getMinute()
	local _,_,_,_,minute =getTime()
	if minute then return tonumber(minute) end
	return 1
end
function getSecond()
	local _,_,_,_,_,second =getTime()
	if second then return tonumber(second) end
	return 1
end
function isHas31(month)--是否有31一天
	if month==1 or month==3 or month==5 or month==7 or month==8 or month==10 or month==12 then
		return true
	end
	return false
end


----------------------------------------------------------------------------
-- 拆分一个路径字符串，返回组成路径的各个部分
-- @function [parent=#io] pathinfo
-- @param string path 要分拆的路径字符串
-- @return table#table 

-- pathinfo.dirname  = "/var/app/test/"
-- pathinfo.filename = "abc.png"
-- pathinfo.basename = "abc"
-- pathinfo.extname  = ".png"

function io.pathinfo(path)
	local pos = string.len(path)
	local extpos = pos + 1
	while pos > 0 do
		local b = string.byte(path, pos)
		if b == 46 then -- 46 = char "."
			extpos = pos
		elseif b == 47 then -- 47 = char "/"
			break
		end
		pos = pos - 1
	end

	local dirname = string.sub(path, 1, pos)
	local filename = string.sub(path, pos + 1)
	extpos = extpos - pos
	local basename = string.sub(filename, 1, extpos - 1)
	local extname = string.sub(filename, extpos)
	return {
		dirname = dirname,
		filename = filename,
		basename = basename,
		extname = extname
	}
end


----------------------------------------------------------------------------
-- 检查指定的文件或目录是否存在，如果存在返回 true，否则返回 false
-- @function [parent=#io] exists
-- @param string path 要检查的文件或目录的完全路径
-- @return boolean#boolean

function io.exists(path)
	local file = io.open(path, "r")
	if file then
		io.close(file)
		return true
	end
	return false
end


----------------------------------------------------------------------------
-- 返回指定文件的大小，如果失败返回 false
-- @function [parent=#io] filesize
-- @param string path 文件完全路径
-- @return integer#integer 

function io.filesize(path)
	local size = false
	local file = io.open(path, "r")
	if file then
		local current = file:seek()
		size = file:seek("end")
		file:seek("set", current)
		io.close(file)
	end
	return size
end


----------------------------------------------------------------------------
-- 函数名称 : getFileTime
-- 函数功能 : 获取文件最后修改时间，获取不到返回false 否则返回时间戳
-- 函数参数 : 
-- 函数返回 : 

function getFileTime(path)
	if not path then return false end
	local sret,rret = pcall(function()
			lfs = lfs or require("lfs")	
			local attr = lfs.attributes(path)
			if attr ~= nil then return attr.modification end
		end)
	if sret then return rret else return false end
end


----------------------------------------------------------------------------
-- 读取文件内容，返回包含文件内容的字符串，如果失败返回 nil
-- @function [parent=#io] readfile
-- @param string path 文件完全路径
-- @return string#string 

function io.readfile(path)
	local file = io.open(path, "r")
	if file then
		local content = file:read("*a")
		io.close(file)
		return content
	end
	return nil
end


----------------------------------------------------------------------------
-- 以字符串内容写入文件，成功返回 true，失败返回 false
-- @function [parent=#io] writefile
-- @param string path 文件完全路径
-- @param string content 要写入的内容
-- @param string mode 写入模式，默认值为 "w+b"
-- @return boolean#boolean 

--[[--
以字符串内容写入文件，成功返回 true，失败返回 false
"mode 写入模式" 参数决定 io.writefile() 如何写入内容，可用的值如下：
-   "w+" : 覆盖文件已有内容，如果文件不存在则创建新文件
-   "a+" : 追加内容到文件尾部，如果文件不存在则创建文件
此外，还可以在 "写入模式" 参数最后追加字符 "b" ，表示以二进制方式写入数据，这样可以避免内容写入不完整。
]]

function io.writefile(path, text, mode)
	mode = mode or "w+b"
	local file = io.open(path, mode)
	if file then
		if file:write(text) == nil then return false end
		io.close(file)
		return true
	else
		return false
	end
end


----------------------------------------------------------------------------
-- 函数名称 : bin2hex
-- 函数功能 : 二进制转到十六进制
-- 函数参数 : string
-- 函数返回 : string

function bin2hex(s)
	s = string.gsub(s,"(.)",function (x) return string.format("%02X ",string.byte(x)) end)
	return s
end


----------------------------------------------------------------------------
-- 函数名称 : hex2bin
-- 函数功能 : 十六进制转到二进制
-- 函数参数 : string
-- 函数返回 : string

function hex2bin(hexstr)
	local h2b = {
		["0"] = 0,
		["1"] = 1,
		["2"] = 2,
		["3"] = 3,
		["4"] = 4,
		["5"] = 5,
		["6"] = 6,
		["7"] = 7,
		["8"] = 8,
		["9"] = 9,
		["A"] = 10,
		["B"] = 11,
		["C"] = 12,
		["D"] = 13,
		["E"] = 14,
		["F"] = 15
	}
	local s = string.gsub(hexstr, "(.)(.)%s", function ( h, l )
			return string.char(h2b[h]*16 + h2b[l])
		end)
	return s
end


--function hex2bin( hexstr )
--	local str = ""
--    for i = 1, string.len(hexstr) - 1, 2 do  
--    	local doublebytestr = string.sub(hexstr, i, i+1);  
--    	local n = tonumber(doublebytestr, 16);  
--    	if 0 == n then  
--        	str = str .. '\00'
--    	else  
--        	str = str .. string.format("%c", n)
--    	end
--    end 
--    return str
--end