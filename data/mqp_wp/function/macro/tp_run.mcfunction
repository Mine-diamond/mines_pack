$execute in $(dim) run tp @s $(x) $(y) $(z) $(yaw) $(pitch)

$execute unless score @s mqp.core.message_feedback matches 0 run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 已传送到全局路径点 ","color":"aqua"},{"text":"$(id)","color":"yellow"}]
