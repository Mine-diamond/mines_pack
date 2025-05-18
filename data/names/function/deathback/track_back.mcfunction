execute store result storage mines_pack:death x_pos int 1 run scoreboard players get @s mines.DeathXPos
execute store result storage mines_pack:death y_pos int 1 run scoreboard players get @s mines.DeathYPos
execute store result storage mines_pack:death z_pos int 1 run scoreboard players get @s mines.DeathZPos

execute if data storage mines_pack:death_notice {if_notice:1} run tellraw @s [{"text":"你的死亡位置是："},{"score":{"objective":"mines.DeathXPos","name":"@s"}},{"text":" "},{"score":{"objective":"mines.DeathYPos","name":"@s"}},{"text":" "},{"score":{"objective":"mines.DeathZPos","name":"@s"}},{"text":"§n点击传送","click_event":{"action":"run_command","command":"function names:deathback/back_tp with storage mines_pack:death"},"hover_event":{"action":"show_text","value":[{text:"§9点击传送"}]}}]