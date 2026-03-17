execute store result storage mines_pack:entity_projection_result current_index int 1 run scoreboard players get #current_id mines.projection
function mines_quick_action:copy_entity/identify_entity_id_2 with storage mines_pack:entity_projection_result
execute unless data storage mines_pack:entity_projection_result {entity_id:null} run return 1
execute if score #current_id mines.projection matches 86 run return fail
scoreboard players add #current_id mines.projection 1
return run function mines_quick_action:copy_entity/identify_entity_id