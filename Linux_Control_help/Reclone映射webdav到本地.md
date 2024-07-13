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
    

部署rclone
--------

rclone文档: [https://rclone.org/docs/](https://rclone.org/docs/)

### 下载rclone

下载地址: [https://rclone.org/downloads/](https://rclone.org/downloads/)

找到对应你CPU架构的版本下载,最好直接选择`Linux`一列下的下载,这一列下载zip解压后直接是可以执行文件,任何Linux发行版都可以直接用.这里以`v1.64.0-amd64`架构为例:

    mkdir rclone
    cd rclone
    wget https://downloads.rclone.org/v1.64.0/rclone-v1.64.0-linux-amd64.zip
    unzip rclone-v1.64.0-linux-amd64.zip
    cd rclone-v1.64.0-linux-amd64
    sudo cp rclone /usr/bin/
    sudo chmod +x /usr/bin/rclone
    

### 配置webdav

命令行输入`rclone config`命令进入配置引导,以下为示例,有`>`地方是需要手动输入后按回车继续.

    rclone config
    No remotes found, make a new one?
    n) New remote
    s) Set configuration password
    q) Quit config
    n/s/q> n
    
    Enter name for new remote.
    name> alist
    
    Option Storage.
    Type of storage to configure.
    Choose a number from below, or type in your own value.
     1 / 1Fichier
       \ (fichier)
     2 / Akamai NetStorage
       \ (netstorage)
     3 / Alias for an existing remote
       \ (alias)
    .
    .
    .
    Storage> webdav # 选择webdav
    
    Option url.
    URL of http host to connect to.
    E.g. https://example.com.
    Enter a value.
    url> http://192.168.100.152:5244/dav # 这里填你alist的webdav地址
    
    Option vendor.
    Name of the WebDAV site/service/software you are using.
    Choose a number from below, or type in your own value.
    Press Enter to leave empty.
     1 / Fastmail Files
       \ (fastmail)
     2 / Nextcloud
       \ (nextcloud)
     3 / Owncloud
       \ (owncloud)
     4 / Sharepoint Online, authenticated by Microsoft account
       \ (sharepoint)
     5 / Sharepoint with NTLM authentication, usually self-hosted or on-premises
       \ (sharepoint-ntlm)
     6 / Other site/service or software
       \ (other)
    vendor> other # 选择other
    
    Option user.
    User name.
    In case NTLM authentication is used, the username should be in the format 'Domain\User'.
    Enter a value. Press Enter to leave empty.
    user> fregie # 这里填你alist的用户名
    
    Option pass.
    Password.
    Choose an alternative below. Press Enter for the default (n).
    y) Yes, type in my own password
    g) Generate random password
    n) No, leave this optional password blank (default)
    y/g/n> y
    Enter the password:
    password: # 这里填你alist的密码,注意输入的时候不会显示,输入后回车即可
    Confirm the password:
    password: # 再次输入密码确认
    
    Option bearer_token.
    Bearer token instead of user/pass (e.g. a Macaroon).
    Enter a value. Press Enter to leave empty.
    bearer_token>  # 直接回车跳过
    
    Edit advanced config?
    y) Yes
    n) No (default)
    y/n> n
    
    Configuration complete.
    Options:
    - type: webdav
    - url: http://192.168.100.152:5244/dav
    - vendor: other
    - user: fregie
    - pass: *** ENCRYPTED ***
    Keep this "alist" remote?
    y) Yes this is OK (default)
    e) Edit this remote
    d) Delete this remote
    y/e/d> y
    
    Current remotes:
    
    Name                 Type
    ====                 ====
    alist                webdav
    
    e) Edit existing remote
    n) New remote
    d) Delete remote
    r) Rename remote
    c) Copy remote
    s) Set configuration password
    q) Quit config
    e/n/d/r/c/s/q> q
    

检查配置是否成功:  
以下命令将列出webdav根目录下的文件和目录,能正确输出即为配置成功

    rclone lsd cloudreve:/ --max-depth 1
              -1 2023-09-04 15:00:14        -1 baidu
              -1 2023-09-06 14:19:17        -1 nas
              -1 2023-09-04 14:29:07        -1 quark
    

### 映射到NAS文件系统

    mkdir --mode=777 /mnt/cloudreve
    rclone mount --daemon --vfs-cache-mode minimal --allow-non-empty --allow-other cloudreve:/ /mnt/cloudreve -vv
    

查看映射是否成功,有类似以下输出即为成功

    ls /mnt/cloudreve
    baidu/  nas/  quark/
    
