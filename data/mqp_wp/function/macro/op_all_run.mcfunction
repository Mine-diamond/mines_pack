$data modify storage mqp_wp:data waypoints[$(idx)].name set from storage mqp_wp:args name
$data modify storage mqp_wp:data waypoints[$(idx)].dim set from storage mqp_wp:args dim

$execute store result storage mqp_wp:data waypoints[$(idx)].x int 1 run data get storage mqp_wp:args x 1
$execute store result storage mqp_wp:data waypoints[$(idx)].y int 1 run data get storage mqp_wp:args y 1
$execute store result storage mqp_wp:data waypoints[$(idx)].z int 1 run data get storage mqp_wp:args z 1

$data modify storage mqp_wp:data waypoints[$(idx)].yaw set from storage mqp_wp:args yaw
$data modify storage mqp_wp:data waypoints[$(idx)].pitch set from storage mqp_wp:args pitch

$tellraw @s [{"text":"[MQP-WP] 已完整修改路径点 ","color":"green"},{"text":"$(id)","color":"yellow"}]
