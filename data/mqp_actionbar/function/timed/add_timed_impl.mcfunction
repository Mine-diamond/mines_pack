# 确保调用者有玩家 ID
execute unless score @s mqp_actionbar.id matches 1.. run function mqp_actionbar:assign_id

# 记录当前玩家 ID
scoreboard players operation $owner mqp_actionbar.id = @s mqp_actionbar.id

# 如果提供了 source，则删除当前玩家同 source 的旧定时消息
execute if data storage mqp_actionbar:api source run function mqp_actionbar:timed/delete_same_source with storage mqp_actionbar:api

# 创建新的定时消息 marker
summon marker ~ ~ ~ {Tags:["mqp_actionbar.timed_msg","mqp_actionbar.new_timed_msg"]}

# 初始化刚创建的 marker
execute as @e[type=marker,tag=mqp_actionbar.new_timed_msg,sort=nearest,limit=1] run function mqp_actionbar:timed/init