execute store result score #temp mqp.calc run time query minecraft:day repetition

scoreboard players operation #current_phase mqp.calc = #temp mqp.calc
scoreboard players operation #current_phase mqp.calc %= #8 mqp.constant.number

scoreboard players operation #target_phase mqp.calc = @s mqp.trigger.moon_phase
scoreboard players operation #target_phase mqp.calc -= #current_phase mqp.calc
scoreboard players add #target_phase mqp.calc 8
scoreboard players operation #target_phase mqp.calc %= #8 mqp.constant.number

execute if score #target_phase mqp.calc matches 1 run time add 24000
execute if score #target_phase mqp.calc matches 2 run time add 48000
execute if score #target_phase mqp.calc matches 3 run time add 72000
execute if score #target_phase mqp.calc matches 4 run time add 96000
execute if score #target_phase mqp.calc matches 5 run time add 120000
execute if score #target_phase mqp.calc matches 6 run time add 144000
execute if score #target_phase mqp.calc matches 7 run time add 168000

execute if score @s mqp.trigger.moon_phase matches 0 run tellraw @s ["[快捷功能]","月相已设置为",{"text":"[满月]","color":"green"}]
execute if score @s mqp.trigger.moon_phase matches 1 run tellraw @s ["[快捷功能]","月相已设置为",{"text":"[亏凸月]","color":"green"}]
execute if score @s mqp.trigger.moon_phase matches 2 run tellraw @s ["[快捷功能]","月相已设置为",{"text":"[下弦月]","color":"green"}]
execute if score @s mqp.trigger.moon_phase matches 3 run tellraw @s ["[快捷功能]","月相已设置为",{"text":"[残月]","color":"green"}]
execute if score @s mqp.trigger.moon_phase matches 4 run tellraw @s ["[快捷功能]","月相已设置为",{"text":"[新月]","color":"green"}]
execute if score @s mqp.trigger.moon_phase matches 5 run tellraw @s ["[快捷功能]","月相已设置为",{"text":"[娥眉月]","color":"green"}]
execute if score @s mqp.trigger.moon_phase matches 6 run tellraw @s ["[快捷功能]","月相已设置为",{"text":"[上弦月]","color":"green"}]
execute if score @s mqp.trigger.moon_phase matches 7 run tellraw @s ["[快捷功能]","月相已设置为",{"text":"[盈凸月]","color":"green"}]