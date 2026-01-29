# 环境配置完整指南

本指南将带你从零开始配置项目开发环境，包括安装 uv、Docker 以及配置虚拟环境。

## 📋 目录

1. [安装 uv](#1-安装-uv)
2. [安装 Docker](#2-安装-docker)
3. [配置项目环境](#3-配置项目环境)
4. [验证安装](#4-验证安装)
5. [常见问题](#5-常见问题)

---

## 1. 安装 uv

### Windows

**方法 1：使用 PowerShell（推荐）**

1. 打开 PowerShell（以管理员身份运行，可选）
2. 运行安装命令：
   ```powershell
   powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
   ```
3. 安装完成后，**关闭并重新打开 PowerShell**（或重启 IDE）
4. 验证安装：
   ```powershell
   uv --version
   ```
   应该看到类似：`uv 0.9.27 (b5797b2ab 2026-01-26)`

**方法 2：手动安装**

1. 访问 [uv 发布页面](https://github.com/astral-sh/uv/releases)
2. 下载 Windows 版本（`uv-x.x.x-x86_64-pc-windows-msvc.zip`）
3. 解压到任意目录（如 `C:\Users\YourName\.local\bin`）
4. 将该目录添加到系统 PATH 环境变量

### macOS/Linux

```bash
# 使用官方安装脚本
curl -LsSf https://astral.sh/uv/install.sh | sh

# 重新加载 shell 配置
source ~/.bashrc  # 或 source ~/.zshrc

# 验证安装
uv --version
```

### 验证安装

```powershell
# Windows PowerShell
uv --version

# macOS/Linux
uv --version
```

如果显示版本号，说明安装成功。

---

## 2. 安装 Docker

### Windows

1. **下载 Docker Desktop**
   - 访问 [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/)
   - 下载并运行安装程序

2. **安装步骤**
   - 运行安装程序，按照向导完成安装
   - 安装完成后，**重启计算机**

3. **启动 Docker Desktop**
   - 从开始菜单启动 Docker Desktop
   - 等待 Docker 引擎启动（系统托盘图标变为运行状态）

4. **验证安装**
   ```powershell
   docker --version
   docker-compose --version
   ```

### macOS

1. **下载 Docker Desktop**
   - 访问 [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop/)
   - 下载并安装

2. **启动 Docker Desktop**
   - 从应用程序启动 Docker Desktop
   - 等待 Docker 引擎启动

3. **验证安装**
   ```bash
   docker --version
   docker-compose --version
   ```

### Linux

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install docker.io docker-compose

# 启动 Docker 服务
sudo systemctl start docker
sudo systemctl enable docker

# 将当前用户添加到 docker 组（避免每次使用 sudo）
sudo usermod -aG docker $USER

# 重新登录或运行
newgrp docker

# 验证安装
docker --version
docker-compose --version
```

---

## 3. 配置项目环境

### 步骤 1：克隆项目（如果还没有）

```bash
git clone https://github.com/A1motoro/G.A.Y.Driver
cd G.A.Y.Driver
```

### 步骤 2：配置 IDE 终端（如果 uv 找不到）

**问题**：IDE 集成终端找不到 `uv`，但系统终端可以。

**解决方案**：

**方案 A：重启 IDE（最简单）**
- 完全关闭 IDE（Cursor/VSCode）
- 重新打开 IDE
- IDE 会重新加载系统环境变量

**方案 B：临时添加到当前会话**
```powershell
# 在 IDE 终端中运行（根据你的 uv 安装位置调整路径）
$env:PATH += ";C:\Users\Almoo\.local\bin"

# 验证
uv --version
```

**方案 C：使用项目脚本**
```powershell
.\scripts\setup-uv-path.ps1
```

### 步骤 3：创建虚拟环境并安装依赖

**本地开发（推荐）**

```powershell
# 进入项目目录
cd d:\Tide\G.A.Y.Driver

# 创建虚拟环境并安装所有依赖（包括开发工具）
uv sync --dev
```

**说明**：
- `uv sync`：只安装运行依赖，如果你不需要修改代码，请用这个
- `uv sync --dev`：安装运行依赖 + 开发工具（ruff、black、mypy 等）。如果你需要写代码，请用这个。
- 虚拟环境位置：`.venv/`（项目根目录，已添加到 `.gitignore`）
- 镜像源：已配置清华镜像源，自动加速下载

**如果遇到网络问题**：

```powershell
# 检查网络连接
Test-NetConnection pypi.tuna.tsinghua.edu.cn -Port 443

# 如果使用代理，设置代理环境变量
$env:HTTP_PROXY = "http://proxy.example.com:8080"
$env:HTTPS_PROXY = "http://proxy.example.com:8080"

# 然后重新运行
uv sync --dev
```

### 步骤 4：验证虚拟环境

```powershell
# 方法 1：使用 uv run（推荐，自动使用虚拟环境）
uv run python --version
uv run python -c "import torch; print(torch.__version__)"

# 方法 2：手动激活虚拟环境
.venv\Scripts\Activate.ps1  # Windows PowerShell
# 或
source .venv/bin/activate   # macOS/Linux

# 激活后，终端提示符前会显示 (.venv)
python --version
```

---

## 4. 验证安装

### 验证 uv 和虚拟环境

```powershell
# 检查 uv 版本
uv --version

# 检查 Python 版本（应该使用虚拟环境中的 Python）
uv run python --version

# 检查关键依赖是否安装
uv run python -c "import torch; print('PyTorch:', torch.__version__)"
uv run python -c "import cv2; print('OpenCV:', cv2.__version__)"
uv run python -c "import numpy; print('NumPy:', numpy.__version__)"
```

### 验证 Docker

```powershell
# 检查 Docker 版本
docker --version
docker-compose --version

# 测试 Docker 是否正常运行
docker run hello-world
```

### 测试项目运行

```powershell
# 运行主程序（使用虚拟环境）
uv run python src/main.py
```

---

## 5. 常见问题

### 问题 1：IDE 终端找不到 uv

**症状**：在 IDE 终端运行 `uv --version` 报错，但系统终端可以。

**解决方案**：
1. **重启 IDE**（最简单有效）
2. **临时添加 PATH**：
   ```powershell
   $env:PATH += ";C:\Users\Almoo\.local\bin"
   ```
3. **使用完整路径**：
   ```powershell
   C:\Users\Almoo\.local\bin\uv.exe sync --dev
   ```

详细说明请参考：[UV PATH 配置指南](UV_SETUP.md)

### 问题 2：硬链接警告

**症状**：看到警告 `Failed to hardlink files; falling back to full copy`

**说明**：这是正常现象，项目已配置 `link-mode = "copy"`，警告应该不会出现。如果出现，可以忽略，不影响功能。

### 问题 3：网络连接失败

**症状**：`uv sync` 时无法连接到 PyPI

**解决方案**：
1. **检查镜像源配置**：项目已配置清华镜像源，检查 `pyproject.toml` 中的 `[[tool.uv.index]]`
2. **测试网络连接**：
   ```powershell
   Test-NetConnection pypi.tuna.tsinghua.edu.cn -Port 443
   ```
3. **配置代理**（如果使用）：
   ```powershell
   $env:HTTP_PROXY = "http://proxy.example.com:8080"
   $env:HTTPS_PROXY = "http://proxy.example.com:8080"
   ```

### 问题 4：Docker 无法启动

**症状**：Docker Desktop 无法启动或报错

**解决方案**：
1. **检查系统要求**：确保 Windows 10/11 64位，启用了 WSL 2 或 Hyper-V
2. **重启 Docker Desktop**：完全退出后重新启动
3. **检查 WSL 2**（Windows）：
   ```powershell
   wsl --status
   wsl --update
   ```

### 问题 5：虚拟环境激活失败

**症状**：运行 `.venv\Scripts\Activate.ps1` 报执行策略错误

**解决方案**：
```powershell
# 设置执行策略（仅当前用户）
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 或者直接使用 uv run（推荐，无需激活）
uv run python src/main.py
```

### 问题 6：macOS 构建错误（hatchling.build.build_editable 失败）

**症状**：在 macOS 上运行 `uv sync` 时出现错误：
```
Failed to build `gay-driver @ file:///...`
  ├─▶ The build backend returned an error
  ╰─▶ Call to `hatchling.build.build_editable` failed (exit status: 1)
```

**解决方案**：

1. **确保 Python 版本正确**：
   ```bash
   python --version  # 应该是 3.10 或更高版本
   ```

2. **清理并重新安装**：
   ```bash
   # 删除旧的虚拟环境
   rm -rf .venv
   
   # 重新同步依赖
   uv sync --dev
   ```

3. **如果问题仍然存在，手动安装 hatchling**：
   ```bash
   # 使用 uv 安装 hatchling
   uv pip install hatchling
   
   # 然后重新同步
   uv sync --dev
   ```

4. **检查 pyproject.toml 配置**：
   - 确保 `[build-system]` 部分包含 `requires = ["hatchling"]`
   - 确保 `src/gay_driver/` 目录存在且包含 `__init__.py`
   - 如果已修复配置，重新运行 `uv sync --dev`

**注意**：项目已配置为让 hatchling 自动检测 src-layout，通常不需要手动指定包路径。

---

## 6. 使用 Docker（可选）

如果你更喜欢使用 Docker 进行开发：

### 启动开发环境

```powershell
# 构建并启动容器（包含开发工具）
docker-compose --profile dev up -d dev

# 进入容器
docker-compose exec dev bash

# 在容器内运行代码
uv run python src/main.py
```

### Docker Compose 常用命令

```powershell
# 启动服务
docker-compose up -d

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down

# 重建镜像
docker-compose build --no-cache
```

详细说明请参考：[Docker 配置说明](DOCKER_SETUP.md)

---

## 7. 下一步

环境配置完成后，你可以：

1. **阅读项目文档**：
   - [项目依赖说明](DEPENDENCIES.md) - 了解各依赖包的用途
   - [协作指南](COLLABORATION.md) - Git 和 GitHub 工作流程

2. **开始开发**：
   ```powershell
   # 运行代码
   uv run python src/main.py
   
   # 添加新依赖
   uv add package-name
   
   # 代码格式化
   uv run black src/
   
   # 代码检查
   uv run ruff check src/
   ```

3. **配置自动激活虚拟环境**（可选）：
   - 参考：[终端自动激活虚拟环境](AUTO_ACTIVATE.md)

---

## 快速参考

### uv 常用命令

```powershell
# 安装依赖
uv sync --dev              # 安装所有依赖（包括开发工具）
uv sync                    # 只安装运行依赖

# 添加依赖
uv add package-name        # 添加运行依赖
uv add --dev package-name # 添加开发依赖

# 运行代码
uv run python src/main.py # 自动使用虚拟环境运行

# 更新依赖
uv sync --upgrade         # 更新所有依赖到最新版本
uv lock                   # 锁定依赖版本（生成 uv.lock）
```

### Docker 常用命令

```powershell
# 启动开发环境
docker-compose --profile dev up -d dev

# 进入容器
docker-compose exec dev bash

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down
```

---

## 需要帮助？

如果遇到问题：
1. 查看本文档的 [常见问题](#5-常见问题) 部分
2. 查看详细文档：
   - [UV PATH 配置指南](UV_SETUP.md)
   - [Docker 配置说明](DOCKER_SETUP.md)
3. 联系项目维护者
