# PowerShell 自动激活虚拟环境配置脚本
# 运行此脚本以配置 PowerShell 启动时自动激活虚拟环境

Write-Host "配置 PowerShell 自动激活虚拟环境..." -ForegroundColor Cyan

# 获取项目根目录
$projectRoot = Split-Path -Parent $PSScriptRoot
$venvPath = Join-Path $projectRoot ".venv"
$activateScript = Join-Path $venvPath "Scripts" "Activate.ps1"

# 检查虚拟环境是否存在
if (-not (Test-Path $activateScript)) {
    Write-Host "虚拟环境不存在，正在创建..." -ForegroundColor Yellow
    Set-Location $projectRoot
    uv sync
}

# 获取 PowerShell 配置文件路径
$profilePath = $PROFILE

# 检查配置文件是否存在
if (-not (Test-Path $profilePath)) {
    Write-Host "创建 PowerShell 配置文件: $profilePath" -ForegroundColor Yellow
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

# 检查是否已经配置过
$autoActivateCode = @"
# G.A.Y.Driver 自动激活虚拟环境
`$projectRoot = "$projectRoot"
`$venvPath = Join-Path `$projectRoot ".venv"
`$activateScript = Join-Path `$venvPath "Scripts" "Activate.ps1"

if (Test-Path `$activateScript) {
    if (`$PWD.Path -like "`$projectRoot*") {
        Write-Host "激活虚拟环境: `$venvPath" -ForegroundColor Green
        & `$activateScript
    }
}
"@

$profileContent = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue

if ($profileContent -notlike "*G.A.Y.Driver 自动激活虚拟环境*") {
    Write-Host "添加自动激活配置到 PowerShell 配置文件..." -ForegroundColor Green
    Add-Content -Path $profilePath -Value "`n$autoActivateCode"
    Write-Host "✅ 配置完成！" -ForegroundColor Green
    Write-Host ""
    Write-Host "重新打开 PowerShell 或运行以下命令使配置生效:" -ForegroundColor Yellow
    Write-Host "  . `$PROFILE" -ForegroundColor Cyan
} else {
    Write-Host "⚠️  配置已存在，跳过添加" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "提示: 只有在项目目录及其子目录中才会自动激活虚拟环境" -ForegroundColor Gray
