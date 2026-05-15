execute if data storage mqp:highlight {EntityEnabledFlags:1} as @e[type=!minecraft:item,type=!minecraft:player] run effect give @s minecraft:glowing 1 1 true
execute if data storage mqp:highlight {PlayerEnabledFlags:1} run effect give @a minecraft:glowing 1 1 true

execute if data storage mqp:highlight {ItemEnabledFlags:1} as @e[type=minecraft:item,nbt=!{Glowing:1b}] run tag @s add mines_pack_highlight_item
execute if data storage mqp:highlight {ItemEnabledFlags:1} as @e[type=minecraft:item] run data merge entity @s {Glowing:1b}
execute if data storage mqp:highlight {ItemEnabledFlags:0} as @e[type=minecraft:item,tag=mines_pack_highlight_item] run data merge entity @s {Glowing:0b}
execute if data storage mqp:highlight {ItemEnabledFlags:0} as @e[type=minecraft:item,tag=mines_pack_highlight_item] run tag @s remove mines_pack_highlight_item

schedule function mica_quick_panel:highlight/tick_schedule 10t