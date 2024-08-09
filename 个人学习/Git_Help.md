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


Git 分支管理
========

几乎每一种版本控制系统都以某种形式支持分支，一个分支代表一条独立的开发线。

使用分支意味着你可以从开发主线上分离开来，然后在不影响主线的同时继续工作。

![](https://static.jyshare.com/images/svg/git-brance.svg)

Git 分支实际上是指向更改快照的指针。

有人把 Git 的分支模型称为**必杀技特性**，而正是因为它，将 **Git** 从版本控制系统家族里区分出来。

创建分支命令：

>git branch \<branchname>

切换分支命令:

>git checkout \<branchname>

当你切换分支的时候，Git 会用该分支的最后提交的快照替换你的工作目录的内容， 所以多个分支不需要多个目录。

合并分支命令:

>git merge \<branchname>

你可以多次合并到统一分支， 也可以选择在合并之后直接删除被并入的分支。


Git 分支管理
--------

### 列出分支

列出分支基本命令：

>git branch

没有参数时，**git branch** 会列出你在本地的分支。

接下来我们将演示如何切换分支，我们用 git checkout (branch) 切换到我们要修改的分支。

我们也可以使用 **git checkout -b \<branchname>** 命令来创建新分支并立即切换到该分支下，从而在该分支中操作。

如你所见，我们创建了一个分支，在该分支上移除了一些文件 test.txt，并添加了 runoob.php 文件，然后切换回我们的主分支，删除的 test.txt 文件又回来了，且新增加的 runoob.php 不存在主分支中。

使用分支将工作切分开来，从而让我们能够在不同开发环境中做事，并来回切换。

### 删除分支

删除分支命令：

>git branch \-d \<branchname>

删除远端分支
>git pull origin --delete \<branchname>
### 分支合并

一旦某分支有了独立内容，你终究会希望将它合并回到你的主分支。
你可以使用以下命令将任何分支**合并到*当前分支***中去：
>git merge \<branchname>

合并完后就可以删除分支:

>git branch \-d \<branchname>


### 合并冲突

在 Git 中，我们可以用 `git add` 要告诉 Git 文件冲突已经解决
    [解决git冲突步骤（超详细）](https://blog.csdn.net/weixin_45597885/article/details/129464448)

## 撤回

### 1. 只撤回commit
如果你已经提交了代码，但希望撤销这次提交而保留代码的更改(相当于只撤销commit)，可以使用以下命令：

```sh
git reset --soft HEAD~1
```

### 2. 全部丢弃，恢复到上次commit
如果你希望撤销最近的提交并放弃这次提交的更改，可以使用：

```sh
git reset --hard HEAD~1
```

这个命令会将最近一次提交撤销，并且所有更改都会被丢弃，这意味着代码会回到前一次提交的状态。

### 3. 回退到特定提交

如果你想将仓库回退到某个特定的提交，可以使用：
```sh
git log
```
查看提交日志，记下要回退到的hash
```sh
git reset --hard <commit_hash>
```