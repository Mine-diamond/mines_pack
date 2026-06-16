$data modify storage mqp_wp:data waypoints[$(idx)].name set from storage mqp_wp:args name

$tellraw @s [{"text":"[MQP-WP] 已修改路径点 ","color":"green"},{"text":"$(id)","color":"yellow"},{"text":" 的名称","color":"green"}]
