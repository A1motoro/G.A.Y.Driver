"""
PPO 训练演示：在 highway-env 的 intersection-v0 上学离散动作策略。

运行（项目根目录）:
    uv run python src/gay_driver/train_ppo_demo.py

训练阶段不弹窗；结束后用同一策略玩一局并 human 渲染（可按需改步数/关渲染）。
"""

from __future__ import annotations

import gymnasium as gym
import highway_env  # noqa: F401 — 注册 intersection-v0
from stable_baselines3 import PPO
from stable_baselines3.common.env_util import make_vec_env

# 训练规模：先跑通可改小；想更稳可加大
TOTAL_TIMESTEPS = 50_000
MODEL_PATH = "ppo_intersection_demo"


def main() -> None:
    # 向量化环境接口；n_envs=1 避免 Windows 多进程坑，也够做 demo
    vec_env = make_vec_env(
        lambda: gym.make("intersection-v0"),
        n_envs=1,
    )

    # PPO：策略网络根据 obs 输出各离散动作概率，采样与环境交互；
    # 用回报加权更新策略，clip 限制每轮更新幅度以防训崩。
    model = PPO(
        "MlpPolicy",
        vec_env,
        verbose=1,
        learning_rate=3e-4,
        n_steps=2048,
        batch_size=64,
        n_epochs=10,
        gamma=0.99,
        gae_lambda=0.95,
        clip_range=0.2,
    )

    print(f"开始 PPO 训练，共 {TOTAL_TIMESTEPS} 步…")
    model.learn(total_timesteps=TOTAL_TIMESTEPS, progress_bar=False)
    model.save(MODEL_PATH)
    print(f"模型已保存: {MODEL_PATH}.zip")
    vec_env.close()

    # 用确定性策略评估一局（总是选当前认为最好的动作）
    eval_env = gym.make("intersection-v0", render_mode="human")
    obs, _ = eval_env.reset()
    try:
        for _ in range(500):
            action, _states = model.predict(obs, deterministic=True)
            obs, _reward, terminated, truncated, _info = eval_env.step(
                int(action)
            )
            eval_env.render()
            if terminated or truncated:
                break
    finally:
        eval_env.close()


if __name__ == "__main__":
    main()
