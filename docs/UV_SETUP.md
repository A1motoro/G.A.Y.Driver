# UV 环境配置指南

## 问题：IDE 集成终端找不到 uv

即使你已经将 `C:\Users\Almoo\.local\bin` 添加到系统 PATH，IDE 的集成终端可能仍然找不到 `uv`。这是因为：

1. **IDE 启动时读取环境变量**：IDE 在启动时会读取系统环境变量，如果是在添加 PATH 之后才启动的 IDE，需要重启 IDE
2. **PowerShell 配置文件**：某些 IDE 的集成终端可能没有加载用户的 PowerShell 配置文件

## 解决方案

### 方案 1：重启 IDE（推荐）

最简单的方法是**完全关闭并重新启动 IDE**（Cursor/VSCode），这样 IDE 会重新读取系统环境变量。

### 方案 2：使用临时脚本（快速解决）

在 IDE 的集成终端中运行：

```powershell
# 临时添加到当前会话
$env:PATH += ";C:\Users\Almoo\.local\bin"

# 验证是否可用
uv --version
```

或者使用项目提供的脚本：

```powershell
.\scripts\setup-uv-path.ps1
```

### 方案 3：配置 PowerShell 配置文件（永久解决）

1. 打开 PowerShell 配置文件：
   ```powershell
   notepad $PROFILE
   ```

2. 如果文件不存在，先创建：
   ```powershell
   if (!(Test-Path $PROFILE)) { New-Item -Path $PROFILE -ItemType File -Force }
   notepad $PROFILE
   ```

3. 添加以下内容：
   ```powershell
   # 添加 uv 到 PATH
   $uvPath = "C:\Users\Almoo\.local\bin"
   if (Test-Path "$uvPath\uv.exe") {
       if ($env:PATH -notlike "*$uvPath*") {
           $env:PATH = "$uvPath;$env:PATH"
       }
   }
   ```

4. 保存并重新加载配置：
   ```powershell
   . $PROFILE
   ```

### 方案 4：直接使用完整路径

如果以上方法都不行，可以直接使用完整路径：

```powershell
C:\Users\Almoo\.local\bin\uv.exe sync --dev
```

或者创建一个别名：

```powershell
Set-Alias -Name uv -Value "C:\Users\Almoo\.local\bin\uv.exe"
```

## 验证配置

运行以下命令验证 uv 是否可用：

```powershell
uv --version
```

应该输出类似：`uv 0.9.27 (b5797b2ab 2026-01-26)`

## 创建虚拟环境

配置好 uv 后，在项目根目录运行：

```powershell
# 创建虚拟环境并安装所有依赖（包括开发依赖）
uv sync --dev
```

虚拟环境会创建在项目根目录的 `.venv` 文件夹中，**不会污染本机环境**。

## 网络问题

### ✅ 已配置清华镜像源

项目已在 `pyproject.toml` 中配置了**清华镜像源**作为默认 PyPI 源，所有依赖下载都会自动使用镜像加速，无需手动指定。

配置位置：`pyproject.toml` 中的 `[[tool.uv.index]]` 部分。

### 如果仍然遇到网络问题

1. **检查网络连接**：确保可以访问 `https://pypi.tuna.tsinghua.edu.cn`
2. **配置代理**（如果使用代理）：
   ```powershell
   $env:HTTP_PROXY = "http://proxy.example.com:8080"
   $env:HTTPS_PROXY = "http://proxy.example.com:8080"
   ```
3. **临时使用其他镜像源**（如果需要）：
   ```powershell
   uv sync --dev --index-url https://mirrors.aliyun.com/pypi/simple/
   ```

## 虚拟环境位置

- **位置**：`.venv/`（项目根目录）
- **已添加到 .gitignore**：虚拟环境不会被提交到 Git
- **隔离性**：完全独立，不会影响系统 Python 环境

## 使用虚拟环境

### 方法 1：使用 uv run（推荐）

```powershell
# 自动使用虚拟环境运行
uv run python src/main.py
```

### 方法 2：手动激活

```powershell
# Windows PowerShell
.venv\Scripts\Activate.ps1

# 如果遇到执行策略错误，运行：
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

激活后，终端提示符前会显示 `(.venv)`。

## 硬链接警告问题

### 警告信息

如果看到以下警告：
```
warning: Failed to hardlink files; falling back to full copy. 
This may lead to degraded performance.
```

### 原因说明

这个警告出现是因为：
- **硬链接限制**：`uv` 尝试从缓存目录创建硬链接到虚拟环境，但失败了
- **常见原因**：缓存目录（通常在 `C:\Users\Almoo\AppData\Local\uv\cache`）和虚拟环境（`.venv`）在不同的文件系统或磁盘分区上
- **影响**：`uv` 会回退到完整复制文件，虽然功能正常，但可能稍慢

### ✅ 已配置解决方案

项目已在 `pyproject.toml` 中配置了 `link-mode = "copy"`，这会：
- ✅ 消除警告信息
- ✅ 使用复制模式（更稳定，跨文件系统兼容）
- ✅ 对大多数用户来说性能差异可忽略

### 手动配置（如果需要）

如果不想在 `pyproject.toml` 中配置，也可以：

**方法 1：环境变量（当前会话）**
```powershell
$env:UV_LINK_MODE = "copy"
uv sync --dev
```

**方法 2：命令行参数（单次使用）**
```powershell
uv sync --dev --link-mode=copy
```

**方法 3：PowerShell 配置文件（永久）**
在 `$PROFILE` 中添加：
```powershell
$env:UV_LINK_MODE = "copy"
```

### 性能说明

- **硬链接模式**：更快，但需要缓存和虚拟环境在同一文件系统
- **复制模式**：稍慢，但更稳定，跨文件系统兼容
- **实际影响**：对于大多数项目，性能差异很小，可以忽略
