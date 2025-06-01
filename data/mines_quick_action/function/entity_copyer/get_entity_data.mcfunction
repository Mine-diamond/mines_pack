data remove storage mines_pack:entity_copy_data data
data remove storage mines_pack:entity_copy_data id
data remove storage mines_pack:entity_copy_data CustomName

function mines_quick_action:projection/start

#处理数据
data modify storage mines_pack:entity_copy_data data set from storage mines_quick_action:projection_result entity_data
data modify storage mines_pack:entity_copy_data data.id set from storage mines_quick_action:projection_result id
data remove storage mines_pack:entity_copy_data data.Pos
execute if data storage mines_pack:entity_copy_data data.CustomName run data modify storage mines_pack:entity_copy_data CustomName set from storage mines_pack:entity_copy_data data.CustomName
execute unless data storage mines_pack:entity_copy_data data.CustomName run data modify storage mines_pack:entity_copy_data CustomName set value ""

execute unless data storage mines_pack:entity_copy_data data run tellraw @s "未找到生物"

function mines_quick_action:entity_copyer/get_id_by_index with storage mines_quick_action:projection

