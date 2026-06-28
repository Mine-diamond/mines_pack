$execute as @a[tag=mqp.impossible] unless score @s mqp.core.message_feedback matches 0 run tellraw @s $(text)

scoreboard players set #is_valid mqp.temp 1
