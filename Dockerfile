# 使用官方 Python 镜像作为基础
FROM python:3.11-slim as base

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装 uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# 设置环境变量
ENV UV_SYSTEM_PYTHON=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PATH="/app/.venv/bin:$PATH"

# 复制项目配置文件
COPY pyproject.toml ./
COPY uv.lock* ./

# 安装依赖（如果存在 lock 文件则使用，否则生成新的）
RUN if [ -f uv.lock ]; then \
        uv sync --frozen --no-dev; \
    else \
        uv sync --no-dev; \
    fi

# 复制源代码
COPY . .

# 同步项目（安装项目本身，开发依赖在开发时安装）
RUN uv sync --no-dev

# 设置默认命令（可以根据需要修改）
CMD ["uv", "run", "python", "-c", "print('G.A.Y.Driver is ready!')"]
