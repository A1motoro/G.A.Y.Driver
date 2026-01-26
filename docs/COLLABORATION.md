# GitHub 协作流程指南

> ⚠️ **重要提示**：本指南包含严格的协作规则，所有协作者必须严格遵守。如有疑问，请先咨询项目维护者。

## 目录

1. [环境准备](#环境准备)
2. [基础Git操作](#基础git操作)
3. [分支管理策略](#分支管理策略)
4. [提交流程（必须严格遵守）](#提交流程必须严格遵守)
5. [Pull Request流程](#pull-request流程)
6. [代码审查要求](#代码审查要求)
7. [常见错误和解决方案](#常见错误和解决方案)
8. [禁止事项](#禁止事项)

---

## 环境准备

### 1. 安装Git

**Windows用户：**
- 下载并安装 [Git for Windows](https://git-scm.com/download/win)
- 安装时选择默认选项即可
- 安装完成后，打开 PowerShell 或 Git Bash 验证：
  ```powershell
  git --version
  ```

**macOS用户：**
```bash
# 使用Homebrew安装
brew install git

# 或从官网下载：https://git-scm.com/download/mac
```

**Linux用户：**
```bash
# Ubuntu/Debian
sudo apt-get install git

# CentOS/RHEL
sudo yum install git
```

### 2. 配置Git用户信息

**⚠️ 必须配置，否则无法提交代码！**

```bash
# 设置用户名（使用你的真实姓名或GitHub用户名）
git config --global user.name "你的姓名"

# 设置邮箱（使用GitHub注册邮箱）
git config --global user.email "your.email@example.com"

# 验证配置
git config --global --list
```

### 3. 配置SSH密钥（推荐）或使用HTTPS

**方式一：SSH密钥（推荐）**

```bash
# 1. 生成SSH密钥
ssh-keygen -t ed25519 -C "your.email@example.com"
# 按回车使用默认路径，设置密码（可选）

# 2. 复制公钥内容
cat ~/.ssh/id_ed25519.pub
# Windows: type C:\Users\你的用户名\.ssh\id_ed25519.pub

# 3. 在GitHub上添加SSH密钥
# GitHub -> Settings -> SSH and GPG keys -> New SSH key
# 粘贴公钥内容并保存
```

**方式二：HTTPS（简单但需要输入密码）**

```bash
# 克隆仓库时使用HTTPS链接
git clone https://github.com/your-org/G.A.Y.Driver.git
```

---

## 基础Git操作

### 克隆仓库

```bash
# 使用SSH（推荐）
git clone git@github.com:your-org/G.A.Y.Driver.git

# 或使用HTTPS
git clone https://github.com/your-org/G.A.Y.Driver.git

# 进入项目目录
cd G.A.Y.Driver
```

### 查看仓库状态

```bash
# 查看当前状态（经常使用）
git status

# 查看提交历史
git log --oneline

# 查看当前分支
git branch
```

### 更新本地代码

**⚠️ 每次开始工作前，必须先更新代码！**

```bash
# 切换到main分支
git checkout main

# 拉取最新代码
git pull origin main
```

---

## 分支管理策略

### 分支命名规范

**⚠️ 严格遵循以下命名规则：**

- `main` - 主分支，**禁止直接提交**
- `develop` - 开发分支（如果存在）
- `feature/功能名称` - 功能开发分支
- `fix/问题描述` - Bug修复分支
- `docs/文档内容` - 文档更新分支

**示例：**
```bash
feature/traffic-light-detection
fix/crossroad-collision-bug
docs/api-documentation
```

### 创建和切换分支

```bash
# 1. 确保在main分支且代码是最新的
git checkout main
git pull origin main

# 2. 创建新分支并切换
git checkout -b feature/your-feature-name

# 3. 验证当前分支
git branch
# 当前分支前会有 * 标记
```

### 分支操作清单

**创建分支前必须：**
- [ ] 在main分支
- [ ] 代码已更新到最新（`git pull origin main`）
- [ ] 工作区干净（`git status` 显示 "working tree clean"）

---

## 提交流程（必须严格遵守）

### 提交前检查清单

**⚠️ 每次提交前必须完成以下检查：**

- [ ] 代码已测试，可以正常运行
- [ ] 没有添加临时文件、调试代码或注释掉的代码
- [ ] 没有提交敏感信息（API密钥、密码等）
- [ ] 提交信息清晰明确（见下方格式要求）
- [ ] 只提交相关文件（不要一次性提交大量无关文件）

### 查看更改

```bash
# 查看所有更改
git status

# 查看具体更改内容
git diff

# 查看已暂存的文件
git diff --staged
```

### 添加文件到暂存区

**⚠️ 不要使用 `git add .` 或 `git add *`，必须明确指定文件！**

```bash
# ✅ 正确：添加特定文件
git add src/traffic_detection.py
git add config/model_config.yaml

# ✅ 正确：添加整个目录（如果确定）
git add src/

# ❌ 错误：不要这样做
git add .
git add *
```

### 提交代码

**提交信息格式（必须严格遵守）：**

```
类型: 简短描述（50字以内）

详细描述（可选，超过50字时使用）
- 做了什么改动
- 为什么做这个改动
- 可能的影响
```

**提交类型：**
- `feat`: 新功能
- `fix`: Bug修复
- `docs`: 文档更新
- `style`: 代码格式调整（不影响功能）
- `refactor`: 代码重构
- `test`: 测试相关
- `chore`: 构建/工具相关

**示例：**
```bash
# 简单提交
git commit -m "feat: 添加路口检测功能"

# 详细提交
git commit -m "fix: 修复无红绿灯路口碰撞检测bug

- 修复了在复杂路口场景下的误检问题
- 优化了检测算法的时间复杂度
- 更新了相关测试用例"
```

### 推送代码到远程

```bash
# 首次推送新分支
git push -u origin feature/your-feature-name

# 后续推送（分支已存在）
git push
```

**⚠️ 推送前再次确认：**
- [ ] 提交信息正确
- [ ] 没有提交不应该提交的文件
- [ ] 代码可以正常运行

---

## Pull Request流程

### 创建Pull Request前的准备

**必须完成：**
- [ ] 代码已完成并通过测试
- [ ] 所有提交信息清晰
- [ ] 代码已推送到远程分支
- [ ] 本地代码已同步到最新

### 创建Pull Request步骤

1. **在GitHub网页上操作：**
   - 进入项目仓库页面
   - 点击 "Pull requests" 标签
   - 点击 "New pull request"
   - 选择你的分支（`feature/xxx`）合并到 `main`
   - 填写PR标题和描述

2. **PR标题格式：**
   ```
   类型: 简短描述
   ```
   示例：`feat: 添加无红绿灯路口检测功能`

3. **PR描述模板（必须包含）：**
   ```markdown
   ## 变更内容
   - 做了什么改动
   - 解决了什么问题
   
   ## 测试情况
   - 如何测试的
   - 测试结果
   
   ## 相关Issue
   - 关联的Issue编号（如有）
   
   ## 检查清单
   - [ ] 代码已测试
   - [ ] 文档已更新（如需要）
   - [ ] 没有引入新的警告或错误
   ```

### PR审查和合并

**⚠️ 重要规则：**
- **禁止**直接合并到main分支
- **必须**等待至少1位审查者批准
- **必须**解决所有审查意见后才能合并
- 合并后**必须**删除已合并的分支

**处理审查意见：**
```bash
# 1. 根据审查意见修改代码
# 2. 提交修改
git add 修改的文件
git commit -m "fix: 根据审查意见修改xxx"
git push

# 3. PR会自动更新，审查者会再次审查
```

---

## 代码审查要求

### 审查者检查项

- [ ] 代码符合项目规范
- [ ] 功能实现正确
- [ ] 没有明显的bug
- [ ] 代码注释清晰
- [ ] 提交信息规范
- [ ] 没有提交敏感信息
- [ ] 测试充分

### 被审查者注意事项

- 及时响应审查意见
- 礼貌地讨论技术问题
- 如果不同意审查意见，说明理由
- 修改后及时通知审查者

---

## 常见错误和解决方案

### 错误1：提交到了main分支

**问题：** 不小心在main分支提交了代码

**解决：**
```bash
# 1. 创建新分支保存当前更改
git checkout -b feature/your-feature-name

# 2. 切换回main并重置
git checkout main
git reset --hard origin/main

# 3. 在新分支继续工作
git checkout feature/your-feature-name
```

### 错误2：提交信息写错了

**问题：** 刚提交但还没推送，想修改提交信息

**解决：**
```bash
# 修改最后一次提交信息
git commit --amend -m "新的提交信息"

# 如果已经推送，需要强制推送（谨慎使用）
git push --force-with-lease
```

### 错误3：提交了不应该提交的文件

**问题：** 提交了临时文件、大文件或敏感信息

**解决：**
```bash
# 1. 从暂存区移除文件（但保留在工作区）
git reset HEAD 文件名

# 2. 添加到.gitignore
echo "文件名" >> .gitignore

# 3. 重新提交
git add .gitignore
git commit -m "chore: 更新.gitignore排除临时文件"

# 4. 如果已经推送，需要修改历史（复杂，建议咨询维护者）
```

### 错误4：本地代码和远程冲突

**问题：** `git push` 时提示冲突

**解决：**
```bash
# 1. 先拉取远程代码
git pull origin main

# 2. 解决冲突（编辑冲突文件）
# Git会标记冲突位置，手动解决后：

# 3. 标记冲突已解决
git add 冲突的文件

# 4. 完成合并
git commit -m "merge: 合并远程更改"

# 5. 推送
git push
```

### 错误5：想撤销本地更改

**问题：** 修改了文件但还没提交，想恢复

**解决：**
```bash
# 查看更改
git status

# 撤销单个文件的更改
git checkout -- 文件名

# 撤销所有未提交的更改（危险！）
git reset --hard HEAD
```

---

## 禁止事项

**⚠️ 以下操作严格禁止：**

1. ❌ **禁止**直接向main分支提交代码
2. ❌ **禁止**使用 `git push --force` 到main或develop分支
3. ❌ **禁止**提交大文件（>100MB）到仓库
4. ❌ **禁止**提交敏感信息（密码、API密钥等）
5. ❌ **禁止**提交临时文件、日志文件、编译产物
6. ❌ **禁止**使用无意义的提交信息（如"update"、"fix"、"test"）
7. ❌ **禁止**一次性提交大量无关文件
8. ❌ **禁止**绕过代码审查直接合并PR
9. ❌ **禁止**删除或修改他人的提交历史
10. ❌ **禁止**在未完成的功能分支上创建PR

---

## 快速参考命令

```bash
# 日常工作流程
git status                          # 查看状态
git checkout main                   # 切换到main分支
git pull origin main                # 更新代码
git checkout -b feature/xxx         # 创建新分支
git add 文件名                      # 添加文件
git commit -m "类型: 描述"          # 提交
git push -u origin feature/xxx      # 推送分支

# 查看信息
git log --oneline                   # 查看提交历史
git branch                          # 查看分支
git diff                            # 查看更改

# 撤销操作
git checkout -- 文件名             # 撤销文件更改
git reset HEAD 文件名              # 取消暂存
git commit --amend                  # 修改最后提交
```

---

## 获取帮助

如果遇到问题：

1. **查看本文档** - 大部分常见问题都有解答
2. **查看Git官方文档** - https://git-scm.com/doc
3. **咨询项目维护者** - 在项目Issue中提问或直接联系
4. **GitHub帮助中心** - https://docs.github.com/

---

**最后更新：** 2026-01-26
