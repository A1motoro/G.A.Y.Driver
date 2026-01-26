#!/bin/bash
# Docker 构建脚本

set -e

echo "🔨 构建 G.A.Y.Driver Docker 镜像..."

docker build -t gay-driver:latest .

echo "✅ 构建完成！"
echo ""
echo "运行容器:"
echo "  docker run -it --rm gay-driver:latest"
echo ""
echo "或使用 docker-compose:"
echo "  docker-compose up"
