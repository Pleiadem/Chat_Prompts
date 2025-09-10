# <center> Git简易教学
### 一些基础配置
配置本地仓库邮箱

    $ git config --global user.name "Pleiadem"  
    $ git config --global user.email "xxxx@qq.com"  
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
    url = https://github.com/用户名/仓库名.git
修改为：

    [remote "origin"]   
    url = https://用户名:密钥@github.com/用户名/仓库名.git
    
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


## 删除git历史中的文件
“从Git历史记录中彻底删除文件”。仅仅在新的提交中删除文件是不够的，因为它依然存在于旧的提交历史中，任何人都可以通过检出(checkout)旧版本来找回它。

**警告：** 以下操作会**重写Git的提交历史**。这意味着所有受影响的提交的ID（哈希值）都会改变。

*   **如果你是个人开发者，或者在个人分支上操作**：这是安全的。
*   **如果你在一个团队协作的共享分支上操作**：**必须**在操作前与所有团队成员沟通。因为在您强制推送(force push)重写后的历史后，所有其他成员都需要执行特殊操作来同步他们的本地仓库，否则会造成巨大的混乱。


### 使用 `git filter-repo` (官方推荐的现代工具)**

这是目前**最好、最快、最安全**的方法，是`git filter-branch`的官方替代品。它不是Git自带的，需要单独安装一次。

#### **第1步：安装 `git-filter-repo`**

它是一个Python脚本，安装非常简单。

```bash
# 使用pip安装
pip install git-filter-repo

# 在macOS上使用Homebrew
# brew install git-filter-repo
```
*确保您的Python和pip已正确配置在系统路径中。*

#### **第2步：执行清理操作**

**在你本地的仓库副本中**，运行以下命令。

*   **删除单个文件：**
    假设您要从所有历史记录中删除一个名为 `secret_key.txt` 的文件。

    ```bash
    git filter-repo --path secret_key.txt --invert-paths
    ```

*   **删除整个文件夹：**
    假设您要删除一个名为 `credentials/` 的文件夹。

    ```bash

    git filter-repo --path credentials/ --invert-paths
    ```

*   **删除多种文件或文件夹：**
    您可以多次使用 `--path`。例如，删除 `secret_key.txt` 和 `config/` 文件夹。

    ```bash
    git filter-repo --path secret_key.txt --path config/ --invert-paths
    ```

*   **按文件名模式删除 (例如所有 `.log` 文件):**
    ```bash
    git filter-repo --path-glob '*.log' --invert-paths
    ```

**命令解释:**
*   `--path <文件或文件夹路径>`: 指定你**不**想要的目标。
*   `--invert-paths`: 这是一个关键开关，它的意思是“处理**除了**我用`--path`指定的路径之外的所有路径”，实际上就等同于“删除我指定的路径”。

#### **第3步：检查结果**

`git-filter-repo` 执行完毕后，它会告诉你它重写了多少提交。你可以使用 `git log` 查看历史记录，确认那些敏感文件确实已经消失了。

#### **第4步：强制推送到远程仓库**

由于历史已经被重写，你必须使用强制推送 (`--force`) 将这些更改应用到远程仓库（如GitHub）。

```bash
# 推送到所有分支和标签
git push --force --all

# 如果只想推送当前分支（例如main）
# git push origin main --force
```
