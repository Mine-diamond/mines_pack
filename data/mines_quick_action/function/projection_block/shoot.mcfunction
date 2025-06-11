#say I'm shooting

#execute anchored eyes positioned ^ ^ ^2 align xyz if block ^ ^ ^ air run say 空气方块

#execute if block ^ ^ ^ air run particle dust_plume

#execute unless block ^ ^ ^ air run say 检测到方块
execute unless block ^ ^ ^ air run function mines_quick_action:projection_block/pos_writer
execute unless block ^ ^ ^ air run execute store result storage mines_pack:projection_block_result_distant step int 1 run scoreboard players get #dummyCurrentIndex mines.projection_block
execute unless block ^ ^ ^ air run execute store result storage mines_pack:projection_block_result_distant distant int 1 run scoreboard players operation #dummyCurrentIndex mines.projection_block /= #10 mines.calc
execute unless block ^ ^ ^ air run data modify storage mines_pack:projection_block_result_success success set value 1

execute unless block ^ ^ ^ air run return 1

scoreboard players add #dummyCurrentIndex mines.projection_block 1
#tellraw @s [{score:{name:"#dummyCurrentIndex",objective:"mines.projection_block"}}]
#$execute if score #dummyCurrentIndex mines.projection_block matches $(max_step)..4000 run say 没找到方块
$execute if score #dummyCurrentIndex mines.projection_block matches $(max_step)..4000 run return 0

execute positioned ^ ^ ^0.1 run function mines_quick_action:projection_block/shoot with storage mines_pack:projection_block_config