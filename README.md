# G.A.Y.Driver - 无红绿灯路口自动驾驶AI

## 项目简介

本项目专注于训练自动驾驶AI系统，特别针对通过"无红绿灯"路口的场景。

## 项目结构

```
G.A.Y.Driver/
├── data/           # 数据集存储
├── models/         # 模型文件存储
├── src/            # 源代码
├── config/         # 配置文件
├── logs/           # 训练日志
└── docs/           # 文档
```

## 开发计划

- [ ] 数据收集与标注
- [ ] 模型架构设计
- [ ] 训练流程搭建
- [ ] 评估与测试

## 协作指南

**⚠️ 重要：所有协作者在开始工作前，必须阅读协作文档！**

### 📖 文档导航

- **[完整协作流程指南](docs/COLLABORATION.md)** - 详细的Git和GitHub操作教程
- **[快速参考卡](docs/QUICK_REFERENCE.md)** - 常用命令和规则速查
- **[分支保护配置指南](docs/BRANCH_PROTECTION.md)** - GitHub分支保护规则配置说明
- **[Docker 和 uv 环境配置](docs/DOCKER_SETUP.md)** - Docker 和 uv 使用指南
- **[终端自动激活虚拟环境](docs/AUTO_ACTIVATE.md)** - 配置终端自动激活虚拟环境

### 📋 文档内容

协作文档包含：
- ✅ Git基础操作教程（适合新手）
- ✅ 严格的分支管理策略
- ✅ 提交流程和检查清单
- ✅ Pull Request规范
- ✅ 常见错误解决方案
- ✅ 禁止事项清单

### 🚀 快速开始

下面所有的指令，在终端中运行！如果不知道在哪里随时询问我（yj）！
```bash
# 1. 克隆仓库
git clone [仓库地址]
cd G.A.Y.Driver

# 2. 阅读协作文档（必须！）
# 打开 docs/COLLABORATION.md

# 3. 配置Git用户信息（首次使用）
git config --global user.name "你的姓名"
git config --global user.email "your.email@example.com"

# 4. 更新代码并创建功能分支
git checkout main
git pull origin main
git checkout -b feature/your-feature-name

# 5. 开始开发
```

### ⚠️ 重要规则（简要）

- **禁止**直接提交到main分支
- **必须**在功能分支工作
- **必须**提交前检查代码
- **必须**等待PR审查批准后才能合并

## 环境配置

### 使用 uv 管理依赖（本地开发）

项目使用 [uv](https://github.com/astral-sh/uv) 作为 Python 包管理器，提供快速且统一的依赖管理。

#### 安装 uv

```bash
# Windows (PowerShell)
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh
```

#### 本地开发设置

```bash
# 同步依赖（创建虚拟环境并安装所有依赖）
uv sync

# 激活虚拟环境
source .venv/bin/activate  # Linux/macOS
# 或
.venv\Scripts\activate  # Windows

# 运行代码
uv run python src/main.py

# 添加新依赖
uv add package-name

# 添加开发依赖
uv add --dev package-name

# 更新依赖
uv sync --upgrade
```

#### 配置终端自动激活虚拟环境（可选）

为了方便开发，可以配置终端在进入项目目录时自动激活虚拟环境：

**Windows PowerShell:**
```powershell
# 运行配置脚本
.\scripts\setup-auto-activate.ps1

# 重新加载配置（或重新打开 PowerShell）
. $PROFILE
```

**Linux/macOS (Bash/Zsh):**
```bash
# 运行配置脚本
chmod +x scripts/setup-auto-activate.sh
./scripts/setup-auto-activate.sh

# 重新加载配置（或重新打开终端）
source ~/.bashrc  # 或 source ~/.zshrc
```

配置后，当你在项目目录或其子目录中打开终端时，虚拟环境会自动激活。

**手动配置（如果脚本不工作）:**

- **PowerShell**: 编辑 `$PROFILE`，添加 `scripts/auto-activate.ps1` 的内容
- **Bash**: 编辑 `~/.bashrc`，添加 `scripts/auto-activate.sh` 的内容
- **Zsh**: 编辑 `~/.zshrc`，添加 `scripts/auto-activate.sh` 的内容

### 使用 Docker（推荐用于服务器部署）

项目包含完整的 Docker 配置，便于在服务器上运行。

#### 构建和运行

```bash
# 构建 Docker 镜像
docker build -t gay-driver .

# 运行容器（交互式）
docker run -it --rm gay-driver

# 运行容器（后台）
docker run -d --name gay-driver gay-driver
```

#### 使用 Docker Compose（推荐）

```bash
# 启动应用容器
docker-compose up -d

# 进入容器
docker-compose exec app bash

# 启动开发环境（包含开发依赖）
docker-compose --profile dev up dev

# 查看日志
docker-compose logs -f

# 停止容器
docker-compose down
```

#### 挂载卷说明

Docker Compose 配置会自动挂载以下目录：
- `./src` → `/app/src` - 源代码（开发时实时修改）
- `./config` → `/app/config` - 配置文件
- `./data` → `/app/data` - 数据集
- `./models` → `/app/models` - 模型文件
- `./logs` → `/app/logs` - 训练日志

#### GPU 支持（如果需要）

如果服务器有 NVIDIA GPU，在 `docker-compose.yml` 中取消 GPU 相关注释，并确保安装了 [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)。

## 许可证

待定
