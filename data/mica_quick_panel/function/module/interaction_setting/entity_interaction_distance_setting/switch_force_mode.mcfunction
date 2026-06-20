execute store result score #temp mqp.temp run scoreboard players get @s mqp.entity_interaction_distance.force_mode
execute if score #temp mqp.temp matches 1 run scoreboard players set @s mqp.entity_interaction_distance.force_mode 0
execute unless score #temp mqp.temp matches 1 run scoreboard players set @s mqp.entity_interaction_distance.force_mode 1