# G.A.Y.Driver - UV PATH 配置脚本
# 此脚本用于在 IDE 集成终端中临时添加 uv 到 PATH

$uvPath = "C:\Users\Almoo\.local\bin"

# 检查 uv 是否存在
if (Test-Path "$uvPath\uv.exe") {
    # 添加到当前会话的 PATH
    if ($env:PATH -notlike "*$uvPath*") {
        $env:PATH = "$uvPath;$env:PATH"
        Write-Host "✅ 已将 uv 添加到当前会话的 PATH" -ForegroundColor Green
    } else {
        Write-Host "ℹ️  uv 已在 PATH 中" -ForegroundColor Cyan
    }
    
    # 验证 uv 是否可用
    $uvVersion = & "$uvPath\uv.exe" --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ uv 可用: $uvVersion" -ForegroundColor Green
    }
} else {
    Write-Host "❌ 未找到 uv.exe 在 $uvPath" -ForegroundColor Red
    Write-Host "请检查 uv 的安装位置" -ForegroundColor Yellow
}
