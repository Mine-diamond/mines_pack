execute store result score #night_version mqp.simple_feature if predicate mica_quick_panel:simple_feature/night_version
execute if score #night_version mqp.simple_feature matches 1 run tellraw @s ["[快捷功能]",{"text":"已禁用夜视","color":"red"}]
execute unless score #night_version mqp.simple_feature matches 1 run tellraw @s ["[快捷功能]",{"text":"已启用夜视","color":"green"}]

execute if score #night_version mqp.simple_feature matches 1 run effect clear @s minecraft:night_vision
execute unless score #night_version mqp.simple_feature matches 1 run effect give @s minecraft:night_vision infinite 0 true