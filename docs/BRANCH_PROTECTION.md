# GitHub 分支保护配置指南

> ⚠️ **重要**：本文档说明如何在GitHub上配置分支保护规则，确保代码质量和协作规范。
>

本文档一般不需要阅读，这是仓库管理员手册。

## 目录

1. [分支保护概述](#分支保护概述)
2. [GitHub Settings 配置步骤](#github-settings-配置步骤)
3. [推荐的分支保护规则](#推荐的分支保护规则)
4. [配置检查清单](#配置检查清单)
5. [常见问题](#常见问题)

---

## 分支保护概述

分支保护规则可以：
- ✅ 防止直接推送到受保护的分支（如 `main`）
- ✅ 要求Pull Request审查后才能合并
- ✅ 要求状态检查通过（CI/CD）
- ✅ 要求分支保持最新
- ✅ 防止强制推送和删除分支
- ✅ 要求线性提交历史

---

## GitHub Settings 配置步骤

### 步骤1：进入分支保护设置

1. 打开项目仓库页面
2. 点击右上角的 **Settings**（设置）
3. 在左侧菜单中找到 **Branches**（分支）
4. 点击进入分支设置页面

### 步骤2：添加分支保护规则

1. 在 **Branch protection rules**（分支保护规则）区域
2. 点击 **Add rule**（添加规则）或 **Add branch protection rule**（添加分支保护规则）

### 步骤3：配置规则名称

在 **Branch name pattern**（分支名称模式）中输入：
```
main
```

**说明：**
- 输入 `main` 保护主分支
- 也可以输入 `*` 保护所有分支
- 或使用模式如 `main`、`develop` 等

### 步骤4：配置保护选项

根据下面的推荐配置，勾选相应的选项。

---

## 推荐的分支保护规则

### 🔒 基础保护（必须配置）

#### 1. Require a pull request before merging（合并前需要Pull Request）

**必须勾选：**
- ✅ **Require a pull request before merging**

**子选项配置：**
- ✅ **Require approvals**（需要批准）
  - 设置 **Required number of approvals**（所需批准数量）：`1` 或 `2`
  - ✅ **Dismiss stale pull request approvals when new commits are pushed**（推送新提交时撤销过时的批准）
  - ✅ **Require review from Code Owners**（需要代码所有者审查）- 如果配置了CODEOWNERS文件

#### 2. Require status checks to pass before merging（合并前需要通过状态检查）

**如果项目有CI/CD，必须勾选：**
- ✅ **Require status checks to pass before merging**
- ✅ **Require branches to be up to date before merging**（合并前要求分支保持最新）

**配置状态检查：**
- 在 **Status checks that are required** 中，选择需要通过的检查项
- 例如：`lint`、`test`、`build` 等

#### 3. Require conversation resolution before merging（合并前需要解决所有对话）

**必须勾选：**
- ✅ **Require conversation resolution before merging**

**说明：** 确保PR中的所有评论和问题都已解决

#### 4. Require linear history（要求线性历史）

**推荐勾选：**
- ✅ **Require linear history**

**说明：** 禁止合并提交，保持提交历史清晰

### 🛡️ 高级保护（强烈推荐）

#### 5. Include administrators（包括管理员）

**必须勾选：**
- ✅ **Include administrators**

**说明：** 即使是仓库管理员也必须遵守这些规则

#### 6. Do not allow bypassing the above settings（不允许绕过上述设置）

**必须勾选：**
- ✅ **Do not allow bypassing the above settings**

**说明：** 防止任何人（包括管理员）绕过保护规则

### 🚫 限制操作（推荐配置）

#### 7. Restrict who can push to matching branches（限制可推送的人员）

**可选配置：**
- 如果团队较小，可以不勾选
- 如果团队较大，可以限制只有特定人员可以推送

#### 8. Allow force pushes（允许强制推送）

**必须不勾选：**
- ❌ **Allow force pushes**

**说明：** 禁止强制推送，防止历史被改写

#### 9. Allow deletions（允许删除）

**必须不勾选：**
- ❌ **Allow deletions**

**说明：** 防止受保护的分支被意外删除

---

## 配置检查清单

在GitHub Settings中配置完成后，请确认以下所有项：

### 基础保护
- [ ] ✅ Require a pull request before merging
  - [ ] ✅ Require approvals（设置为1或2）
  - [ ] ✅ Dismiss stale approvals
  - [ ] ✅ Require review from Code Owners（如适用）
- [ ] ✅ Require status checks（如项目有CI/CD）
  - [ ] ✅ Require branches to be up to date
- [ ] ✅ Require conversation resolution
- [ ] ✅ Require linear history

### 高级保护
- [ ] ✅ Include administrators
- [ ] ✅ Do not allow bypassing

### 限制操作
- [ ] ❌ Allow force pushes（必须关闭）
- [ ] ❌ Allow deletions（必须关闭）

---

## 完整配置示例

### 最小配置（适合小团队）

```
Branch name pattern: main

✅ Require a pull request before merging
  ✅ Require approvals: 1
  ✅ Dismiss stale approvals
✅ Require conversation resolution
✅ Include administrators
✅ Do not allow bypassing
❌ Allow force pushes
❌ Allow deletions
```

### 标准配置（推荐）

```
Branch name pattern: main

✅ Require a pull request before merging
  ✅ Require approvals: 1
  ✅ Dismiss stale approvals
✅ Require status checks to pass
  ✅ Require branches to be up to date
✅ Require conversation resolution
✅ Require linear history
✅ Include administrators
✅ Do not allow bypassing
❌ Allow force pushes
❌ Allow deletions
```

### 严格配置（适合大型项目）

```
Branch name pattern: main

✅ Require a pull request before merging
  ✅ Require approvals: 2
  ✅ Dismiss stale approvals
  ✅ Require review from Code Owners
✅ Require status checks to pass
  ✅ Require branches to be up to date
✅ Require conversation resolution
✅ Require linear history
✅ Include administrators
✅ Do not allow bypassing
✅ Restrict who can push（限制特定人员）
❌ Allow force pushes
❌ Allow deletions
```

---

## 配置后的效果

配置完成后，以下操作将被禁止或受限：

### ✅ 允许的操作
- 在功能分支上自由提交和推送
- 创建Pull Request
- 审查和批准PR
- 合并已批准的PR

### ❌ 禁止的操作
- 直接推送到 `main` 分支
- 强制推送到 `main` 分支
- 删除 `main` 分支
- 绕过PR审查直接合并
- 在未通过状态检查时合并
- 在未解决所有对话时合并

---

## 常见问题

### Q1: 配置后无法直接推送到main分支怎么办？

**A:** 这是正常的！分支保护规则的目的就是防止直接推送。正确的流程是：
1. 在功能分支工作
2. 创建Pull Request
3. 等待审查和批准
4. 合并PR

### Q2: 如何临时绕过保护规则？

**A:** 如果配置了 "Do not allow bypassing"，即使是管理员也无法绕过。这是为了确保代码质量。如果确实需要紧急修复，可以：
1. 联系仓库管理员临时修改规则（不推荐）
2. 使用正常的PR流程（推荐）

### Q3: 状态检查一直失败怎么办？

**A:** 
1. 检查CI/CD配置是否正确
2. 确保本地代码可以通过所有检查
3. 查看CI/CD日志找出问题
4. 修复问题后重新推送

### Q4: 如何为多个分支配置保护？

**A:** 
1. 为 `main` 创建规则：输入 `main`
2. 为 `develop` 创建规则：输入 `develop`
3. 或使用通配符：输入 `main` 和 `develop` 分别创建规则

### Q5: 如何查看当前的分支保护规则？

**A:**
1. 进入 Settings → Branches
2. 在 Branch protection rules 区域查看所有已配置的规则
3. 点击规则名称可以查看和编辑详细配置

---

## 验证配置

配置完成后，可以测试验证：

1. **测试直接推送（应该失败）：**
   ```bash
   git checkout main
   # 尝试直接推送，应该被拒绝
   git push origin main
   # 预期：错误，提示需要PR
   ```

2. **测试PR流程（应该成功）：**
   ```bash
   git checkout -b test/protection
   # 做一些更改
   git commit -m "test: 测试分支保护"
   git push -u origin test/protection
   # 在GitHub上创建PR，应该可以正常创建和合并
   ```

---

## 维护者操作指南

### 查看保护规则

1. Settings → Branches
2. 查看所有已配置的规则
3. 点击规则名称查看详情

### 修改保护规则

1. Settings → Branches
2. 点击要修改的规则名称
3. 修改配置
4. 点击 **Save changes**

### 删除保护规则

1. Settings → Branches
2. 找到要删除的规则
3. 点击规则右侧的删除按钮
4. 确认删除

---

## 相关文档

- [GitHub官方文档 - 分支保护规则](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [协作流程指南](COLLABORATION.md)
- [快速参考](QUICK_REFERENCE.md)

---

**最后更新：** 2026-01-26
