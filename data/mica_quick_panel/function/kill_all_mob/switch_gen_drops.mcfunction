execute store result score #temp mqp.temp run data get storage mqp:kill_all_mob close_mob_loot

execute if score #temp mqp.temp matches 1 run data modify storage mqp:kill_all_mob close_mob_loot set value 0
execute unless score #temp mqp.temp matches 1 run data modify storage mqp:kill_all_mob close_mob_loot set value 1