data remove storage mqp_wp:temp move

$data modify storage mqp_wp:temp move.current set from storage mqp_wp:data waypoints[$(idx)]
$data modify storage mqp_wp:temp move.previous set from storage mqp_wp:data waypoints[$(prev_idx)]

execute if data storage mqp_wp:temp move.current.dim if data storage mqp_wp:temp move.previous.dim run function mqp_wp:macro/up_run with storage mqp_wp:ctx
$execute unless data storage mqp_wp:temp move.current.dim run tellraw @s [{"text":"[MQP-WP] 路径点 ","color":"red"},{"text":"$(id)","color":"yellow"},{"text":" 不存在，无法上移","color":"red"}]
