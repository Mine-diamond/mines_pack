execute store result score #temp mqp.temp run scoreboard players get @s mqp.show_distance_to_block.enable

execute if score #temp mqp.temp matches 1 run scoreboard players set @s mqp.show_distance_to_block.enable 0
execute unless score #temp mqp.temp matches 1 run scoreboard players set @s mqp.show_distance_to_block.enable 1