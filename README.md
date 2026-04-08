# G.A.Y.Driver

基于 [Gymnasium](https://gymnasium.farama.org/) 与 [highway-env](https://github.com/Farama-Foundation/HighwayEnv) 的十字路口驾驶环境演示。

## 环境要求

- Python 3.10+（建议 3.11 或 3.12，与当前依赖兼容即可）

## 配置虚拟环境（Windows）

### 使用内置 venv（推荐）

在项目根目录 `G.A.Y.Driver` 下执行：

```powershell
# 创建虚拟环境（目录名可自定，常用 .venv）
python -m venv .venv

# 激活虚拟环境（PowerShell）
.\.venv\Scripts\Activate.ps1
```

若 PowerShell 禁止运行脚本，可先执行（当前用户）：

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

使用 **命令提示符 (cmd)** 时激活方式为：

```cmd
.venv\Scripts\activate.bat
```

激活后，提示符前会出现 `(.venv)`。

### 安装依赖

仍在项目根目录，且虚拟环境已激活：

```powershell
python -m pip install -U pip
python -m pip install -r requirements.txt
```

### 退出虚拟环境

```powershell
deactivate
```

## 运行演示

确保已激活虚拟环境并安装好依赖：

```powershell
python src\gay_driver\demo_intersection.py
```

会弹出窗口渲染 `intersection-v0` 场景；智能体动作为随机采样，用于验证环境是否正常工作。

## 依赖说明

| 包名         | 用途           |
| ------------ | -------------- |
| gymnasium    | RL 环境标准接口 |
| highway-env  | 公路/路口场景  |
| pygame       | highway-env 可视化 |
