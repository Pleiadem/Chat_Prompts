# WSL2安装与配置

![](https://csdnimg.cn/release/blogv2/dist/pc/img/original.png)

---

## WSL1升级为WSL2

### 1. 启用必要的组件

首先需要启用虚拟机平台组件。
按下win键搜索`启用或关闭 Windows 功能`，打开以下功能：

- Hyper-V
- 适用于 Linux 的 Windows 子系统
- 虚拟机平台

启用后系统会要求重启计算机。

### 2. 下载并安装WSL2 Linux内核更新包

在cmd输入

    wsl --update
打开微软商店下载ubuntu

### 3. 检查当前的WSL版本

安装完成后，可以通过以下命令查看当前的WSL版本：

```powershell
wsl -l -v
```

### 4. 升级WSL1到WSL2

下载并安装好内核更新包后，运行以下命令将WSL1升级到WSL2：

```powershell
wsl --set-version Ubuntu-20.04 2
wsl -l -v
```

完成以上步骤即可成功将WSL1升级为WSL2。

---

## 更改WSL2的存放路径

### 问题

默认情况下，WSL存放路径为C盘。根据需要，可以将其导出到其他空间较大的盘符。

### 更改方式

#### 1. 查看已安装的WSL名称和版本

在Powershell中输入以下命令：

```powershell
wsl -l --all -v
```

#### 2. 导出系统到指定位置
没关机先关机

    wsl --shutdown
使用以下命令将系统导出到指定目录：

```powershell
wsl --export Ubuntu-22.04 D:\Ubuntu-22.04.tar
```

#### 3. 删除当前C盘中的WSL系统

执行以下命令删除当前WSL系统：

```powershell
wsl --unregister Ubuntu-22.04
```

#### 4. 导入系统到指定位置

将系统导入到指定目录，并指定WSL版本号：

```powershell
wsl --import Ubuntu-22.04 D:\Linux D:Ubuntu-22.04.tar --version 2
```

#### 5. 配置默认登录用户

使用以下命令配置默认登录用户：

```powershell
ubuntu2204.exe config --default-user <用户名>
```

例如：

```powershell
ubuntu2204.exe config --default-user root
```

完成以上步骤后，WSL2的存放路径已成功更改至指定位置。






[让WSL开机启动，后台运行，以减少唤醒时间]()
==============================================================================================

上次分享了《WSL 2 上启用微软官方支持的 systemd》后，有博客园的读者评论说开启了SYSTEMD后，发现启动时间变慢了，询问有没有什么解决办法。

其实WSL启动时间变慢我也早有发觉，这个问题在我启用SYSTEMD前就已经存在。

WSL2会默认关闭不使用的实例，当你关闭了WSL的Console后，实例会自动关闭。在和Distrod的比较中，我提到过这样的产品设计的初衷，是为了减少计算机资源占用。

但是对于会频繁唤醒WSL的用户来说，确实会出现启动时间过长的情况。如果你的计算机资源比较充足，那么是可以在开机时通过VBS脚本启动一个 WSL 实例，让它挂起在那里不要休眠。

方法如下：

1.  WIN+R 运行 `shell:startup` 打开启动目录
2.  在此目录中创建文件 wsl-startup.vbs
3.  在 wsl-startup.vbs 中填充如下内容，Ubuntu-22.04需替换为你使用的发行版名称。
```
set ws=wscript.CreateObject("wscript.shell")
ws.run "wsl -d Ubuntu-22.04", 0
```

这样当你系统启动，登录系统后，Windows会开启 WSL 实例，它会永久等待输入，不会关闭。所以当你下次再使用WSL命令时，就不会遇到需要重新唤醒 WSL 的耗时。

如果你担心后台挂着WSL对系统资源占用过高，可以通过配置 .wslconfig 文件来限制 WSL 的资源占用。 WSL 会默认占用50%内存，最大8GB。使用所有CPU线程。我一般会限制到4GB,2线程。

配置方法如下：

    notepad %USERPROFILE%\.wslconfig
    
    [wsl2]
    memory=4GB 
    processors=2
    

Ref:  
[https://github.com/microsoft/WSL/issues/8854](https://github.com/microsoft/WSL/issues/8854)  
[https://askubuntu.com/a/1452424/911078](https://askubuntu.com/a/1452424/911078)  
[https://learn.microsoft.com/en-us/windows/wsl/wsl-config](https://learn.microsoft.com/en-us/windows/wsl/wsl-config)

* * *
