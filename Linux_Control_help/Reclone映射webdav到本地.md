Reclone映射webdav到本地
=============


*   [部署Alist](#)
*   [部署rclone](#)

方案 - Alist + rclone 
--------------------------------------------

部署Alist
-------

Alist文档: [https://alist.nn.ci/zh/guide/](https://alist.nn.ci/zh/guide/)

### 部署服务

执行命令:

    docker run -d \
      --restart=always \
      -v /mnt/user/path-of-config:/opt/alist/data \
      -p 5244:5244 \
      -e PUID=0 \
      -e PGID=0 \
      -e UMASK=022 \
      --name="alist" \
      xhofe/alist:latest
    

*   `-v /mnt/user/path-of-config:/opt/alist/data`这个部分需要把冒号前的部分改为你NAS上的某个目录,这个目录用来存放alist的配置文件,如果你不想用这个目录,可以直接把这个部分删掉,但是这样的话,你每次重启alist都需要重新配置一遍,不推荐这么做.

### 查看默认密码

    docker logs alist
    

输出信息像这样,其中`GQZ8zwXs`就是你的管理员密码

    INFO[2023-09-18 03:00:40] reading config file: data/config.json        
    INFO[2023-09-18 03:00:40] config file not exists, creating default config file 
    INFO[2023-09-18 03:00:40] load config from env with prefix:            
    INFO[2023-09-18 03:00:40] init logrus...                               
    INFO[2023-09-18 03:00:40] Successfully created the admin user and the initial password is: GQZ8zwXs 
    INFO[2023-09-18 03:00:40] start HTTP server @ 0.0.0.0:5244             
    INFO[2023-09-18 03:00:40] qbittorrent not ready.                       
    INFO[2023-09-18 03:00:40] Aria2 not ready.  
    

### 登录

在浏览器打开`http://your-nas-ip:5244`,输入用户名`admin`和刚才查看到的密码登录.

登录后点击页面上的管理进入管理页面,这里建议先修改用户名和密码  
![](https://pho.tools/imgs/alist-password.webp)

### 配置储存

不同储存方式的配置方式不同,这里以**百度网盘**为例,其他网盘的配置方式可以参考Alist文档: [https://alist.nn.ci/zh/guide/drivers/](https://alist.nn.ci/zh/guide/drivers/)

挂载百度网盘关键是获取到**刷新令牌**,**客户端ID**,**客户端密钥**这三个参数.使用浏览器打开以下URL并登录你的百度网盘帐号,就会显示这三个参数  
[https://openapi.baidu.com/oauth/2.0/authorize?response\_type=code&client\_id=iYCeC9g08h5vuP9UqvPHKKSVrKFXGa1v&redirect\_uri=https://alist.nn.ci/tool/baidu/callback&scope=basic,netdisk&qrcode=1](https://openapi.baidu.com/oauth/2.0/authorize?response_type=code&client_id=iYCeC9g08h5vuP9UqvPHKKSVrKFXGa1v&redirect_uri=https://alist.nn.ci/tool/baidu/callback&scope=basic,netdisk&qrcode=1)

![](https://pho.tools/imgs/alist-baidu-token.webp)

点击Alist管理页面的储存 -> 添加,驱动选择百度网盘.

*   挂载路径: 与NAS中的路径无关,是Alist内部文件系统的路径,按喜好填即可,比如`/baidu`
*   刷新令牌,客户端ID,客户端密钥: 填上面获取到的参数
*   WebDAV策略: 如果是内网使用选本地代理即可,外网使用建议选302重定向

其他项保持默认点击保存即可,保存后看到状态显示`work`即为配置成功  
![](https://pho.tools/imgs/alist-baidu-work.webp)

### 访问webdav

我们部署Alist的主要目的是能以webdav的形式访问网盘内容,按以上方式部署好了之后,可以用以下url访问webdav,用户名密码即为你在Alist管理页面设置的用户名密码

    http://your-nas-ip:5244/dav
  

---

部署rclone
--------

rclone文档: [https://rclone.org/docs/](https://rclone.org/docs/)


### 1. 安装 rclone

首先，我们需要在系统中安装 `rclone`。以 Linux 系统为例，你可以通过以下步骤安装：

1. **下载 `rclone`**：
   前往 [rclone 下载页面](https://rclone.org/downloads/) 下载与你的系统架构对应的 `rclone` 版本。例如，对于 `amd64` 架构，你可以执行以下命令：

   ```bash
   mkdir rclone
   cd rclone
   wget https://downloads.rclone.org/v1.64.0/rclone-v1.64.0-linux-amd64.zip
   unzip rclone-v1.64.0-linux-amd64.zip
   cd rclone-v1.64.0-linux-amd64
   sudo cp rclone /usr/bin/
   sudo chmod +x /usr/bin/rclone
   ```

2. **验证安装**：
   安装完成后，你可以通过以下命令验证 `rclone` 是否安装成功：

   ```bash
   rclone version
   ```

   如果安装成功，系统会返回 `rclone` 的版本信息。

---

### 2. 配置 WebDAV 连接

`rclone` 支持多种云存储服务，我们接下来将配置 `rclone` 连接到 Alist 提供的 WebDAV 服务。

1. **启动 `rclone` 配置**：
   在终端中输入以下命令以启动 `rclone` 的配置向导：

   ```bash
   rclone config
   ```

2. **创建新的 remote**：
   在出现的提示中，选择 `n` 来创建一个新的 remote，并为其命名（例如 `alist`）：

   ```plaintext
   No remotes found, make a new one?
   n) New remote
   s) Set configuration password
   q) Quit config
   n/s/q> n

   Enter name for new remote.
   name> alist
   ```

3. **选择存储类型**：
   接下来，`rclone` 会让你选择存储类型，输入 `webdav` 以选择 WebDAV 作为存储类型：

   ```plaintext
   Option Storage.
   Type of storage to configure.
   Choose a number from below, or type in your own value.
   Storage> webdav
   ```

4. **配置 WebDAV 的 URL**：
   这里你需要输入 WebDAV 服务的 URL。假设 Alist 部署在本地网络中的 NAS 上，URL 类似于 `http://192.168.100.152:5244/dav`：

   ```plaintext
   Option url.
   URL of http host to connect to.
   url> http://192.168.100.152:5244/dav
   ```

5. **选择 WebDAV 服务供应商**：
   在这个步骤中，你可以选择 WebDAV 的供应商。这里选择 `other`：

   ```plaintext
   Option vendor.
   vendor> other
   ```

6. **输入用户名和密码**：
   接下来，输入在 Alist 中设置的用户名和密码：

   ```plaintext
   Option user.
   User name.
   user> your-username

   Option pass.
   Password.
   y) Yes, type in my own password
   y/g/n> y
   Enter the password:
   password: your-password
   Confirm the password:
   password: your-password
   ```

7. **完成配置**：
   选择 `n` 跳过高级配置，并确认保存配置：

   ```plaintext
   Edit advanced config?
   y) Yes
   n) No (default)
   y/n> n

   Configuration complete.
   Keep this "alist" remote?
   y) Yes this is OK (default)
   y/e/d> y
   ```

8. **验证配置**：
   完成配置后，你可以使用以下命令检查配置是否成功：

   ```bash
   rclone lsd alist:/ --max-depth 1
   ```

检查配置是否成功:  
以下命令将列出webdav根目录下的文件和目录,能正确输出即为配置成功
  ```bash
    rclone lsd cloudreve:/ --max-depth 1
              -1 2023-09-04 15:00:14        -1 baidu
              -1 2023-09-06 14:19:17        -1 nas
              -1 2023-09-04 14:29:07        -1 quark
  ```
   该命令会列出 WebDAV 根目录下的文件和目录，如果能看到正确的输出，说明配置成功。

---




### 3. 映射 WebDAV 到本地文件系统(当做本地文件夹)

现在你已经配置好了 WebDAV 连接，接下来我们将其映射到本地文件系统，以便像操作本地文件一样访问 WebDAV 上的内容。

1. **创建挂载点**：
   首先，为 WebDAV 创建一个本地挂载点目录：

   ```bash
   mkdir --mode=777 /mnt/cloudreve
   ```

2. **挂载 WebDAV**：
   使用 `rclone mount` 命令将 WebDAV 挂载到本地文件系统中：

   ```bash
   rclone mount --daemon --vfs-cache-mode minimal --allow-non-empty --allow-other alist:/ /mnt/cloudreve -vv
   ```

3. **验证挂载**：
   你可以通过以下命令检查挂载是否成功：

   ```bash
   ls /mnt/cloudreve
   ```

   如果挂载成功，你会看到 WebDAV 中的文件和目录。

---
    

### 4. 使用 rclone 同步 WebDAV 到本地(用于备份)

配置完成后，我们可以使用 `rclone sync` 命令将远程 WebDAV 目录同步到本地目录。例如，我们要将远程的 `/backup` 目录同步到本地的 `/home/user/backup` 目录：

```bash
rclone sync mywebdav:/backup /home/user/backup -v --progress
```

#### **注意事项**：

- **单向同步**：`rclone sync` 是单向同步命令，它会将目标位置（本地）与源位置（远程 WebDAV）保持一致。这意味着：
  - **新增和更新**：`rclone sync` 会将远程 WebDAV 中新增或更新的文件同步到本地。
  - **删除**：如果本地目录中存在远程 WebDAV 中不存在的文件，`rclone sync` 会将这些多余的文件删除。

- **避免误删**：由于 `rclone sync` 会删除目标位置中不存在于源位置的文件，请务必确保你已经备份了重要数据，或使用 `rclone copy` 命令来避免删除操作：

  ```bash
  rclone copy mywebdav:/backup /home/user/backup -v --progress
  ```

- **`--dry-run` 选项**：在执行 `rclone sync` 之前，你可以使用 `--dry-run` 选项来模拟同步过程，查看会发生的操作，而不进行任何实际数据更改：

  ```bash
  rclone sync mywebdav:/backup /home/user/backup --dry-run -v
  ```

- **同步错误**：在同步过程中，如果遇到 I/O 错误（如远程服务器检测到恶意软件并拒绝访问），`rclone` 会停止删除操作，防止数据丢失。你可以使用 `--ignore-errors` 选项来忽略这些错误，但请谨慎使用。

  ```bash
  rclone sync mywebdav:/backup /home/user/backup -v --ignore-errors
  ```

---