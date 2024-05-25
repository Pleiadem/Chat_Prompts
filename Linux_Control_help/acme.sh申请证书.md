# 使用 acme.sh 申请域名 SSL 证书教程

本教程将指导您如何使用 acme.sh 脚本为您的域名申请 SSL 证书。主要步骤包括安装 acme.sh，设置默认的 CA 服务为 Let’s Encrypt，使用 standalone 模式申请证书，以及查看证书状态。

## 安装 acme.sh

首先，您需要安装 acme.sh 脚本。请按照以下步骤进行安装：

```sh
curl https://get.acme.sh | sh
```

安装完成后，您需要重新加载 shell 环境：

```sh
source ~/.bashrc
```

## 设置默认 CA 服务为 Let’s Encrypt

acme.sh 支持多个 CA 服务，默认情况下使用 ZeroSSL。我们将 CA 服务更改为 Let’s Encrypt。执行以下命令：

```sh
acme.sh --set-default-ca --server letsencrypt
```

有关 acme.sh 支持的 CA 服务的更多信息，请参阅 [acme.sh Wiki](https://github.com/acmesh-official/acme.sh/wiki/Server)。

## 使用 standalone 模式申请证书

要为您的域名申请 SSL 证书，您可以使用 standalone 模式。这种模式下，acme.sh 会启动一个临时的 Web 服务器来完成域名验证。请使用以下命令：

```sh
acme.sh --issue -d <你的域名> --standalone --httpport 80
```

您可以将 `80` 端口替换为其他可用的端口。如果 80 端口被占用或需要使用其他端口进行验证，可以如下替换：

```sh
acme.sh --issue -d <你的域名> --standalone --httpport <其他端口>
```

## 查看证书状态

您可以使用以下命令查看已申请证书的状态：

```sh
acme.sh --list
```

此命令将显示已管理的所有域名及其证书状态。

## 完整示例

1. 安装 acme.sh：

    ```sh
    curl https://get.acme.sh | sh
    source ~/.bashrc
    ```

2. 设置默认 CA 服务为 Let’s Encrypt：

    ```sh
    acme.sh --set-default-ca --server letsencrypt
    ```

3. 使用 standalone 模式申请证书（使用 80 端口）：

    ```sh
    acme.sh --issue -d example.com --standalone --httpport 80
    ```

4. 查看证书状态：

    ```sh
    acme.sh --list
    ```

通过上述步骤，您应该能够成功为您的域名申请到 SSL 证书。如果在申请过程中遇到问题，可以参考 [acme.sh 官方文档](https://github.com/acmesh-official/acme.sh) 获取更多帮助。

## 常见问题

- **端口占用问题**：如果 80 端口被其他服务占用，可以使用 `--httpport` 参数指定其他端口。
- **速率限制问题**：速率限制问题：如果申请过多失败，请等待一段时间后再重试，或检查配置确保正确。如果仍然遇到速率限制问题，可以尝试将域名的大小写变换一下，例如将 example.com 改为 Example.com 再尝试申请。

希望本教程对您有所帮助！