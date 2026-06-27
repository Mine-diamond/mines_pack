execute store result score #id wp_calc run scoreboard players get @s wp_tp
scoreboard players set @s wp_tp 0

scoreboard players operation #idx wp_calc = #id wp_calc
scoreboard players remove #idx wp_calc 1

execute store result storage mqp_wp:ctx id int 1 run scoreboard players get #id wp_calc
execute store result storage mqp_wp:ctx idx int 1 run scoreboard players get #idx wp_calc

execute if score #id wp_calc matches 1.. run function mqp_wp:macro/tp_prepare with storage mqp_wp:ctx
execute unless score #id wp_calc matches 1.. run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 路径点编号必须从 1 开始","color":"red"}]
