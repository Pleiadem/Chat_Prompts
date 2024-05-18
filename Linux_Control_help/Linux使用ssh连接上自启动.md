# Linux每次登录时自动执行
### 一、所有用户每次登录时自动执行。
1、在`/etc/profile`文件末尾添加。
将启动命令添加到/etc/profile文件末尾。

2、在`/etc/profile.d/`目录下添加sh脚本。
在/etc/profile.d/目录下新建sh脚本，设置每次登录自动执行脚本。有用户登录时，/etc/profile会遍历/etc/profile.d/*.sh。不要忘记修改文件权限。

### 二、指定用户每次登录时自动执行。
1、在`~/.bashrc`文件末尾添加。
将启动命令添加到~/.bashrc文件末尾。

### 三、脚本间的区别。
1、`/etc/profile`：此文件为系统的每个用户设置环境信息。当用户第一次登录时,该文件被执行，并从/etc/profile.d目录的配置文件中搜集shell的设置。

2、`/etc/bashrc`：为每一个运行bash shell的用户执行此文件。当bash shell被打开时，该文件被读取（即每次新开一个终端，都会执行bashrc）。

3、`~/.bash_profile`：每个用户都可使用该文件输入专用于自己使用的shell信息。当用户登录时，该文件仅仅执行一次。默认情况下，设置一些环境变量，执行用户的.bashrc文件。

4、`~/.bashrc`：该文件包含专用于你的bash shell的bash信息。当登录时以及每次打开新的shell时，该文件都会被读取。

5、`~/.bash_logout`：当每次退出系统(退出bash shell)时，执行该文件。另外，/etc/profile中设定的变量(全局)的可以作用于任何用户，而~/.bashrc等中设定的变量(局部)只能继承 /etc/profile中的变量，他们是”父子”关系。

6、`~/.bash_profile`：该文件是交互式、login方式进入bash运行的，~/.bashrc是交互式non-login方式进入bash运行的，通常二者设置大致相同，所以通常前者会调用后者。

## 附上main脚本：

    #!/bin/bash

    # 检查是否存在名为 'main' 的 tmux 会话
    tmux has-session -t main 2>/dev/null

    if [ $? != 0 ]; then
    echo "没有找到 'main' 会话，正在创建..."
    # 创建名为 'main' 的新会话
    tmux new-session -d -s main
    echo "'main' 会话已创建。"
    else
    echo "已找到 'main' 会话，正在连接..."
    fi

    # 连接到 'main' 会话
    tmux attach-session -t main


1. dawd
   1. 
2. dawdawd
3. dawdawda