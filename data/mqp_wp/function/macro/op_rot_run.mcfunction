$data modify storage mqp_wp:data waypoints[$(idx)].yaw set from storage mqp_wp:args yaw
$data modify storage mqp_wp:data waypoints[$(idx)].pitch set from storage mqp_wp:args pitch

$tellraw @s [{"text":"[MQP-WP] 已修改路径点 ","color":"green"},{"text":"$(id)","color":"yellow"},{"text":" 的角度","color":"green"}]
