#data modify storage mines_quick_action:projection max_step set value 30
function mines_quick_action:projection/start
say run now
function mines_quick_action:fuck_entity/set_inlove with storage mines_quick_action:projection_result entity_data
advancement revoke @s only mines_quick_action:fuck_entity_to_love