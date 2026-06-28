$data modify storage mqp_wp:data waypoints[$(idx)].name set from storage mqp_wp:args input.name
$data modify storage mqp_wp:data waypoints[$(idx)].dim set from storage mqp_wp:args input.dim

$execute store result storage mqp_wp:data waypoints[$(idx)].x int 1 run data get storage mqp_wp:args input.x 1
$execute store result storage mqp_wp:data waypoints[$(idx)].y int 1 run data get storage mqp_wp:args input.y 1
$execute store result storage mqp_wp:data waypoints[$(idx)].z int 1 run data get storage mqp_wp:args input.z 1

$execute store result storage mqp_wp:data waypoints[$(idx)].yaw float 1 run data get storage mqp_wp:args input.yaw 1
$execute store result storage mqp_wp:data waypoints[$(idx)].pitch float 1 run data get storage mqp_wp:args input.pitch 1

$execute unless score @s mqp.core.message_feedback matches 0 run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 已完整修改路径点 ","color":"green"},{"text":"$(id)","color":"yellow"}]
