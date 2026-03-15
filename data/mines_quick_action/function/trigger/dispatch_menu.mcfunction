execute if score @s mines.meun matches 1 run function mines_quick_action:unclassified_quick_actions/enable_invulnerability
execute if score @s mines.meun matches 2 run function mines_quick_action:unclassified_quick_actions/disable_invulnerability
execute if score @s mines.meun matches 3 run function mines_quick_action:unclassified_quick_actions/enter_run_mode
execute if score @s mines.meun matches 4 run function mines_quick_action:unclassified_quick_actions/exit_run_mode
execute if score @s mines.meun matches 5 run function mines_quick_action:time/time_show
execute if score @s mines.meun matches 6 run function mines_quick_action:time/time_hide
execute if score @s mines.meun matches 7 run effect give @s minecraft:night_vision infinite 1 true
execute if score @s mines.meun matches 8 run effect clear @s minecraft:night_vision



scoreboard players set @s mines.meun 0