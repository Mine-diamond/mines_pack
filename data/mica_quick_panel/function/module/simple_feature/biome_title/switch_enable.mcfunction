execute store result score #temp mqp.temp if score @s mqp.simple_feature.biome_title.enable matches 1
execute unless score @s mqp.core.message_feedback matches 0 if score #temp mqp.temp matches 1 run tellraw @s ["[快捷功能]",{"text":"已禁用显示生物群系","color":"red"}]
execute unless score @s mqp.core.message_feedback matches 0 unless score #temp mqp.temp matches 1 run tellraw @s ["[快捷功能]",{"text":"已启用显示生物群系","color":"green"}]

execute if score #temp mqp.temp matches 1 run scoreboard players set @s mqp.simple_feature.biome_title.enable 0
execute unless score #temp mqp.temp matches 1 at @s run function mica_quick_panel:module/simple_feature/biome_title/_check_biome
execute unless score #temp mqp.temp matches 1 run scoreboard players set @s mqp.simple_feature.biome_title.enable 1
