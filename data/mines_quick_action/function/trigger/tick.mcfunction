execute as @a[scores={mines.meun=1..}] run function mines_quick_action:trigger/dispatch_menu
scoreboard players enable @a mines.meun

execute as @a[scores={mines.death_ops_trig=1..}] run function mines_quick_action:trigger/dispatch_death_operations
scoreboard players enable @a mines.death_ops_trig

execute as @a[scores={mines.death_tp_back=1..}] run function mines_quick_action:trigger/dispatch_death_tp_back
scoreboard players enable @a mines.death_tp_back