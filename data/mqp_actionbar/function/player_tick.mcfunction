# 清空当前玩家本 tick 的 actionbar 缓冲区
data modify storage mqp_actionbar:buffer parts set value []

# 调用普通 provider
# provider 中的 @s 就是当前玩家
function #mqp_actionbar:actionbar_providers

# 记录当前玩家 ID
scoreboard players operation $current mqp_actionbar.id = @s mqp_actionbar.id

# 收集属于当前玩家的定时消息
execute as @e[type=marker,tag=mqp_actionbar.timed_msg] if score @s mqp_actionbar.id = $current mqp_actionbar.id run function mqp_actionbar:timed/append

# 如果有内容，则合并显示
execute if data storage mqp_actionbar:buffer parts[0] run title @s actionbar {"nbt":"parts[]","storage":"mqp_actionbar:buffer","interpret":true,"separator":{"text":" | ","color":"gray"}}

# 如果没有内容，则清空 actionbar
execute unless data storage mqp_actionbar:buffer parts[0] run title @s actionbar {"text":""}
