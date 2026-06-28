$execute store result storage mqp_wp:data waypoints[$(idx)].yaw float 1 run data get storage mqp_wp:args input.yaw 1
$execute store result storage mqp_wp:data waypoints[$(idx)].pitch float 1 run data get storage mqp_wp:args input.pitch 1

$execute unless score @s mqp.core.message_feedback matches 0 run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 已修改路径点 ","color":"green"},{"text":"$(id)","color":"yellow"},{"text":" 的角度","color":"green"}]
