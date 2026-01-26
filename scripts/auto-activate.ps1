# PowerShell 自动激活虚拟环境脚本
# 将此脚本添加到 PowerShell 配置文件中

$venvPath = Join-Path $PSScriptRoot ".." ".venv"
$activateScript = Join-Path $venvPath "Scripts" "Activate.ps1"

if (Test-Path $activateScript) {
    Write-Host "激活虚拟环境: $venvPath" -ForegroundColor Green
    & $activateScript
} else {
    Write-Host "虚拟环境不存在，运行 'uv sync' 创建虚拟环境" -ForegroundColor Yellow
}
