$data remove storage mqp_wp:data waypoints[$(idx)]

$tellraw @s [{"text":"[MQP-WP] 已删除全局路径点 ","color":"red"},{"text":"$(id)","color":"yellow"},{"text":"，后续路径点编号已自动前移","color":"gray"}]
