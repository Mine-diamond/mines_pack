#default: 0.6 (0-10)
attribute @s minecraft:step_height base reset
#default: 0.42 (0-32)
attribute @s minecraft:jump_strength base reset
#default: 0.1 (0-1024)(测试如此)
attribute @s minecraft:movement_speed base reset
#default: 1 (0-2048)
attribute @s minecraft:air_drag_modifier base reset
#default: 1 (0-2048)
attribute @s minecraft:friction_modifier base reset
#default: 0 (0-1)
attribute @s minecraft:movement_efficiency base reset
#default: 0 (0-1)
attribute @s minecraft:water_movement_efficiency base reset
#default: 0.08 (-1-1)
attribute @s minecraft:gravity base reset

execute unless score @s mqp.core.message_feedback matches 0 run tellraw @s "[快捷功能]§c赶路模式: 禁用"
