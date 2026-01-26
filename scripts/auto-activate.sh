#!/bin/bash
# Bash/Zsh 自动激活虚拟环境脚本
# 将此脚本添加到 .bashrc 或 .zshrc 中

# 获取脚本所在目录的父目录（项目根目录）
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENV_PATH="$PROJECT_ROOT/.venv"

# 检查虚拟环境是否存在
if [ -d "$VENV_PATH" ] && [ -f "$VENV_PATH/bin/activate" ]; then
    echo "激活虚拟环境: $VENV_PATH"
    source "$VENV_PATH/bin/activate"
else
    echo "虚拟环境不存在，运行 'uv sync' 创建虚拟环境"
fi
