# 终端自动激活虚拟环境配置指南

## 概述

配置终端在进入项目目录时自动激活虚拟环境，无需每次手动运行 `source .venv/bin/activate` 或 `.venv\Scripts\activate`。

## 快速配置

### Windows PowerShell

1. **运行配置脚本（推荐）:**
   ```powershell
   .\scripts\setup-auto-activate.ps1
   ```

2. **重新加载配置:**
   ```powershell
   . $PROFILE
   ```
   或者直接重新打开 PowerShell。

### Linux/macOS (Bash/Zsh)

1. **运行配置脚本（推荐）:**
   ```bash
   chmod +x scripts/setup-auto-activate.sh
   ./scripts/setup-auto-activate.sh
   ```

2. **重新加载配置:**
   ```bash
   source ~/.bashrc  # Bash
   # 或
   source ~/.zshrc   # Zsh
   ```
   或者直接重新打开终端。

## 手动配置

如果自动配置脚本不工作，可以手动配置：

### Windows PowerShell

1. **打开 PowerShell 配置文件:**
   ```powershell
   notepad $PROFILE
   ```
   如果文件不存在，PowerShell 会提示创建。

2. **添加以下内容到配置文件末尾:**
   ```powershell
   # G.A.Y.Driver 自动激活虚拟环境
   $projectRoot = "D:\Tide\G.A.Y.Driver"  # 替换为你的项目路径
   $venvPath = Join-Path $projectRoot ".venv"
   $activateScript = Join-Path $venvPath "Scripts" "Activate.ps1"
   
   if (Test-Path $activateScript) {
       if ($PWD.Path -like "$projectRoot*") {
           Write-Host "激活虚拟环境: $venvPath" -ForegroundColor Green
           & $activateScript
       }
   }
   ```

3. **保存并重新加载:**
   ```powershell
   . $PROFILE
   ```

### Linux/macOS Bash

1. **编辑 `.bashrc` 文件:**
   ```bash
   nano ~/.bashrc
   # 或
   vim ~/.bashrc
   ```

2. **添加以下内容到文件末尾:**
   ```bash
   # G.A.Y.Driver 自动激活虚拟环境
   PROJECT_ROOT="/path/to/G.A.Y.Driver"  # 替换为你的项目路径
   VENV_PATH="$PROJECT_ROOT/.venv"
   
   if [ -d "$VENV_PATH" ] && [ -f "$VENV_PATH/bin/activate" ]; then
       if [[ "$PWD" == "$PROJECT_ROOT"* ]]; then
           echo "激活虚拟环境: $VENV_PATH"
           source "$VENV_PATH/bin/activate"
       fi
   fi
   ```

3. **保存并重新加载:**
   ```bash
   source ~/.bashrc
   ```

### Linux/macOS Zsh

1. **编辑 `.zshrc` 文件:**
   ```bash
   nano ~/.zshrc
   # 或
   vim ~/.zshrc
   ```

2. **添加以下内容到文件末尾:**
   ```bash
   # G.A.Y.Driver 自动激活虚拟环境
   PROJECT_ROOT="/path/to/G.A.Y.Driver"  # 替换为你的项目路径
   VENV_PATH="$PROJECT_ROOT/.venv"
   
   if [ -d "$VENV_PATH" ] && [ -f "$VENV_PATH/bin/activate" ]; then
       if [[ "$PWD" == "$PROJECT_ROOT"* ]]; then
           echo "激活虚拟环境: $VENV_PATH"
           source "$VENV_PATH/bin/activate"
       fi
   fi
   ```

3. **保存并重新加载:**
   ```bash
   source ~/.zshrc
   ```

## 工作原理

配置脚本会：

1. **检查虚拟环境是否存在** - 如果不存在，会自动运行 `uv sync` 创建
2. **检测当前目录** - 只有在项目目录及其子目录中才会激活虚拟环境
3. **自动激活** - 当满足条件时，自动运行激活脚本

## 验证配置

配置完成后，打开新的终端窗口，进入项目目录：

```bash
cd /path/to/G.A.Y.Driver  # 或 Windows: cd D:\Tide\G.A.Y.Driver
```

你应该看到类似以下的提示：
```
激活虚拟环境: /path/to/G.A.Y.Driver/.venv
(.venv) user@hostname:~/G.A.Y.Driver$
```

提示符前会出现 `(.venv)`，表示虚拟环境已激活。

## 禁用自动激活

如果不想使用自动激活功能：

### Windows PowerShell

编辑 `$PROFILE`，注释掉或删除添加的配置代码。

### Linux/macOS

编辑 `~/.bashrc` 或 `~/.zshrc`，注释掉或删除添加的配置代码：

```bash
# # G.A.Y.Driver 自动激活虚拟环境
# PROJECT_ROOT="..."
```

然后重新加载配置文件。

## 故障排除

### 问题：配置后没有自动激活

**可能原因：**
1. 虚拟环境不存在 - 运行 `uv sync` 创建虚拟环境
2. 配置文件路径错误 - 检查项目路径是否正确
3. 配置文件未重新加载 - 重新打开终端或运行 `source ~/.bashrc`

**解决方法：**
```bash
# 确保虚拟环境存在
uv sync

# 检查配置文件
cat ~/.bashrc | grep "G.A.Y.Driver"  # Linux/macOS
Get-Content $PROFILE | Select-String "G.A.Y.Driver"  # Windows
```

### 问题：每次打开终端都激活，即使不在项目目录

**可能原因：** 配置脚本中的路径检查逻辑有问题。

**解决方法：** 检查配置中的路径匹配逻辑，确保使用了正确的条件判断。

### 问题：PowerShell 执行策略限制

**错误信息：** `无法加载文件，因为在此系统上禁止运行脚本`

**解决方法：**
```powershell
# 以管理员身份运行 PowerShell，然后执行：
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## 最佳实践

1. **使用配置脚本** - 推荐使用提供的配置脚本，它会自动检测路径和 shell 类型
2. **路径检查** - 配置只在项目目录中激活，避免在其他项目中误激活
3. **虚拟环境检查** - 配置会检查虚拟环境是否存在，避免错误
4. **可选择性** - 如果不需要自动激活，可以随时禁用

## 相关文档

- [uv 官方文档](https://github.com/astral-sh/uv)
- [PowerShell 配置文件文档](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_profiles)
- [Bash 配置文件文档](https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html)
