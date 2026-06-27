function mqp_wp:internal/args_to_ctx

execute if score #id wp_calc matches 1.. run function mqp_wp:macro/tp_prepare with storage mqp_wp:ctx
execute unless score #id wp_calc matches 1.. run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 路径点编号必须从 1 开始","color":"red"}]