execute if data storage mines_pack:highlight {EntityEnabledFlags:1} as @e[type=!minecraft:item,type=!minecraft:player] run effect give @s minecraft:glowing 1 1 true
execute if data storage mines_pack:highlight {PlayerEnabledFlags:1} run effect give @a minecraft:glowing 1 1 true

execute if data storage mines_pack:highlight {ItemEnabledFlags:1} as @e[type=minecraft:item,nbt=!{Glowing:1b}] run tag @s add mines_pack_highlight_item
execute if data storage mines_pack:highlight {ItemEnabledFlags:1} as @e[type=minecraft:item] run data merge entity @s {Glowing:1b}
execute if data storage mines_pack:highlight {ItemEnabledFlags:0} as @e[type=minecraft:item,tag=mines_pack_highlight_item] run data merge entity @s {Glowing:0b}
execute if data storage mines_pack:highlight {ItemEnabledFlags:0} as @e[type=minecraft:item,tag=mines_pack_highlight_item] run tag @s remove mines_pack_highlight_item

schedule function mines_quick_action:highlight/highlight_tick 10t