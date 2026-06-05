scoreboard players add @s mqp.simple_feature.run_mode 0
execute store result score #temp mqp.temp run scoreboard players get @s mqp.simple_feature.run_mode

execute if score #temp mqp.temp matches 1 run function mica_quick_panel:simple_feature/run_mode/disable_run_mode
execute unless score #temp mqp.temp matches 1 run function mica_quick_panel:simple_feature/run_mode/enable_run_mode

execute if score #temp mqp.temp matches 1 run scoreboard players set @s mqp.simple_feature.run_mode 0
execute unless score #temp mqp.temp matches 1 run scoreboard players set @s mqp.simple_feature.run_mode 1