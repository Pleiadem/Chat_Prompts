# Linux设置简单密码

修改  `/etc/pam.d/common-password`

将

    # here are the per-package modules (the "Primary" block)
    password        [success=1 default=ignore]      pam_unix.so obscure sha512


修改为：

    # here are the per-package modules (the "Primary" block)
    password        [success=1 default=ignore]      pam_unix.so minlen=1 sha512

***即 删除`obscure`以及添加`minlen=1`***

然后直接命令行 `passwd` 就行