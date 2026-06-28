$data modify storage mqp_wp:data waypoints[$(idx)].name set from storage mqp_wp:args input.name

$execute unless score @s mqp.core.message_feedback matches 0 run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 已修改路径点 ","color":"green"},{"text":"$(id)","color":"yellow"},{"text":" 的名称","color":"green"}]
