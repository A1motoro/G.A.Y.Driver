# Docker 和 uv 环境配置指南

## 概述

项目使用 **uv** 作为 Python 包管理器，并通过 **Docker** 提供统一的运行环境，确保本地开发和生产服务器环境一致。

## 为什么使用 uv？

- ⚡ **极快的依赖解析和安装速度**（比 pip 快 10-100 倍）
- 🔒 **可靠的依赖锁定**（类似 npm 的 package-lock.json）
- 🎯 **统一的虚拟环境管理**
- 📦 **兼容 pip 和 PyPI**

## 为什么使用 Docker？

- 🐳 **环境一致性**：本地、测试、生产环境完全相同
- 🚀 **易于部署**：服务器上只需运行 `docker-compose up`
- 🔧 **隔离性**：不影响系统 Python 环境
- 💻 **跨平台**：Windows、macOS、Linux 统一体验

## 快速开始

### 1. 本地开发（使用 uv）

```bash
# 安装 uv（如果还没有）
# Windows PowerShell:
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

# macOS/Linux:
curl -LsSf https://astral.sh/uv/install.sh | sh

# 同步依赖（自动创建虚拟环境）
uv sync

# 激活虚拟环境
# Windows:
.venv\Scripts\activate

# macOS/Linux:
source .venv/bin/activate

# 运行代码
uv run python src/main.py
```

### 2. Docker 开发

```bash
# 构建镜像
docker build -t gay-driver .

# 或使用 docker-compose（推荐）
docker-compose up -d

# 进入容器
docker-compose exec app bash

# 在容器内运行代码
uv run python src/main.py
```

### 3. 开发环境（包含开发工具）

```bash
# 启动开发环境（包含 ruff、flake8 等）
docker-compose --profile dev up -d dev

# 进入开发容器
docker-compose exec dev bash
```

## 常用命令

### uv 命令

```bash
# 添加依赖
uv add numpy pandas

# 添加开发依赖
uv add --dev pytest black

# 更新依赖
uv sync --upgrade

# 锁定依赖版本（生成 uv.lock）
uv lock

# 运行命令（自动使用虚拟环境）
uv run python script.py
uv run pytest
```

### Docker 命令

```bash
# 构建镜像
docker build -t gay-driver .

# 运行容器（交互式）
docker run -it --rm gay-driver

# 运行容器（后台）
docker run -d --name gay-driver gay-driver

# 查看日志
docker logs -f gay-driver

# 停止容器
docker stop gay-driver
docker rm gay-driver
```

### Docker Compose 命令

```bash
# 启动服务
docker-compose up -d

# 查看日志
docker-compose logs -f

# 进入容器
docker-compose exec app bash

# 停止服务
docker-compose down

# 重建镜像
docker-compose build --no-cache

# 启动开发环境
docker-compose --profile dev up -d dev
```

## 目录挂载说明

Docker Compose 配置会自动挂载以下目录：

| 本地目录 | 容器目录 | 说明 |
|---------|---------|------|
| `./src` | `/app/src` | 源代码（开发时实时修改） |
| `./config` | `/app/config` | 配置文件 |
| `./data` | `/app/data` | 数据集 |
| `./models` | `/app/models` | 模型文件 |
| `./logs` | `/app/logs` | 训练日志 |

**注意**：挂载的目录在容器内修改会同步到本地，反之亦然。

## GPU 支持

如果服务器有 NVIDIA GPU，需要：

1. 安装 [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

2. 在 `docker-compose.yml` 中取消 GPU 相关注释：

```yaml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: all
          capabilities: [gpu]
```

3. 使用 `docker-compose up` 启动，GPU 会自动可用

## 故障排除

### uv 在 IDE 终端中找不到（但系统终端可以）

**问题现象**：在 IDE（如 VSCode/Cursor）的终端中运行 `uv --version` 报错，但在直接打开的 PowerShell 中可以运行。

**原因**：IDE 终端启动时可能没有加载最新的环境变量 PATH。

**解决方案**：

1. **重启 IDE**（最简单）
   - 完全关闭 IDE 并重新打开
   - IDE 会重新加载系统环境变量

2. **手动刷新环境变量**（在 IDE 终端中）
   ```powershell
   # 刷新 PATH 环境变量
   $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
   
   # 验证
   uv --version
   ```

3. **使用改进的初始化脚本**
   - 运行 `.\scripts\setup-env.ps1`
   - 脚本会自动查找 uv 并添加到当前会话的 PATH

4. **手动添加 uv 到 PATH**（永久解决）
   ```powershell
   # 查找 uv 安装位置（通常在以下位置之一）
   # %USERPROFILE%\.cargo\bin\uv.exe
   # %LOCALAPPDATA%\uv\uv.exe
   
   # 添加到系统 PATH（需要管理员权限）
   [Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Users\YourName\.cargo\bin", "User")
   ```

### uv 安装失败

```bash
# 检查网络连接
curl https://astral.sh/uv/install.sh

# 手动下载安装
# 访问 https://github.com/astral-sh/uv/releases
```

### Docker 构建失败

```bash
# 清理 Docker 缓存
docker system prune -a

# 重新构建（不使用缓存）
docker build --no-cache -t gay-driver .
```

### 依赖安装失败

```bash
# 在 Docker 容器内
docker-compose exec app bash
uv sync --upgrade

# 或本地
uv sync --upgrade
```

### 权限问题（Linux/macOS）

```bash
# 确保脚本有执行权限
chmod +x scripts/docker-build.sh
```

## 最佳实践

1. **提交 `uv.lock` 文件**：确保所有环境使用相同的依赖版本
2. **使用 Docker Compose**：简化多容器管理
3. **开发时使用挂载卷**：实时查看代码修改效果
4. **生产环境使用构建镜像**：不挂载源代码，更安全
5. **定期更新依赖**：`uv sync --upgrade` 检查更新

## 服务器部署

在服务器上部署时：

```bash
# 1. 克隆仓库
git clone <repository-url>
cd G.A.Y.Driver

# 2. 构建镜像
docker-compose build

# 3. 启动服务
docker-compose up -d

# 4. 查看日志
docker-compose logs -f

# 5. 进入容器（如需要）
docker-compose exec app bash
```

## 相关文档

- [uv 官方文档](https://github.com/astral-sh/uv)
- [Docker 官方文档](https://docs.docker.com/)
- [Docker Compose 文档](https://docs.docker.com/compose/)
