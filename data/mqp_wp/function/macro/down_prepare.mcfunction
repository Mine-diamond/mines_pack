data remove storage mqp_wp:temp move

$data modify storage mqp_wp:temp move.current set from storage mqp_wp:data waypoints[$(idx)]
$data modify storage mqp_wp:temp move.next set from storage mqp_wp:data waypoints[$(next_idx)]

execute if data storage mqp_wp:temp move.current.dim if data storage mqp_wp:temp move.next.dim run function mqp_wp:macro/down_run with storage mqp_wp:ctx
$execute unless score @s mqp.core.message_feedback matches 0 unless data storage mqp_wp:temp move.current.dim run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 路径点 ","color":"red"},{"text":"$(id)","color":"yellow"},{"text":" 不存在，无法下移","color":"red"}]
