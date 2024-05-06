# <center> Git简易教学
### 一些基础配置
配置本地仓库邮箱

    $ git config --global user.name "Pleiadem"  
    $ git config --global user.email "1284530956@qq.com"  
为 Git 启用一些额外的颜色

    git config --global color.ui true

### 基础指令集合
初始化

    git init
添加并提交

    git add <file>
    git commit -m 'first commit'
查看分支

    git branch
状态检查

    git status
远程备份

    git remote add origin \
    https://github.com/wupeixuan/repo.git 

然后，你可以继续将代码推送到 GitHub！哇，你已经成功备份了你的代码！

    git push -u origin master 
注意：github需要先去开发者那设置秘钥，然后把秘钥当密码。(-u 是指定upstring，指定后以后直接git push就行)

可以编辑项目目录中.git 文件夹下的配置文件 config，修改其中 url 项：

    [remote "origin"]
    url = https://gitee.com/uxpi/zsites.git
修改为：

    [remote "origin"]   
    url = https://uxpi:password@gitee.com/uxpi/zsites.git
也就是在 https:// 之后，增加 用户名:密码@
这样就不用每次push都输入密码🤤
    

以后可能用上：[git push -f 的后悔药](https://juejin.cn/post/6844903929898090509)

### 从远程仓库拉取
1. 拉取并合并(pull= fetch + merge)

        git pull 

2. 拉取拉取不合并

        git fetch 

3. 然后，使用`git merge`命令将远程分支合并到你当前所在的本地分支。可以使用以下命令：

        git merge origin/远程分支名
4. 克隆项目
 
        git clone