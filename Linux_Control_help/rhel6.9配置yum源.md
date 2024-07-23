[redhat6.7 yum网络源配置](https://www.cnblogs.com/lijiaman/p/10924535.html "发布于 2019-05-25 23:26")
=============================================================================================

RedHat自带的yum源需要当前系统注册了RHN才可以使用，如果没有注册，当使用yum时，会提示需要注册RHN

[![](https://img2018.cnblogs.com/blog/823295/201905/823295-20190525232555094-2069400004.png)](https://img2018.cnblogs.com/blog/823295/201905/823295-20190525232554524-1728601249.png)

如果没有注册RHN，则意味着我们不能使用RedHat自带的yum源。这个时候，我们可以使用CentOS系统的yum源，这里以配置网易163yum源为例。

1.首先卸载RedHat资源的yum程序

    rpm -qa|grep yum|xargs rpm -e --nodeps
    rpm -aq|grep python-iniparse|xargs rpm -e --nodeps

2.删除RedHat yum的源

    [root@Oracle12CDB ~]# cd /etc/yum.repos.d/
    [root@Oracle12CDB yum.repos.d\]# ls
    redhat.repo  rhel-source.repo
    [root@Oracle12CDB yum.repos.d\]# rm -rf \*

3.安装CentOS的源，rpm包对安装顺序有要求，我是使用下面的顺序安装成功的。

    rpm -ivh http://mirrors.163.com/centos/6/os/x86\_64/Packages/python-iniparse-0.3.1-2.1.el6.noarch.rpm                      
    rpm -ivh http://mirrors.163.com/centos/6/os/x86\_64/Packages/yum-metadata-parser-1.1.2-16.el6.x86\_64.rpm                  
    rpm -ivh http://mirrors.163.com/centos/6/os/x86\_64/Packages/python-urlgrabber-3.9.1-11.el6.noarch.rpm --nodeps --force    
    #下面的这两个包单独安装均失败，一起安装才成功
    rpm \-ivh http://mirrors.163.com/centos/6/os/x86\_64/Packages/yum-3.2.29-81.el6.centos.noarch.rpm \\             
    http://mirrors.163.com/centos/6/os/x86\_64/Packages/yum-plugin-fastestmirror-1.1.30-41.el6.noarch.rpm

网易的源失效，可以用
>http://vault.centos.org/6.9/os/x86_64/Packages/yum-3.2.29-81.el6.centos.noarch.rpm
>http://vault.centos.org/6.9/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.30-40.el6.noarch.rpm
>http://vault.centos.org/6.9/os/x86_64/Packages/python-urlgrabber-3.9.1-11.el6.noarch.rpm
>http://vault.centos.org/6.9/os/x86_64/Packages/yum-metadata-parser-1.1.2-16.el6.x86_64.rpm
>http://vault.centos.org/6.9/os/x86_64/Packages/python-iniparse-0.3.1-2.1.el6.noarch.rpm



这里先安装yum-plugin-fastestmirro提示改包依赖于yum包，安装yum包时则提示依赖于yum-plugin-fastestmirro包，于是直接2个包一起装[![](https://img2018.cnblogs.com/blog/823295/201905/823295-20190525232558675-1775134524.png)](https://img2018.cnblogs.com/blog/823295/201905/823295-20190525232557043-8810127.png)

4.创建repo文件

    [root@Oracle12CDB]# cd /etc/yum.repos.d
    [root@Oracle12CDB yum.repos.d\]# ls
    centos6.repo  redhat.repo

这里有两个文件，redhat.repo没有内容，不用管。centos6.repo内容如下：

    [base]
    name=CentOS-$releasever - Base
    baseurl=http://vault.centos.org/6.9/os/$basearch/
    gpgcheck=1
    gpgkey=http://vault.centos.org/6.9/os/x86_64/RPM-GPG-KEY-CentOS-6

    #released updates
    [updates]
    name=CentOS-$releasever - Updates
    baseurl=http://vault.centos.org/6.9/updates/$basearch/
    gpgcheck=1
    gpgkey=http://vault.centos.org/6.9/os/x86_64/RPM-GPG-KEY-CentOS-6

    [extras]
    name=CentOS-$releasever - Extras
    baseurl=http://vault.centos.org/6.9/extras/$basearch/
    gpgcheck=1
    gpgkey=http://vault.centos.org/6.9/os/x86_64/RPM-GPG-KEY-CentOS-6

    #additional packages that extend functionality of existing packages
    [centosplus]
    name=CentOS-$releasever - Plus
    baseurl=http://vault.centos.org/6.9/centosplus/$basearch/
    gpgcheck=1
    enabled=0


5.清除缓存，重新缓存，更新

    yum clean all
    yum makecache

【完】
