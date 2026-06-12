execute if data storage mqp:highlight {entity_enabled_flags:1} as @e[type=!minecraft:item,type=!minecraft:player] run effect give @s minecraft:glowing 1 1 true
execute if data storage mqp:highlight {player_enabled_flags:1} run effect give @a minecraft:glowing 1 1 true

execute if data storage mqp:highlight {item_enabled_flags:1} as @e[type=minecraft:item,nbt=!{Glowing:1b}] run tag @s add mqp.high_light.item
execute if data storage mqp:highlight {item_enabled_flags:1} as @e[type=minecraft:item] run data merge entity @s {Glowing:1b}
execute if data storage mqp:highlight {item_enabled_flags:0} as @e[type=minecraft:item,tag=mqp.high_light.item] run data merge entity @s {Glowing:0b}
execute if data storage mqp:highlight {item_enabled_flags:0} as @e[type=minecraft:item,tag=mqp.high_light.item] run tag @s remove mqp.high_light.item

schedule function mica_quick_panel:highlight/tick_schedule 10t