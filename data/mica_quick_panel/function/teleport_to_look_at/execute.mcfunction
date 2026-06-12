execute at @s run function mica_quick_panel:teleport_to_look_at/start_projection with storage mqp:teleport_to_look_at

execute if data storage mqp:util.block_projection {success:1} run function mica_quick_panel:teleport_to_look_at/tp with storage mqp:teleport_to_look_at
execute unless data storage mqp:util.block_projection {success:1} run tellraw @s "前方没有方块"