scoreboard players add @s mqp.simple_feature.invulnerable_mode 0
execute store result score #temp mqp.simple_feature.invulnerable_mode run scoreboard players get @s mqp.simple_feature.invulnerable_mode

execute if score #temp mqp.simple_feature.invulnerable_mode matches 1 run function mica_quick_panel:simple_feature/invulnerable_mode/disable_invulnerability
execute unless score #temp mqp.simple_feature.invulnerable_mode matches 1 run function mica_quick_panel:simple_feature/invulnerable_mode/enable_invulnerability

execute if score #temp mqp.simple_feature.invulnerable_mode matches 1 run scoreboard players set @s mqp.simple_feature.invulnerable_mode 0
execute unless score #temp mqp.simple_feature.invulnerable_mode matches 1 run scoreboard players set @s mqp.simple_feature.invulnerable_mode 1