scoreboard players set #current_id mines.projection 0
data modify storage mines_pack:entity_projection_result entity_id set value null

# 获取生物的UUID
data remove storage mines_pack:entity_projection_result entity_uuid
data modify storage mines_pack:entity_projection_result entity_uuid set from storage mines_pack:entity_projection_result entity_data.UUID

# 获取生物的名称
data modify storage mines_pack:entity_projection_result entity_name set value ""
data modify storage mines_pack:entity_projection_result entity_name set from storage mines_pack:entity_projection_result entity_data.CustomName

# 获取生物的类型
execute store result score #identify_entity_id_success mines.projection run function mines_quick_action:copy_entity/identify_entity_id

# 处理剩余需要处理的数据
# execute if score #identify_entity_id_success mines.projection matches 1 run tellraw @s {"storage":"mines_pack:entity_projection_result",nbt:"entity_id"}
execute if score #identify_entity_id_success mines.projection matches 1 run function mines_quick_action:copy_entity/get_pure_id with storage mines_pack:entity_projection_result
execute if score #identify_entity_id_success mines.projection matches 1 run data modify storage mines_pack:entity_projection_result entity_data.id set from storage mines_pack:entity_projection_result entity_id
execute if score #identify_entity_id_success mines.projection matches 1 run data remove storage mines_pack:entity_projection_result entity_data.Pos

# 给刷怪蛋
execute unless data storage mines_pack:entity_projection_result {entity_id:null} run function mines_quick_action:copy_entity/give_spwan_egg with storage mines_pack:entity_projection_result

# 移除生物
execute if score #remove_entity mines.projection matches 1 run function mines_quick_action:copy_entity/remove_entity with storage mines_pack:entity_projection_result