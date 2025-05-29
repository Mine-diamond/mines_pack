$data modify storage mines_pack:tem_setting close_mob_loot set value $(value)

execute if data storage mines_pack:tem_setting {close_mob_loot:1} store result storage mines_pack:tem_setting orin_close_mob_loot int 1 run gamerule doMobLoot
execute if data storage mines_pack:tem_setting {close_mob_loot:1} run gamerule doMobLoot false

kill @e[type=!player]


execute if data storage mines_pack:tem_setting {orin_close_mob_loot:1,close_mob_loot:1} run gamerule doMobLoot true