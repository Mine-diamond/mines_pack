execute store result storage mines_pack:death x_pos int 1 run scoreboard players get @s mines.DeathXPos
execute store result storage mines_pack:death y_pos int 1 run scoreboard players get @s mines.DeathYPos
execute store result storage mines_pack:death z_pos int 1 run scoreboard players get @s mines.DeathZPos

function mines_quick_action:deathback/back_tp with storage mines_pack:death