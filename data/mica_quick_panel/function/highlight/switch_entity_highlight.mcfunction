execute store result score #temp mqp.temp run data get storage mqp:highlight EntityEnabledFlags

execute if score #temp mqp.temp matches 1 run data modify storage mqp:highlight EntityEnabledFlags set value 0
execute unless score #temp mqp.temp matches 1 run data modify storage mqp:highlight EntityEnabledFlags set value 1

execute if score #temp mqp.temp matches 1 run tellraw @s "[快捷功能]§c已关闭实体高亮"
execute unless score #temp mqp.temp matches 1 run tellraw @s "[快捷功能]§b已开启实体高亮"