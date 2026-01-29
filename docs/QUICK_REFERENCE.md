# Git协作快速参考卡

> 📌 **重要提醒**：详细说明请查看 [完整协作指南](COLLABORATION.md)

## ⚠️ 必须遵守的规则

1. ✅ **永远**在功能分支工作，**禁止**直接提交到main
2. ✅ **每次**开始工作前先更新代码：`git pull origin main`
3. ✅ **提交前**检查：代码测试通过、无临时文件、提交信息清晰
4. ✅ **推送前**再次确认：只提交相关文件、无敏感信息

---

## 📋 标准工作流程

### 1. 开始新功能

```bash
# 步骤1：更新代码
git checkout main
git pull origin main

# 步骤2：创建功能分支
git checkout -b feature/功能名称

# 步骤3：开始开发
# ... 编写代码 ...
```

### 2. 提交代码

```bash
# 步骤1：查看更改
git status
git diff

# 步骤2：添加文件（明确指定，不要用 git add .）
git add src/your_file.py

# 步骤3：提交（格式：类型: 描述）
git commit -m "feat: 添加路口检测功能"

# 步骤4：推送
git push -u origin feature/功能名称
```

### 3. 创建Pull Request

1. 在GitHub网页上点击 "Pull requests" → "New pull request"
2. 选择你的分支合并到 `main`
3. 填写标题和描述
4. 等待审查和批准

---

## 🔍 常用命令

| 操作 | 命令 |
|------|------|
| 查看状态 | `git status` |
| 查看更改 | `git diff` |
| 切换分支 | `git checkout 分支名` |
| 创建分支 | `git checkout -b 分支名` |
| 查看分支 | `git branch` |
| 更新代码 | `git pull origin main` |
| 查看历史 | `git log --oneline` |

---

## 📝 提交信息格式

```
类型: 简短描述（50字以内）
```

**类型：**
- `feat`: 新功能
- `fix`: Bug修复
- `docs`: 文档
- `style`: 格式调整
- `refactor`: 重构
- `test`: 测试

**示例：**
- ✅ `feat: 添加路口检测功能`
- ✅ `fix: 修复碰撞检测bug`
- ❌ `update`（太模糊）
- ❌ `fix`（缺少描述）

---

## 🚨 常见错误处理

### 提交到了main分支？

```bash
git checkout -b feature/your-feature  # 保存更改到新分支
git checkout main
git reset --hard origin/main          # 重置main分支
```

### 提交信息写错了？

```bash
git commit --amend -m "正确的提交信息"
```

### 想撤销文件更改？

```bash
git checkout -- 文件名
```

---

## ❌ 禁止事项

- ❌ 直接提交到main分支
- ❌ 使用 `git add .`（必须明确指定文件）
- ❌ 提交大文件（>100MB）
- ❌ 提交敏感信息（密码、密钥）
- ❌ 提交临时文件、日志文件
- ❌ 无意义的提交信息

---

---

## 🐍 环境管理快速参考

### 首次设置

```bash
# Windows (PowerShell)
.\scripts\setup-env.ps1

# macOS/Linux
chmod +x scripts/setup-env.sh
./scripts/setup-env.sh
```

### 常用命令

| 操作 | 命令 |
|------|------|
| 创建/更新环境 | `uv sync --dev` |
| 运行代码 | `uv run python src/main.py` |
| 添加依赖 | `uv add package-name` |
| 添加开发依赖 | `uv add --dev package-name` |
| 更新依赖 | `uv sync --upgrade` |
| 锁定版本 | `uv lock` |
| 激活环境 | `.venv\Scripts\activate` (Windows)<br>`source .venv/bin/activate` (Linux/macOS) |

**提示**：使用 `uv run` 无需手动激活虚拟环境！

---

## 📚 需要帮助？

1. 查看 [完整协作指南](COLLABORATION.md)
2. 查看 [Docker 和 uv 环境配置](DOCKER_SETUP.md)
3. 咨询项目维护者
4. Git官方文档：https://git-scm.com/doc
