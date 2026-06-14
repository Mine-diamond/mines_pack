execute at @s run function mica_quick_panel:teleport_to_look_at/start_projection with storage mqp:teleport_to_look_at

execute if data storage mqp:util.block_projection {success:1} run function mica_quick_panel:teleport_to_look_at/tp with storage mqp:teleport_to_look_at

execute if data storage mqp:util.block_projection {success:1} run data modify storage mqp_actionbar:api msg set value {text:"已传送",color:"green"}
execute unless data storage mqp:util.block_projection {success:1} run data modify storage mqp_actionbar:api msg set value {text:"前方没有方块",color:"red"}
data modify storage mqp_actionbar:api duration set value 40
data modify storage mqp_actionbar:api source set value "teleport_to_look_at"
function mqp_actionbar:timed/add_timed