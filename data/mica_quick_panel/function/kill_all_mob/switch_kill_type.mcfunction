execute store result score #temp mqp.temp run data get storage mqp:kill_all_mob kill_type
scoreboard players add #temp mqp.temp 1
execute if score #temp mqp.temp matches 3 run scoreboard players set #temp mqp.temp 0
execute store result storage mqp:kill_all_mob kill_type int 1 run scoreboard players get #temp mqp.temp