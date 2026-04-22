import gymnasium as gym
from stable_baselines3 import PPO

env = gym.make("Pendulum-v1")

model = PPO("MlpPolicy", env, verbose=1, tensorboard_log="./ppo_logs/")

model.learn(total_timesteps=10000)

model.save("sb3_test_model")

env.close()