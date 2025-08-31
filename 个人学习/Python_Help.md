# Python项目依赖管理的艺术：两种方法导出 `requirements.txt`

![Python Logo](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Pip Logo](https://img.shields.io/badge/Pip-3776AB?style=for-the-badge&logo=pip&logoColor=white)

在 Python 开发中，创建一个 `requirements.txt` 文件是确保项目可移植性和可复现性的关键一步。它就像一张“购物清单”，告诉其他开发者或部署环境需要安装哪些依赖包。本文将介绍两种最常用且高效的方法来生成这个重要的文件。

---

## 为什么要创建 `requirements.txt`？

- **环境一致性**：确保每个开发者和生产环境都使用相同版本的依赖，避免“在我电脑上明明是好的”这类问题。
- **快速部署**：在新环境中，只需一条命令即可安装所有必需的包。
- **项目协作**：清晰地告诉团队成员项目依赖了哪些库。

---

## 方法一：标准做法 `pip freeze` (全面快照)

这是最经典、最直接的方法。它会捕获当前 Python 环境中**所有**已安装的包，并生成一份精确的快照。

### 操作步骤

1.  **激活虚拟环境 (强烈推荐)**

    在导出前，请务必激活项目的虚拟环境。这能确保我们只记录该项目相关的依赖，而不是系统全局的包。

    ```bash
    # Windows
    .\venv\Scripts\activate

    # Linux / macOS
    source venv/bin/activate
    ```

2.  **执行导出命令**

    在项目根目录下，运行以下命令：

    ```bash
    pip freeze > requirements.txt
    ```

    - **`pip freeze`**: 列出所有已安装的包及其版本。
    - **`>`**: 将命令的输出重定向到 `requirements.txt` 文件中。

### 优点
- 简单、原生，无需安装额外工具。
- 生成的列表非常精确，能100%复现当前环境。

### 缺点
- 会包含所有子依赖，可能列表过长，不够“干净”。

---

## 方法二：智能做法 `pipreqs` (精准扫描)

`pipreqs` 是一个非常智能的第三方工具。它不会查看你安装了什么，而是直接**扫描你的项目源代码**，只找出你在代码中 `import` 过的顶级依赖。

### 操作步骤

1.  **安装 `pipreqs`**
    
    ```bash
    pip install pipreqs
    ```

2.  **执行导出命令**

    在项目根目录下运行：

    ```bash
    pipreqs . --force
    ```

    - **`.`**: 表示在当前目录进行扫描。
    - **`--force`**: 如果 `requirements.txt` 已存在，则强制覆盖。

    **⚠️ Windows 用户注意**：如果遇到 `UnicodeDecodeError: 'gbk' codec can't decode...` 的错误，说明你的代码文件是 UTF-8 编码。请使用以下命令明确指定编码：

    ```bash
    pipreqs . --encoding=utf-8 --force
    ```

### 优点
- **精确、干净**：只包含项目直接依赖的包，文件更小，更易于管理。
- 避免了因包含过多子依赖而可能引发的版本冲突。

### 缺点
- 需要额外安装。
- 极少数情况下，可能无法识别通过动态方式（如 `__import__`）导入的包。

---

## 总结：如何选择？

| 场景 | 推荐方法 | 理由 |
| :--- | :--- | :--- |
| **个人项目或快速备份** | `pip freeze` | 简单快捷，能完美复现你的个人开发环境。 |
| **团队协作或开源项目** | `pipreqs` | **强烈推荐**。它创建了一个更清晰、更专业的依赖列表，是协作的最佳实践。 |


## 如何使用 `requirements.txt`？

当其他人拿到你的项目后，只需一条简单的命令，就能搭建起完全相同的开发环境：

```bash
pip install -r requirements.txt