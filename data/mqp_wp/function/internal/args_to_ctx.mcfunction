execute store result score #id wp_calc run data get storage mqp_wp:args id 1

scoreboard players operation #idx wp_calc = #id wp_calc
scoreboard players remove #idx wp_calc 1

execute store result storage mqp_wp:ctx id int 1 run scoreboard players get #id wp_calc
execute store result storage mqp_wp:ctx idx int 1 run scoreboard players get #idx wp_calc
