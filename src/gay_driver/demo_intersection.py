import gymnasium as gym
import highway_env

# 1. 实例化十字路口环境，强制开启人类可视化的渲染模式
env = gym.make("intersection-v0", render_mode="human")

# 2. 初始化环境，获取初始观测数据（State）
obs, info = env.reset()

print("环境初始化成功！")
print(f"观测空间(State)维度: {env.observation_space}")
print(f"动作空间(Action)维度: {env.action_space}")

done = truncated = False
step_count = 0

# 3. 开始强化学习的交互循环（在此演示中为随机盲目决策）
while not (done or truncated):
    # 随机向环境发送一个合法的离散动作指令 (例如：0-减速, 1-保持, 2-加速等)
    action = env.action_space.sample()

    # 环境基于该动作步进一帧，吐出新的状态、奖励和结束标志
    obs, reward, done, truncated, info = env.step(action)
    step_count += 1

    # 在屏幕上渲染这一帧画面
    env.render()

print(f"Episode 结束。总共存活了 {step_count} 步 (Steps)，最终得分: {reward}")

# 4. 关闭环境回收资源
env.close()