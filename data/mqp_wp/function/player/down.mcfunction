execute store result score #id wp_calc run scoreboard players get @s wp_down
scoreboard players set @s wp_down 0

scoreboard players set #len wp_calc 0
execute store result score #len wp_calc run data get storage mqp_wp:data waypoints

scoreboard players operation #idx wp_calc = #id wp_calc
scoreboard players remove #idx wp_calc 1

scoreboard players operation #next_idx wp_calc = #idx wp_calc
scoreboard players add #next_idx wp_calc 1

scoreboard players operation #new_id wp_calc = #id wp_calc
scoreboard players add #new_id wp_calc 1

execute store result storage mqp_wp:ctx id int 1 run scoreboard players get #id wp_calc
execute store result storage mqp_wp:ctx idx int 1 run scoreboard players get #idx wp_calc
execute store result storage mqp_wp:ctx next_idx int 1 run scoreboard players get #next_idx wp_calc
execute store result storage mqp_wp:ctx new_id int 1 run scoreboard players get #new_id wp_calc

execute if score #id wp_calc matches 1.. if score #id wp_calc < #len wp_calc run function mqp_wp:macro/down_prepare with storage mqp_wp:ctx
execute unless score #id wp_calc matches 1.. run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 路径点编号必须从 1 开始","color":"red"}]
execute if score #id wp_calc matches 1.. if score #id wp_calc >= #len wp_calc run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 该路径点不存在，或已经在最下方，无法下移","color":"red"}]
