scoreboard objectives add mines.worldRunMode dummy
execute as @a[scores={mines.worldRunMode=1}] run function names:world_run_mode
say 执行了