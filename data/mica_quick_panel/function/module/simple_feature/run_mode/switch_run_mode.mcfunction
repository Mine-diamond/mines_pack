scoreboard players add @s mqp.simple_feature.run_mode 0
execute store result score #temp mqp.calc run scoreboard players get @s mqp.simple_feature.run_mode

scoreboard players operation #temp mqp.calc += #1 mqp.constant.number
execute if score #temp mqp.calc matches 4 run scoreboard players set #temp mqp.calc 0
scoreboard players operation @s mqp.simple_feature.run_mode = #temp mqp.calc

execute if score @s mqp.simple_feature.run_mode matches 0 run function mica_quick_panel:module/simple_feature/run_mode/_disable
execute if score @s mqp.simple_feature.run_mode matches 1 run function mica_quick_panel:module/simple_feature/run_mode/_slow
execute if score @s mqp.simple_feature.run_mode matches 2 run function mica_quick_panel:module/simple_feature/run_mode/_medium
execute if score @s mqp.simple_feature.run_mode matches 3 run function mica_quick_panel:module/simple_feature/run_mode/_fast
