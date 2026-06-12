$scoreboard players set #max_step mqp.util.block_projection $(max_step)
data merge storage mqp:util.block_projection {block_type_tag:"#mica_quick_panel:no_collision_block",inverse_selection:1}

function mica_quick_panel:util/block_projection/start

data modify storage mqp:teleport_to_look_at x set from storage mqp:util.block_projection pre_pos[0]
data modify storage mqp:teleport_to_look_at y set from storage mqp:util.block_projection pre_pos[1]
data modify storage mqp:teleport_to_look_at z set from storage mqp:util.block_projection pre_pos[2]