电脑上AppData数据迁移（解决C盘空间不足的问题）
===========================

前言
--

电脑使用时间一长，C盘就会空间不够用，其中大部分都是AppData文件夹占用的，我们就可以迁移

我们可以使用WizTree这个软件来查看磁盘空间占用情况。

[https://www.diskanalyzer.com/](https://cloud.tencent.com/developer/tools/blog-entry?target=https%3A%2F%2Fwww.diskanalyzer.com%2F&source=article&objectId=2245362)

方式1(推荐)
-------

> 完全迁移Users文件夹

开机情况下点击

**`更新和安全`** => **`恢复`** => **`高级启动`**

重启后点击 **`高级选项`**

点击 **`命令提示符`**

如果没有可以使用PE进行操作

> PE中自带的cmd没有`robocopy`命令，可以使用`C:\Windows\System32`下的`cmd.exe`

输入命令



    # 将USer复制到自己的其它盘我是D盘
    robocopy "C:\Users" "D:\Users" /E /COPYALL /XJ
     
    # 复制完成之后将原有文件重命名
    ren "C:\Users" "Users2"
     
    # 建立软连接
    mklink /J "C:\Users" "D:\Users"

重启后可以删除Users2


    rd /s /q C:\Users2

注：如果重启不了，那么通过以下方式恢复

重启3次进入恢复命令行


    # 删除软连接
    rmdir "C:\Users" /S /Q
    # 将之前重命名的文件夹变回员User
    ren "C:\Users2" "Users"

参数解释
----
>
>1. **C:\Users**:
>   - 源目录，这是你要复制的文件和文件夹所在的位置。
>
>2. **D:\Users**:
>   - 目标目录，这是文件和文件夹将被复制到的位置。
>
>3. **/E**:
>   - 复制源目录中的所有子目录，包括空目录。
>
>4. **/COPYALL**:
>   - 复制所有文件属性，包括数据、属性、时间戳、权限、所有权和审计信息。具体来说，这个参数包含了：
     - **/COPY:DATSOU**：
       - **D**: 数据
       - **A**: 属性
       - **T**: 时间戳
       - **S**: NTFS 权限
       - **O**: 所有者信息
       - **U**: 审计信息
>5. **/XJ**:
>   - 排除交叉点（Junction Points）。Junction Points 是 Windows 文件系统中的一种特殊类型的文件夹链接，类似于 Unix 中的符号链接。排除它们可以避免无限循环复制问题。

这个命令的总体作用是递归地复制 `C:\Users` 目录中的所有内容（包括所有属性和权限），并且包括所有子目录（即使是空的），但排除了交叉点目录。

方式2
---

只更改AppData文件夹

> 这种方式会导致部分软件无法运行。

进入注册表

    regedit.exe

处理的注册表位置

    HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders
    HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders

把其中和`AppData`相关的键值改为新位置即可。

> 这种方法并不能完全替换完。


AppData

    %USERPROFILE%\AppData\Roaming


<span style="color:#C0C0C0">摘录自[腾讯云社区—码客说](https://cloud.tencent.com/developer/article/2245362)</span>
