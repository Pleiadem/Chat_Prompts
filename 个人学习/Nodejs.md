### 如何在 Windows 和 macOS 上安装 Node.js 和 pnpm

`Node.js` 是一个基于 Chrome V8 引擎的 JavaScript 运行时，它让你可以在服务器端或本地环境中运行 JavaScript。`pnpm` 是一个高效的包管理工具，它与 `npm` 和 `Yarn` 兼容，但有着更好的性能和磁盘空间管理。在这篇博客中，我将详细介绍如何安装 `Node.js`，然后使用 `npm` 安装 `pnpm`。

---

## 一、安装 Node.js

在开始之前，你需要确保安装了 `Node.js`，因为 `pnpm` 需要依赖 `Node.js` 的环境。以下是安装 `Node.js` 的步骤：

### 1.1 下载 Node.js

1. 访问 [Node.js 官方网站](https://nodejs.org/)。
2. 你会看到两个版本的下载选项：
   - **LTS (长期支持)**：更稳定，适合生产环境。
   - **Current (当前版本)**：包含最新的功能，适合开发者测试新功能。

   **推荐选择 LTS 版本**，因为它更加稳定。

3. 点击下载对应操作系统的安装包（Windows 或 macOS）。

### 1.2 安装 Node.js (Windows)

1. 下载完成后，运行安装程序。
2. 按照安装向导的提示进行安装，默认配置即可。
   - **建议选中** `Add to PATH` 选项，这样你可以在命令行中直接使用 `node` 和 `npm`。
3. 安装完成后，可以打开命令提示符（`cmd`）或终端（`PowerShell`），输入以下命令来验证安装是否成功：

   ```bash
   node -v
   npm -v
   ```

   如果看到版本号输出，说明 `Node.js` 和 `npm` 已成功安装。

### 1.3 安装 Node.js (macOS)

1. 下载完成后，运行 `.pkg` 安装包。
2. 按照安装向导的提示完成安装，默认配置即可。
3. 安装完成后，打开终端（Terminal），输入以下命令验证安装是否成功：

   ```bash
   node -v
   npm -v
   ```

## 二、安装 pnpm

安装 `Node.js` 后，你会自动得到 `npm` 作为包管理工具。我们接下来可以使用 `npm` 安装 `pnpm`。

### 2.1 使用 npm 安装 pnpm

在命令行或终端中运行以下命令来全局安装 `pnpm`：

```bash
npm install -g pnpm
```

这条命令会将 `pnpm` 安装到你的全局环境中，因此可以在任何地方使用 `pnpm` 命令。

### 2.2 验证 pnpm 安装

安装完成后，运行以下命令来验证 `pnpm` 是否正确安装：

```bash
pnpm -v
```

如果输出了版本号，说明安装成功。

## 三、pnpm 的基本使用

下面介绍一些 `pnpm` 的基本命令，让你可以快速上手。

### 3.1 初始化项目

使用 `pnpm` 初始化一个新项目：

```bash
pnpm init
```

这会创建一个 `package.json` 文件，包含项目的基本信息。

### 3.2 安装依赖

使用 `pnpm` 安装项目依赖包：

```bash
pnpm install package-name
```

### 3.3 升级依赖

升级项目依赖到最新版本：

```bash
pnpm update package-name
```

### 3.4 删除依赖

删除项目中的某个依赖：

```bash
pnpm remove package-name
```

### 3.5 运行脚本

你可以使用 `pnpm` 运行 `package.json` 中定义的脚本，例如 `start` 或 `test`：

```bash
pnpm run start
```

## 四、常见问题及解决方案

### 4.1 如何更改 `pnpm` 的存储位置？

`pnpm` 默认会将依赖存储在一个全局缓存目录。如果你想更改存储位置，可以通过以下命令设置：

```bash
pnpm config set store-dir D:\pnpm-store
```

这会将全局依赖缓存存储在 `D:\pnpm-store` 目录中。

### 4.2 `pnpm` 使用硬链接是否会影响依赖？

不会！`pnpm` 使用硬链接的方式将依赖指向全局缓存，即使删除一个项目，其他项目依然可以正常使用这些依赖。这是因为硬链接直接引用文件内容，而不是文件路径。

---

## 五、总结

通过这篇博客，你已经学会了如何安装 `Node.js` 和 `pnpm`。`pnpm` 是一个高效、现代化的包管理工具，它的独特优势在于：
1. 节省磁盘空间：全局缓存依赖，多个项目共享相同版本的依赖。
2. 更快的安装速度：得益于硬链接和符号链接，`pnpm` 安装速度比 `npm` 快很多。
3. 兼容性强：`pnpm` 完全兼容 `npm` 和 `Yarn` 的包管理生态，可以无缝迁移。

希望这篇教程能帮助你顺利开始使用 `pnpm`！如果有任何问题，欢迎在评论区讨论。
