# 给没有 ID 的玩家分配 ID
execute as @a unless score @s mqp_actionbar.id matches 1.. run function mqp_actionbar:assign_id

# 每个玩家独立处理 actionbar
execute as @a run function mqp_actionbar:player_tick

# 定时消息倒计时
scoreboard players remove @e[type=marker,tag=mqp_actionbar.timed_msg] mqp_actionbar.ttl 1

# 删除过期定时消息
kill @e[type=marker,tag=mqp_actionbar.timed_msg,scores={mqp_actionbar.ttl=..0}]
