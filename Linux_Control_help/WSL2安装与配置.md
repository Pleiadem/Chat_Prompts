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