$data modify storage mqp_wp:data waypoints[$(idx)].dim set from storage mqp_wp:args input.dim

$tellraw @s [{"text":"[MQP-WP] 已修改路径点 ","color":"green"},{"text":"$(id)","color":"yellow"},{"text":" 的维度","color":"green"}]
