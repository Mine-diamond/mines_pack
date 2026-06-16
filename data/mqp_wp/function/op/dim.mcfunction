function mqp_wp:internal/args_to_ctx

execute if score #id wp_calc matches 1.. run function mqp_wp:macro/op_dim_prepare with storage mqp_wp:ctx
execute unless score #id wp_calc matches 1.. run tellraw @s {"text":"[MQP-WP] 参数 id 必须从 1 开始","color":"red"}
