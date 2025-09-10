## 使用罗技驱动实现鼠标移动与点击的基础操作

本文将介绍如何通过罗技驱动实现鼠标的移动与点击，涵盖从基础公式到优化的全过程。以下内容适用于需要精确控制鼠标操作的场景。

### 1. 鼠标移动与点击的基础公式

在罗技驱动中，鼠标的移动与点击操作可以通过以下几个函数实现：

- **GetMousePosition()**：获取当前鼠标的绝对坐标。
- **MoveMouseTo(x, y)**：将鼠标移动到指定的绝对坐标 `(x, y)`。
- **PressAndReleaseMouseButton(1)**：点击鼠标左键。

这些函数提供了基本的鼠标控制能力，可以在自动化脚本中广泛使用。

### 2. 获取屏幕坐标的两种方法

在编写自动化脚本时，精确的坐标获取是关键步骤。以下介绍两种方法获取屏幕坐标：

#### 方法一：通过驱动获取绝对坐标

在使用罗技驱动时，可以通过以下代码获取当前鼠标的绝对坐标：

```lua
EnablePrimaryMouseButtonEvents(true)

function OnEvent(event, arg)
    if IsKeyLockOn("Capslock") and event == "MOUSE_BUTTON_PRESSED" and arg == 1 then
        local x, y = GetMousePosition()
        OutputLogMessage("x = %s  ,  y = %s\n\n", x, y)
    end
end
```


![](https://i0.hdslb.com/bfs/article/8e60578da55582afbc58d11d4023c9af212b1d39.png@1256w_502h_!web-article-pic.avif)


当按下大写锁定键并点击鼠标左键时，上述脚本会输出鼠标的当前绝对坐标到控制台。注意，罗技驱动的坐标体系为 `(0,0)` 对应屏幕左上角，`(65535,65535)` 对应右下角。

#### 方法二：通过截图获得精确坐标

另一种方法是利用截图软件获取屏幕的精确坐标。步骤如下：

1. 使用QQ或微信的截图功能截取整个屏幕，并保存为图片。
2. 使用系统自带的“画图”工具打开图片。光标在图片上移动时，画图工具会显示光标所在位置的像素坐标。

举例来说，假设屏幕分辨率为 `1920x1080`，当前光标位置为 `(960, 540)`，对应的罗技绝对坐标可以通过以下公式计算：

```
960 / 1920 * 65535 ≈ 32767
540 / 1080 * 65535 ≈ 32767
```
![](https://i0.hdslb.com/bfs/article/a7fd48267c31137e7ebd22c9b27ee07576e2586a.png@1256w_708h_!web-article-pic.avif)

### 3. 实现鼠标的移动与点击
![](https://i0.hdslb.com/bfs/article/c233fb10047f4aa19a9229b4d9fa8785e0d929a3.png@1256w_820h_!web-article-pic.avif)
以下示例展示了如何实现鼠标自动移动到屏幕四个角并进行点击操作：

```lua
EnablePrimaryMouseButtonEvents(true)

function mac(x, y)
    local abs_x = x / 1920 * 65535
    local abs_y = y / 1080 * 65535
    MoveMouseTo(abs_x, abs_y)
    delay(10)
    PressAndReleaseMouseButton(1)
    delay(10)
end

function delay(Time)
    local startTime = GetRunningTime()
    while GetRunningTime() - startTime <= Time do
        -- 保持延迟
    end
end

function OnEvent(event, arg)
    if event == "MOUSE_BUTTON_PRESSED" and arg == 4 then
        mac(0, 0)
        mac(1920, 0)
        mac(0, 1080)
        mac(1920, 1080)
    end
end
```

当按下鼠标侧键4时，脚本将自动移动鼠标至屏幕四个角并进行点击。坐标及延迟可以根据需求进行调整。

### 4. 优化操作

当需要点击多个坐标时，可以将移动与点击操作封装为一个子程序，简化后续操作：

```lua
EnablePrimaryMouseButtonEvents(true)

function delay(Time)
    local startTime = GetRunningTime()
    while GetRunningTime() - startTime <= Time do
        -- 保持延迟
    end
end

function mac(x, y)
    local abs_x = x / 1920 * 65535
    local abs_y = y / 1080 * 65535
    MoveMouseTo(abs_x, abs_y)
    delay(10)
    PressAndReleaseMouseButton(1)
    delay(10)
end

function OnEvent(event, arg)
    if event == "MOUSE_BUTTON_PRESSED" and arg == 4 then
        mac(0, 0)
        mac(1920, 0)
        mac(0, 1080)
        mac(1920, 1080)
    end
end
```

上述优化可以使脚本更加简洁易读。只需输入屏幕坐标，即可实现自动化的鼠标操作。

<p style="font-size: 0.85em; color: #666; text-align: right; margin-top: 20px;">
    本文内容部分转载自<a href="https://www.bilibili.com/read/cv25006348/" style="color: #999; text-decoration: none;">B站文章</a>。
</p>

### 总结

本文介绍了如何通过罗技驱动实现精确的鼠标移动与点击操作，从基础公式到具体实现，再到代码优化，帮助你轻松实现自动化任务。如果这篇文章对你有帮助，别忘了点赞与评论哦！

##### 以下本人修改过的代码，把除法部分修改了，增加四舍五入，防止功能失效：
```lua
EnablePrimaryMouseButtonEvents(true)	-- 允许左键被编程

-- 精确延迟
delay = function(Time)
	local startTime = GetRunningTime()
	while GetRunningTime() - startTime <= Time do
		-- 啥也不干,就是延迟
	end
end

-- 移动与点击绑定在一起,mac表示move and click,名字随便起
mac = function(a, b)
	-- 将屏幕坐标转换为鼠标坐标
	local x = math.floor(a * 65535.0 / 1920 + 0.5)
	local y = math.floor(b * 65535.0 / 1080 + 0.5)
	
	-- 输出调试信息
	OutputLogMessage("Converted x: %d, y: %d\n", x, y)

	-- 移动鼠标到指定位置
	MoveMouseTo(x, y)
	delay(10)
	PressAndReleaseMouseButton(1)
	delay(10)
end

function OnEvent(event, arg)
	if event == "MOUSE_BUTTON_PRESSED" then
		if arg == 8 then
			-- 第一个操作
			mac(460, 196)
			mac(482, 134)
			delay(400)
			mac(620, 527)
			MoveMouseTo(20753, 35802)
		elseif arg == 6 then
			-- 第二个操作
			mac(377, 203)
			mac(346, 137)
		end
	end
end

```