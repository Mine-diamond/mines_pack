$data modify storage mqp_wp:data waypoints[$(next_idx)] set from storage mqp_wp:temp move.current
$data modify storage mqp_wp:data waypoints[$(idx)] set from storage mqp_wp:temp move.next

$execute unless score @s mqp.core.message_feedback matches 0 run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 已将路径点 ","color":"green"},{"text":"$(id)","color":"yellow"},{"text":" 下移为 ","color":"green"},{"text":"$(new_id)","color":"yellow"}]
