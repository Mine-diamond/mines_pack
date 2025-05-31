$data modify storage mines_quick_action:projection id set from storage mines_pack:entity_id id_list[$(index)]
#tellraw @a [{storage:"mines_quick_action:projection",nbt:"id"}]
function mines_quick_action:projection/identify_id with storage mines_quick_action:projection