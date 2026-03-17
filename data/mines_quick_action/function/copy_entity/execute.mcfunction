data remove storage mines_pack:entity_projection_result entity_data
function mines_quick_action:copy_entity/projection/start

# 如果没找到生物，直接告诉玩家并结束函数
execute if score #project_success mines.projection matches 0 run tellraw @s "未找到生物"
execute if score #project_success mines.projection matches 0 run return 0

execute if score #project_success mines.projection matches 1 run function mines_quick_action:copy_entity/processing_data