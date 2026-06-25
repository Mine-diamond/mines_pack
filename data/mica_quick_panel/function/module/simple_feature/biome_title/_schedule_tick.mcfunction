execute as @a at @s if score @s mqp.simple_feature.biome_title.enable matches 1 run function mica_quick_panel:module/simple_feature/biome_title/_check_biome
schedule function mica_quick_panel:module/simple_feature/biome_title/_schedule_tick 40t replace
