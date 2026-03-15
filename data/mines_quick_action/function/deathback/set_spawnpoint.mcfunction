execute store result storage mines_pack:current_pos x int 1 run data get entity @s Pos[0]
execute store result storage mines_pack:current_pos y int 1 run data get entity @s Pos[1]
execute store result storage mines_pack:current_pos z int 1 run data get entity @s Pos[2]
execute store result storage mines_pack:current_pos yaw int 1 run data get entity @s Rotation[0] 1
execute store result storage mines_pack:current_pos pitch int 1 run data get entity @s Rotation[1] 1

function mines_quick_action:deathback/set_spawnpoint_impl with storage mines_pack:current_pos