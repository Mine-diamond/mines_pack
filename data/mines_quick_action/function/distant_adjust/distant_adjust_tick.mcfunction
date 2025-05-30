scoreboard objectives add mines.adjust_block_diatant dummy
scoreboard objectives add mines.adjust_entity_diatant dummy

execute as @a[scores={mines.adjust_block_diatant=1},gamemode=creative] run attribute @s block_interaction_range modifier add minecraft:mines_attributes -0.5 add_value
execute as @a[scores={mines.adjust_block_diatant=1},gamemode=!creative] run attribute @s block_interaction_range modifier remove minecraft:mines_attributes
execute as @a[scores={mines.adjust_block_diatant=0}] run attribute @s block_interaction_range modifier remove minecraft:mines_attributes

execute as @a[scores={mines.adjust_entity_diatant=1},gamemode=creative] run attribute @s entity_interaction_range modifier add minecraft:mines_attributes -2 add_value
execute as @a[scores={mines.adjust_entity_diatant=1},gamemode=!creative] run attribute @s entity_interaction_range modifier remove minecraft:mines_attributes
execute as @a[scores={mines.adjust_entity_diatant=0}] run attribute @s entity_interaction_range modifier remove minecraft:mines_attributes
