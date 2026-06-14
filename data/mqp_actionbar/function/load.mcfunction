# 玩家 ID / 消息所属玩家 ID
scoreboard objectives add mqp_actionbar.id dummy

# 定时消息剩余时间
scoreboard objectives add mqp_actionbar.ttl dummy

# 初始化下一个可用玩家 ID
execute unless score $next mqp_actionbar.id matches 1.. run scoreboard players set $next mqp_actionbar.id 1
