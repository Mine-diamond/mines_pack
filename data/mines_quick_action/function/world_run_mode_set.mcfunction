scoreboard objectives add mines.worldRunMode dummy
execute as @a[scores={mines.worldRunMode=1}] run function mines_quick_action:world_run_mode
say 执行了