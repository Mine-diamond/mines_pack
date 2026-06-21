execute store result score #temp mqp.temp if predicate mica_quick_panel:easter_egg/reach_easter_egg_conditions

#tellraw @a [{"text":"分数："},{score:{name:"*",objective:mqp.easter_egg.timer}}]

execute if score #temp mqp.temp matches 1 run dialog show @s mica_quick_panel:easter_egg/easter_egg
execute if score #temp mqp.temp matches 1 run scoreboard players set @s mqp.easter_egg.timer 0
execute if score #temp mqp.temp matches 1 run scoreboard players set @s mqp.easter_egg.click_count 0
execute if score #temp mqp.temp matches 1 run tag @s remove mqp.easter_egg.timer
execute if score #temp mqp.temp matches 1 run return 1

execute if score @s mqp.easter_egg.timer > #0 mqp.constant.number run scoreboard players operation @s mqp.easter_egg.timer -= #1 mqp.constant.number
execute if score @s mqp.easter_egg.timer matches 0 run scoreboard players set @s mqp.easter_egg.click_count 0
execute if score @s mqp.easter_egg.timer matches 0 run tag @s remove mqp.easter_egg.timer
execute if score @s mqp.easter_egg.timer matches 0 run return 0