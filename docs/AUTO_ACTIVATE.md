# 自动激活虚拟环境配置指南

本指南说明如何配置终端，使其在进入项目目录时自动激活虚拟环境。

## 快速配置（推荐）

### Windows PowerShell

```powershell
# 1. 运行配置脚本
.\scripts\setup-auto-activate.ps1

# 2. 重新加载 PowerShell 配置
. $PROFILE

# 3. 测试：进入项目目录
cd D:\Tide\G.A.Y.Driver
# 虚拟环境应该自动激活，提示符会显示 (.venv)
```

### Linux/macOS (Bash/Zsh)

```bash
# 1. 运行配置脚本
chmod +x scripts/setup-auto-activate.sh
./scripts/setup-auto-activate.sh

# 2. 重新加载配置
source ~/.bashrc  # 或 source ~/.zshrc

# 3. 测试：进入项目目录
cd /path/to/G.A.Y.Driver
# 虚拟环境应该自动激活，提示符会显示 (.venv)
```

## 工作原理

配置脚本会：
1. 检测你的 shell 类型（PowerShell/Bash/Zsh）
2. 找到对应的配置文件（`$PROFILE` / `~/.bashrc` / `~/.zshrc`）
3. 添加自动激活脚本的引用
4. 当你进入项目目录时，脚本会自动检测并激活虚拟环境

## 功能特性

- ✅ **自动激活**：进入项目目录时自动激活 `.venv`
- ✅ **自动停用**：离开项目目录时自动停用
- ✅ **子目录支持**：在项目任何子目录中都会激活
- ✅ **智能检测**：不会重复激活已激活的环境
- ✅ **跨平台**：支持 Windows、Linux、macOS

## 验证配置

### PowerShell

```powershell
# 1. 检查配置文件是否包含自动激活脚本
Get-Content $PROFILE | Select-String "G.A.Y.Driver"

# 2. 进入项目目录测试
cd D:\Tide\G.A.Y.Driver
# 应该看到提示符显示 (.venv)

# 3. 检查虚拟环境是否激活
python --version
# 应该显示虚拟环境中的 Python 版本
```

### Bash/Zsh

```bash
# 1. 检查配置文件
grep "G.A.Y.Driver" ~/.bashrc  # 或 ~/.zshrc

# 2. 进入项目目录测试
cd /path/to/G.A.Y.Driver
# 应该看到提示符显示 (.venv)

# 3. 检查虚拟环境是否激活
python --version
which python
# 应该指向 .venv/bin/python
```

## 手动配置

如果自动配置脚本不工作，可以手动配置：

### PowerShell

1. **打开配置文件**：
   ```powershell
   notepad $PROFILE
   # 或
   code $PROFILE
   ```

2. **添加以下内容**（替换为实际项目路径）：
   ```powershell
   # G.A.Y.Driver - Auto-activate virtual environment
   if (Test-Path "D:\Tide\G.A.Y.Driver\scripts\auto-activate.ps1") {
       . "D:\Tide\G.A.Y.Driver\scripts\auto-activate.ps1"
   }
   ```

3. **保存并重新加载**：
   ```powershell
   . $PROFILE
   ```

### Bash

1. **编辑配置文件**：
   ```bash
   nano ~/.bashrc
   # 或
   vim ~/.bashrc
   ```

2. **添加以下内容**（替换为实际项目路径）：
   ```bash
   # G.A.Y.Driver - Auto-activate virtual environment
   if [[ -f "/path/to/G.A.Y.Driver/scripts/auto-activate.sh" ]]; then
       source "/path/to/G.A.Y.Driver/scripts/auto-activate.sh"
   fi
   ```

3. **保存并重新加载**：
   ```bash
   source ~/.bashrc
   ```

### Zsh

1. **编辑配置文件**：
   ```bash
   nano ~/.zshrc
   # 或
   vim ~/.zshrc
   ```

2. **添加以下内容**（替换为实际项目路径）：
   ```bash
   # G.A.Y.Driver - Auto-activate virtual environment
   if [[ -f "/path/to/G.A.Y.Driver/scripts/auto-activate.sh" ]]; then
       source "/path/to/G.A.Y.Driver/scripts/auto-activate.sh"
   fi
   ```

3. **保存并重新加载**：
   ```bash
   source ~/.zshrc
   ```

## 故障排除

### 问题 1：配置后没有自动激活

**可能原因**：
- 配置文件路径不正确
- 虚拟环境 `.venv` 不存在
- 脚本路径错误

**解决方案**：
1. 检查虚拟环境是否存在：
   ```powershell
   # PowerShell
   Test-Path .venv\Scripts\activate.ps1
   ```
   ```bash
   # Bash/Zsh
   test -f .venv/bin/activate
   ```

2. 检查脚本路径是否正确：
   ```powershell
   # PowerShell
   Test-Path scripts\auto-activate.ps1
   ```
   ```bash
   # Bash/Zsh
   test -f scripts/auto-activate.sh
   ```

3. 手动测试脚本：
   ```powershell
   # PowerShell
   . scripts\auto-activate.ps1
   ```
   ```bash
   # Bash/Zsh
   source scripts/auto-activate.sh
   ```

### 问题 2：提示符显示异常

**可能原因**：覆盖了原有的 prompt 函数

**解决方案**：
- 检查是否有其他工具也修改了 prompt
- 可以编辑 `scripts/auto-activate.ps1` 调整 prompt 函数

### 问题 3：IDE 终端不工作

**可能原因**：IDE 终端可能使用不同的配置

**解决方案**：
- 某些 IDE（如 VSCode）可能需要重启才能加载新的配置
- 或者直接在 IDE 设置中配置终端启动命令

## 禁用自动激活

如果不想使用自动激活功能：

### PowerShell

编辑 `$PROFILE`，注释掉或删除相关行：
```powershell
# if (Test-Path "D:\Tide\G.A.Y.Driver\scripts\auto-activate.ps1") {
#     . "D:\Tide\G.A.Y.Driver\scripts\auto-activate.ps1"
# }
```

### Bash/Zsh

编辑 `~/.bashrc` 或 `~/.zshrc`，注释掉或删除相关行：
```bash
# if [[ -f "/path/to/G.A.Y.Driver/scripts/auto-activate.sh" ]]; then
#     source "/path/to/G.A.Y.Driver/scripts/auto-activate.sh"
# fi
```

然后重新加载配置。

## 注意事项

1. **首次配置**：需要先创建虚拟环境（运行 `uv sync --dev`）
2. **多项目**：如果多个项目都配置了自动激活，可能会冲突
3. **性能**：自动激活会在每次命令执行时检查，对性能影响极小
4. **兼容性**：与大多数终端工具兼容，但可能与某些自定义 prompt 冲突

## 相关文档

- [虚拟环境配置指南](VENV_SETUP.md)
- [Docker 和 uv 环境配置](DOCKER_SETUP.md)
