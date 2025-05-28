execute store result storage mines_pack:current_pos x int 1 run data get entity @s Pos[0]
execute store result storage mines_pack:current_pos y int 1 run data get entity @s Pos[1]
execute store result storage mines_pack:current_pos z int 1 run data get entity @s Pos[2]

function names:deathback/set_spawnpoint with storage mines_pack:current_pos