$execute store result storage mqp_wp:data waypoints[$(idx)].x int 1 run data get storage mqp_wp:args input.x 1
$execute store result storage mqp_wp:data waypoints[$(idx)].y int 1 run data get storage mqp_wp:args input.y 1
$execute store result storage mqp_wp:data waypoints[$(idx)].z int 1 run data get storage mqp_wp:args input.z 1

$tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 已修改路径点 ","color":"green"},{"text":"$(id)","color":"yellow"},{"text":" 的整数坐标","color":"green"}]
