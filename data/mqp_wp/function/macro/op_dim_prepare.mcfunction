data remove storage mqp_wp:temp target

$data modify storage mqp_wp:temp target set from storage mqp_wp:data waypoints[$(idx)]

execute if data storage mqp_wp:temp target.dim run function mqp_wp:macro/op_dim_run with storage mqp_wp:ctx
$execute unless score @s mqp.core.message_feedback matches 0 unless data storage mqp_wp:temp target.dim run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 路径点 ","color":"red"},{"text":"$(id)","color":"yellow"},{"text":" 不存在","color":"red"}]
