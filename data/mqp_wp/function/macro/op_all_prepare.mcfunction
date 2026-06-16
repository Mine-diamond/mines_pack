data remove storage mqp_wp:temp target

$data modify storage mqp_wp:temp target set from storage mqp_wp:data waypoints[$(idx)]

execute if data storage mqp_wp:temp target.dim run function mqp_wp:macro/op_all_run with storage mqp_wp:ctx
$execute unless data storage mqp_wp:temp target.dim run tellraw @s [{"text":"[MQP-WP] 路径点 ","color":"red"},{"text":"$(id)","color":"yellow"},{"text":" 不存在","color":"red"}]
