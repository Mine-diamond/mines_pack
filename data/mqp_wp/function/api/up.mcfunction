function mqp_wp:internal/args_to_ctx

scoreboard players operation #prev_idx wp_calc = #idx wp_calc
scoreboard players remove #prev_idx wp_calc 1

scoreboard players operation #new_id wp_calc = #id wp_calc
scoreboard players remove #new_id wp_calc 1

execute store result storage mqp_wp:ctx prev_idx int 1 run scoreboard players get #prev_idx wp_calc
execute store result storage mqp_wp:ctx new_id int 1 run scoreboard players get #new_id wp_calc

execute if score #id wp_calc matches 2.. run function mqp_wp:macro/up_prepare with storage mqp_wp:ctx
execute unless score #id wp_calc matches 2.. run tellraw @s {"text":"[MQP-WP] 该路径点已经在最上方，无法上移","color":"red"}