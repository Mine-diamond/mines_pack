execute if entity @e[distance=..0.7,type=#projection_entity] \
    as @e[distance=..1,sort=nearest,type=#projection_entity,limit=1] \
    run data modify storage mines_quick_action:projection_result entity_data set from entity @s

execute if entity @e[distance=..0.7,type=#projection_entity] \
    as @e[distance=..1,sort=nearest,type=#projection_entity,limit=1] \
    run function mines_quick_action:projection/identify_id_loop

#execute if entity @e[distance=..0.7,type=#projection_entity] \
    as @e[distance=..1,sort=nearest,type=#projection_entity,limit=1] \
    run say 找到了

execute if entity @e[distance=..0.7,type=#projection_entity] \
    as @e[distance=..1,sort=nearest,type=#projection_entity,limit=1] \
    run return fail

scoreboard players add #dummyCurrentProjecteTime mines.projection 1
$execute if score #dummyCurrentProjecteTime mines.projection matches $(max_step) run return fail

execute positioned ^ ^ ^0.1 run function mines_quick_action:projection/shoot with storage mines_quick_action:projection