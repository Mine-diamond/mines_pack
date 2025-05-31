$data modify storage mines_pack:entity_copy_data id set from storage mines_pack:entity_id_pure id_list[$(index)]
function mines_quick_action:entity_copyer/give_spawn_egg with storage mines_pack:entity_copy_data
function mines_quick_action:entity_copyer/kill_entity with storage mines_pack:entity_copy_data data