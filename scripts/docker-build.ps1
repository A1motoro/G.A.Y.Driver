# Docker 构建脚本 (PowerShell)

Write-Host "🔨 构建 G.A.Y.Driver Docker 镜像..." -ForegroundColor Cyan

docker build -t gay-driver:latest .

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 构建完成！" -ForegroundColor Green
    Write-Host ""
    Write-Host "运行容器:" -ForegroundColor Yellow
    Write-Host "  docker run -it --rm gay-driver:latest"
    Write-Host ""
    Write-Host "或使用 docker-compose:" -ForegroundColor Yellow
    Write-Host "  docker-compose up"
} else {
    Write-Host "❌ 构建失败！" -ForegroundColor Red
    exit 1
}
