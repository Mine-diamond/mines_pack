scoreboard players enable @s wp_new
scoreboard players enable @s wp_tp
scoreboard players enable @s wp_del
scoreboard players enable @s wp_up
scoreboard players enable @s wp_down

execute if score @s wp_new matches 1.. run function mqp_wp:player/new
execute if score @s wp_tp matches 1.. run function mqp_wp:player/tp
execute if score @s wp_del matches 1.. run function mqp_wp:player/del
execute if score @s wp_up matches 1.. run function mqp_wp:player/up
execute if score @s wp_down matches 1.. run function mqp_wp:player/down
