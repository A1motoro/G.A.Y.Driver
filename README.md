# G.A.Y.Driver

基于 [Gymnasium](https://gymnasium.farama.org/) 与 [highway-env](https://github.com/Farama-Foundation/HighwayEnv) 的十字路口驾驶环境演示。

本文档按顺序说明：**安装 Git → 获取代码 → 安装 Python → 用 uv 配置虚拟环境并安装依赖 → 运行演示**。按你的操作系统展开对应小节即可。

---

## 1. 安装 Git

Git 用于克隆仓库、版本管理。若终端里已有 `git` 命令可跳过本节。

### Windows

任选一种方式：

1. **官方安装包（推荐）**  
   打开 [https://git-scm.com/download/win](https://git-scm.com/download/win)，下载并运行安装程序。安装时保留默认选项即可，务必勾选 **“Git from the command line and also from 3rd-party software”**，以便在 PowerShell / cmd 中使用 `git`。

2. **winget**（Windows 10/11 自带包管理器，可选）  
   在 PowerShell 中执行：

   ```powershell
   winget install Git.Git
   ```

安装完成后 **关闭并重新打开** PowerShell 或 cmd，执行 `git --version` 确认有版本号输出。

### macOS

任选一种方式：

1. **Xcode 命令行工具（推荐，自带 Git）**  
   打开「终端」，执行：

   ```bash
   xcode-select --install
   ```

   在弹窗中完成安装后，执行 `git --version` 确认。

2. **Homebrew**（若已安装 Homebrew）

   ```bash
   brew install git
   ```

---

## 2. 获取本仓库

在你要存放项目的目录下打开终端（Windows 可用 PowerShell），把下面 URL 换成你的真实仓库地址（HTTPS 或 SSH 均可）。

```bash
git clone <你的仓库地址>
cd G.A.Y.Driver
```

若代码已解压到本地文件夹，只需在终端中 `cd` 到项目根目录（包含 `pyproject.toml`、`uv.lock` 与 `src` 的那一层）。

---

## 3. 安装 Python

本项目需要 **Python 3.10 及以上**（建议 3.11 或 3.12）。终端执行 `python --version` 或 `python3 --version`，满足版本即可跳过本节。

### Windows

1. 打开 [https://www.python.org/downloads/windows/](https://www.python.org/downloads/windows/)，下载并安装最新 **Python 3.x**。
2. 安装向导中勾选 **“Add python.exe to PATH”**（将 Python 加入 PATH），再点安装完成。
3. 新开 PowerShell，执行 `python --version` 确认。

### macOS

1. 官方安装包： [https://www.python.org/downloads/macos/](https://www.python.org/downloads/macos/)  
2. 或使用 Homebrew：`brew install python`  
3. 终端执行 `python3 --version` 确认。

下文 **Windows** 示例一律用 `python`；**macOS** 若只有 `python3` 命令，请把下文中的 `python` 换成 `python3`。依赖版本由 [uv](https://docs.astral.sh/uv/) 根据 `pyproject.toml` 与 `uv.lock` 解析；uv 会使用系统已安装的 Python（也可使用 `uv python install 3.12` 等命令由 uv 安装解释器，见官方文档）。

---

## 4. 使用 uv 管理虚拟环境与依赖

虚拟环境把项目依赖与系统 Python 隔离，避免版本冲突。以下命令均在项目根目录 `G.A.Y.Driver` 下执行。

### 安装 uv

若终端中 `uv --version` 已有输出可跳过本节。

**Windows（PowerShell）**

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

也可使用：`winget install astral-sh.uv`（具体包名以 winget 源为准）。

**macOS / Linux**

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

安装完成后 **关闭并重新打开**终端，执行 `uv --version` 确认。

### 同步环境（推荐）

在项目根目录执行：

```bash
uv sync
```

若尚未存在 `.venv`，uv 会创建它，并按 `uv.lock` 安装依赖。修改 `pyproject.toml` 中的依赖后，可执行 `uv lock` 再 `uv sync` 以更新锁文件与环境。

仅创建空的 `.venv`、暂不安装依赖：`uv venv`

### 激活虚拟环境（可选）

希望在当前 shell 里直接使用 `python`、`pip` 时，激活方式与标准 venv 相同。

**Windows（PowerShell）**

```powershell
.\.venv\Scripts\Activate.ps1
```

若提示无法加载脚本，可先允许当前用户执行本地脚本（仅需一次）：

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

再重新执行 `.\.venv\Scripts\Activate.ps1`。

**Windows（cmd）**

```cmd
.venv\Scripts\activate.bat
```

**macOS / Linux**

```bash
source .venv/bin/activate
```

激活成功后，提示符前会出现 `(.venv)`。退出虚拟环境：`deactivate`

不激活时可直接使用下一节的 `uv run`，由 uv 自动选用项目环境。

### 不使用 uv 时（备选）

若暂时不用 uv，可自行 `python -m venv .venv`并激活后安装依赖：

```bash
python -m pip install -U pip
python -m pip install gymnasium highway-env pygame
```

---

## 5. 运行演示

**推荐：无需先手动激活环境**

**Windows（PowerShell 或 cmd）**

```powershell
uv run python src\gay_driver\demo_intersection.py
```

**macOS / Linux**

```bash
uv run python src/gay_driver/demo_intersection.py
```

若已按第 4 节激活 `.venv`，也可直接：

```bash
python src/gay_driver/demo_intersection.py
```

（Windows 下路径为 `src\gay_driver\demo_intersection.py`。）

会弹出窗口渲染 `intersection-v0`；动作为随机采样，用于验证环境是否正常。

- **macOS**：首次用 pygame 弹窗时，若系统拦截，请到 **系统设置 → 隐私与安全性** 中为终端或 Python 开放 **屏幕录制**（或相关显示权限，依系统版本文案为准）。

---

## 依赖说明

| 包名        | 用途              |
| ----------- | ----------------- |
| gymnasium   | 强化学习环境接口  |
| highway-env | 公路 / 路口场景   |
| pygame      | highway-env 可视化 |

---

## 常见问题（简要）

- **`git` 不是内部或外部命令**（Windows）：重新安装 Git 并勾选加入 PATH，或重启终端。  
- **`python` 找不到**：确认已安装 Python 并勾选 PATH；macOS 优先使用 `python3`。  
- **同步依赖很慢**：可为 uv 指定默认索引（清华源示例，任选其一镜像即可）。**macOS / Linux**：  
  `UV_DEFAULT_INDEX=https://pypi.tuna.tsinghua.edu.cn/simple uv sync` **Windows PowerShell**：  
  `$env:UV_DEFAULT_INDEX="https://pypi.tuna.tsinghua.edu.cn/simple"; uv sync`  
  不使用 uv 时仍可用：`python -m pip install gymnasium highway-env pygame -i https://pypi.tuna.tsinghua.edu.cn/simple`

- **Windows 安装依赖时报错：`ModuleNotFoundError: No module named 'setuptools._distutils.msvccompiler'`，且与 `pygame` 构建失败有关**  
  **原因简述：** pip 在为 **pygame** 走「源码编译」路径时，会用到 setuptools 里与 MSVC 相关的旧接口；若当前 Python 版本 **没有对应的 pygame 预编译轮子（wheel）**，就会触发该路径。把 **setuptools 强行降到 60 以下** 往往与 **Python 3.12+** 等环境不兼容，反而容易加剧问题。  
  **推荐处理顺序：**  
  1. 使用 **官网 64 位** [Python 3.11 或 3.12](https://www.python.org/downloads/windows/)（尽量不要用 32 位或过新的实验版本，以免没有 pygame 轮子）。  
  2. 在项目根目录用 uv 同步依赖：`uv sync`；若不用 uv，可先 `python -m pip install -U pip setuptools wheel` 再 `python -m pip install gymnasium highway-env pygame`。  
  3. 若仍尝试编译源码，可先只装 pygame 并强制仅用二进制包（无轮子时会直接报错，便于确认是版本问题）：在已激活的 `.venv` 中执行 `uv pip install pygame --only-binary pygame`，或 `python -m pip install pygame --only-binary pygame`。  
  4. 仅在确有轮子却仍走编译时，再检查 pip 版本与镜像是否过旧；**不推荐**为修 pygame 长期锁死过旧的 setuptools。  
  5. 若必须源码编译 pygame，需安装 **Visual Studio Build Tools** 并勾选 **“使用 C++ 的桌面开发”**，成本高，一般应用 **1 + 2** 即可避免。
