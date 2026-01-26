#!/bin/bash
# Bash/Zsh 自动激活虚拟环境配置脚本
# 运行此脚本以配置 shell 启动时自动激活虚拟环境

echo "配置 Shell 自动激活虚拟环境..."

# 获取项目根目录
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENV_PATH="$PROJECT_ROOT/.venv"

# 检查虚拟环境是否存在
if [ ! -d "$VENV_PATH" ] || [ ! -f "$VENV_PATH/bin/activate" ]; then
    echo "虚拟环境不存在，正在创建..."
    cd "$PROJECT_ROOT"
    uv sync
fi

# 检测使用的 shell
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
    SHELL_NAME="zsh"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_RC="$HOME/.bashrc"
    SHELL_NAME="bash"
else
    echo "不支持的 shell，请手动配置"
    exit 1
fi

# 检查配置文件是否存在
if [ ! -f "$SHELL_RC" ]; then
    echo "创建 $SHELL_RC 配置文件..."
    touch "$SHELL_RC"
fi

# 检查是否已经配置过
if grep -q "G.A.Y.Driver 自动激活虚拟环境" "$SHELL_RC" 2>/dev/null; then
    echo "⚠️  配置已存在，跳过添加"
else
    echo "添加自动激活配置到 $SHELL_RC..."
    
    cat >> "$SHELL_RC" << EOF

# G.A.Y.Driver 自动激活虚拟环境
PROJECT_ROOT="$PROJECT_ROOT"
VENV_PATH="\$PROJECT_ROOT/.venv"

if [ -d "\$VENV_PATH" ] && [ -f "\$VENV_PATH/bin/activate" ]; then
    if [[ "\$PWD" == "\$PROJECT_ROOT"* ]]; then
        echo "激活虚拟环境: \$VENV_PATH"
        source "\$VENV_PATH/bin/activate"
    fi
fi
EOF

    echo "✅ 配置完成！"
    echo ""
    echo "重新打开终端或运行以下命令使配置生效:"
    echo "  source $SHELL_RC"
fi

echo ""
echo "提示: 只有在项目目录及其子目录中才会自动激活虚拟环境"
