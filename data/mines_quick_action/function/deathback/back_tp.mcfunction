execute store result storage mines_pack:death x_pos int 1 run scoreboard players get @s mines.death_x_pos
execute store result storage mines_pack:death y_pos int 1 run scoreboard players get @s mines.death_y_pos
execute store result storage mines_pack:death z_pos int 1 run scoreboard players get @s mines.death_z_pos
execute store result storage mines_pack:death yaw int 0.01 run scoreboard players get @s mines.death_yaw
execute store result storage mines_pack:death pitch int 0.01 run scoreboard players get @s mines.death_pitch

function mines_quick_action:deathback/back_tp_impl with storage mines_pack:death