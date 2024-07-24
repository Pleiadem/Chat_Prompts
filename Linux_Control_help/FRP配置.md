# 使用FRP进行内网穿透的配置教程

在本篇博客中，我们将介绍如何使用FRP（Fast Reverse Proxy）进行内网穿透，并详细讲解如何配置FRP的服务端和客户端。FRP是一款高性能的反向代理应用，广泛用于内网穿透等场景。

## 服务端配置

### 步骤一：下载FRP

首先，我们需要下载FRP的最新版本。在终端中执行以下命令：

```bash
wget https://github.com/fatedier/frp/releases/download/v0.59.0/frp_0.59.0_linux_amd64.tar.gz
```

### 步骤二：解压FRP

下载完成后，解压FRP压缩包：

```bash
tar -xzf frp_0.59.0_linux_amd64.tar.gz
```

### 步骤三：配置FRP服务端

解压后，进入FRP的目录，找到并编辑 `frps.ini` 配置文件。以下是示例配置：

```ini
bind_port = 7000
auth_method = "token"
auth_token = "123456"
web_server_addr = "0.0.0.0"
web_server_port = 7500
web_server_user = "admin"
web_server_password = "admin"
```

上述配置说明：

- `bind_port`: FRP服务端监听的端口，设置为7000。
- `auth_method` 和 `auth_token`: 认证方法和认证令牌，确保客户端和服务端匹配。
- `web_server_addr` 和 `web_server_port`: 服务端仪表盘的地址和端口，便于管理和监控。
- `web_server_user` 和 `web_server_password`: 服务端仪表盘的登录用户名和密码。

## 客户端配置

### 步骤一：下载FRP

同样地，我们需要在客户端下载FRP。在终端中执行以下命令：

```bash
wget https://github.com/fatedier/frp/releases/download/v0.59.0/frp_0.59.0_linux_amd64.tar.gz
```

### 步骤二：解压FRP

下载完成后，解压FRP压缩包：

```bash
tar -xzf frp_0.59.0_linux_amd64.tar.gz
```

### 步骤三：配置FRP客户端

解压后，进入FRP的目录，找到并编辑 `frpc.ini` 配置文件。以下是示例配置：

```ini
server_addr = "192.168.1.1"
server_port = 7000
auth_method = "token"
auth_token = "123456"

[[proxies]]
name = "ssh"
type = "tcp"
local_ip = "127.0.0.1"
local_port = 22
remote_port = 7722

[[proxies]]
name = "ISP"
type = "tcp"
local_ip = "127.0.0.1"
local_port = 5060
remote_port = 7760

[[proxies]]
name = "ISP-UDP"
type = "udp"
local_ip = "127.0.0.1"
local_port = 5060
remote_port = 7760

[[proxies]]
name = "1Panel"
type = "tcp"
local_ip = "127.0.0.1"
local_port = 8088
remote_port = 7780
```

上述配置说明：

- `server_addr` 和 `server_port`: 指定FRP服务端的地址和端口。
- `auth_method` 和 `auth_token`: 与服务端匹配的认证方法和认证令牌。
- `[[proxies]]`: 配置代理服务，每个代理服务包含以下字段：
  - `name`: 代理服务的名称。
  - `type`: 代理类型，支持 `tcp` 和 `udp`。
  - `local_ip` 和 `local_port`: 本地服务的地址和端口。
  - `remote_port`: FRP服务端暴露的远程端口。

## 设置开机自启

为了在Ubuntu系统中设置FRP客户端（`frpc`）在开机时自动启动，可以使用`systemd`来创建一个服务。以下是详细的步骤：

---

一般把可执行文件放
`/usr/local/bin/frpc`
配置文件放
`/etc/frp/frpc.toml`

---

### 步骤一：创建systemd服务文件

1. 创建一个新的服务文件：

    ```bash
    sudo nano /etc/systemd/system/frpc.service
    ```



2. 在文件中添加以下内容：

    ```ini
    [Unit]
    Description=FRP Client Service
    After=network.target

    [Service]
    Type=simple
    ExecStart=/usr/local/bin/frpc -c /etc/frp/frpc.toml
    Restart=on-failure
    User=root

    [Install]
    WantedBy=multi-user.target

    ```

    说明：
    - `ExecStart`：指定FRP客户端的启动命令以及配置文件的路径。
    - `Restart`：确保服务在失败时自动重启。
    - `User`：运行该服务的用户，这里设置为`root`。

3. 保存并退出编辑器。

### 步骤二：重新加载systemd配置

```bash
sudo systemctl daemon-reload
```

### 步骤三：启用并启动FRP客户端服务

```bash
sudo systemctl enable frpc
sudo systemctl start frpc
```

### 步骤四：验证服务状态

你可以使用以下命令来检查服务的状态：

```bash
sudo systemctl status frpc
```

如果服务已经启动并正在运行，你应该会看到类似以下的输出：

```
● frpc.service - FRP Client Service
   Loaded: loaded (/etc/systemd/system/frpc.service; enabled; vendor preset: enabled)
   Active: active (running) since ...
     Docs: ...
 Main PID: ...
    Tasks: ...
   Memory: ...
   CGroup: ...
```

通过以上步骤，FRP客户端将在系统启动时自动运行，并使用指定的配置文件。如果你需要更改配置，只需编辑`frpc.toml`文件并重启服务：

```bash
sudo systemctl restart frpc
```

这样配置好后，你的FRP客户端就会在每次系统启动时自动运行。

## 结语

通过上述步骤，我们成功配置了FRP的服务端和客户端，实现了内网穿透。这样，我们就可以通过FRP服务端的暴露端口访问客户端的内网服务，如SSH、SIP、Web服务等。

希望这篇教程能帮助到大家。如果在配置过程中遇到任何问题，欢迎留言讨论。