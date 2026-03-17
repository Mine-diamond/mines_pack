scoreboard players add #current_step mines.projection 1

# 如果当前位置有生物，保存该生物的数据
execute if entity @e[distance=..0.5,type=!player] as @e[distance=..0.5,sort=nearest,limit=1] \
    run data modify storage mines_pack:entity_projection_result entity_data set from entity @s

execute if entity @e[distance=..0.5,type=!player] as @e[distance=..0.5,sort=nearest,limit=1] \
    run return 1

execute if score #current_step mines.projection >= #max_step mines.projection run return 0

return run execute positioned ^ ^ ^0.2 run function mines_quick_action:copy_entity/projection/loop