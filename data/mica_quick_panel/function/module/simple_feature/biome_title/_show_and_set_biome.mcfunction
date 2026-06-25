$scoreboard players set @s mqp.simple_feature.biome_title.current_biome $(id)

execute unless score @s mqp.simple_feature.biome_title.enable matches 1 run return 0
title @s times 10 38 12
$title @s title [{"storage":"mqp:simple_feature.biome_title","nbt":"biome_name[$(id)]","interpret":true}]
