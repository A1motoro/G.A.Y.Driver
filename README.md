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
- **[环境配置完整指南](docs/ENVIRONMENT_SETUP.md)** - 从安装到配置的详细教程（推荐新手）
- **[UV PATH 配置指南](docs/UV_SETUP.md)** - 解决 IDE 集成终端找不到 uv 的问题
- **[Docker 配置说明](docs/DOCKER_SETUP.md)** - Docker 详细使用说明
- **[项目依赖说明](docs/DEPENDENCIES.md)** - 各依赖包的用途和说明
- **[终端自动激活虚拟环境](docs/AUTO_ACTIVATE.md)** - 配置终端自动激活虚拟环境
- **[虚拟环境问题排查](docs/VENV_TROUBLESHOOTING.md)** - 常见问题解决方案

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

### 📖 完整配置指南

**👉 [环境配置完整指南](docs/ENVIRONMENT_SETUP.md)** - 从安装 uv、Docker 到配置环境的详细教程

### 快速开始

如果你已经安装了 uv 和 Docker，可以快速配置：

```powershell
# 1. 进入项目目录
cd d:\Tide\G.A.Y.Driver

# 2. 创建虚拟环境并安装依赖
uv sync --dev

# 3. 运行代码
uv run python src/main.py
```

### 主要特性

- ✅ **uv 包管理**：快速、可靠的 Python 依赖管理
- ✅ **虚拟环境隔离**：`.venv/` 目录，不污染本机环境
- ✅ **清华镜像源**：已配置，自动加速下载
- ✅ **Docker 支持**：统一开发和生产环境
- ✅ **依赖锁定**：`uv.lock` 确保团队环境一致

### 常用命令

```powershell
# 安装依赖
uv sync --dev              # 安装所有依赖（包括开发工具）

# 运行代码
uv run python src/main.py   # 自动使用虚拟环境

# 添加依赖
uv add package-name         # 添加运行依赖
uv add --dev package-name  # 添加开发依赖

# Docker 开发
docker-compose --profile dev up -d dev  # 启动开发环境
docker-compose exec dev bash            # 进入容器
```

### 相关文档

- **[环境配置完整指南](docs/ENVIRONMENT_SETUP.md)** - 从零开始的详细教程
- **[UV PATH 配置指南](docs/UV_SETUP.md)** - 解决 IDE 找不到 uv 的问题
- **[Docker 配置说明](docs/DOCKER_SETUP.md)** - Docker 详细使用说明
- **[终端自动激活虚拟环境](docs/AUTO_ACTIVATE.md)** - 配置自动激活

## 许可证

待定
