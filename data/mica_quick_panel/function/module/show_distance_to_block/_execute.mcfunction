execute unless score @s mqp.show_distance_to_block.max_step matches 1.. run return 0
scoreboard players operation #max_step mqp.util.block_projection = @s mqp.show_distance_to_block.max_step
data merge storage mqp:util.block_projection {block_type_tag:"air",inverse_selection:1}

function mica_quick_panel:util/block_projection/start

execute unless data storage mqp:util.block_projection {success:1} run scoreboard players set @s mqp.show_distance_to_block.current_distance -1
execute if data storage mqp:util.block_projection {success:1} store result score @s mqp.show_distance_to_block.current_distance run data get storage mqp:util.block_projection distance