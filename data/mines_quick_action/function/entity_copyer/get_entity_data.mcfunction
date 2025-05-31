data remove storage mines_pack:entity_copy_data data
data remove storage mines_pack:entity_copy_data id

function mines_quick_action:projection/start

data modify storage mines_pack:entity_copy_data data set from storage mines_quick_action:projection_result entity_data
data modify storage mines_pack:entity_copy_data data.id set from storage mines_quick_action:projection_result id
data remove storage mines_pack:entity_copy_data data.Pos

function mines_quick_action:entity_copyer/get_id_by_index with storage mines_quick_action:projection

