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

    git push origin master 