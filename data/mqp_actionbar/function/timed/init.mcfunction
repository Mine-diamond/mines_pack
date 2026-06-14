# 绑定所属玩家
scoreboard players operation @s mqp_actionbar.id = $owner mqp_actionbar.id

# 默认持续时间
scoreboard players set @s mqp_actionbar.ttl 40

# 写入持续时间
execute if data storage mqp_actionbar:api duration store result score @s mqp_actionbar.ttl run data get storage mqp_actionbar:api duration 1

# 写入消息内容
data modify entity @s data.msg set from storage mqp_actionbar:api msg

# 如果有 source，则写入 source
execute if data storage mqp_actionbar:api source run data modify entity @s data.source set from storage mqp_actionbar:api source

# 初始化完成
tag @s remove mqp_actionbar.new_timed_msg
