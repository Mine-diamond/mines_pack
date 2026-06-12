execute if data storage mqp:clear_entity {close_mob_loot:1} store result storage mqp:clear_entity orin_close_mob_loot int 1 run gamerule mob_drops
execute if data storage mqp:clear_entity {close_mob_loot:1} run gamerule mob_drops false

execute if data storage mqp:clear_entity {kill_type:0} store result score #temp mqp.temp run kill @e[type=!minecraft:player]
execute if data storage mqp:clear_entity {kill_type:1} store result score #temp mqp.temp run kill @e[type=!minecraft:player,type=!minecraft:item]
execute if data storage mqp:clear_entity {kill_type:2} store result score #temp mqp.temp run kill @e[type=minecraft:item]
tellraw @s ["","[快捷功能]","清除了",{"score":{"name":"#temp","objective":"mqp.temp"},"color":"yellow"},"个实体"]

execute if data storage mqp:clear_entity {orin_close_mob_loot:1,close_mob_loot:1} run gamerule mob_drops true