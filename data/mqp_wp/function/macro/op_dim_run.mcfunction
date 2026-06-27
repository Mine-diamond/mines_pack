$data modify storage mqp_wp:data waypoints[$(idx)].dim set from storage mqp_wp:args input.dim

$tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 已修改路径点 ","color":"green"},{"text":"$(id)","color":"yellow"},{"text":" 的维度","color":"green"}]
