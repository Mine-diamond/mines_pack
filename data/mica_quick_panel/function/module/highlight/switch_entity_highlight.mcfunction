execute store result score #temp mqp.temp run data get storage mqp:highlight entity_enabled_flags

execute if score #temp mqp.temp matches 1 run data modify storage mqp:highlight entity_enabled_flags set value 0
execute unless score #temp mqp.temp matches 1 run data modify storage mqp:highlight entity_enabled_flags set value 1

execute if score #temp mqp.temp matches 1 run tellraw @s "[快捷功能]§c已关闭实体高亮"
execute unless score #temp mqp.temp matches 1 run tellraw @s "[快捷功能]§b已开启实体高亮"