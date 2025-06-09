$scoreboard players set #dummyMaxStep mines.calc $(length)
execute store result score #dummyMaxStep mines.calc run scoreboard players operation #dummyMaxStep mines.calc *= #10 mines.calc
execute store result storage mines_pack:projection_block_config max_step int 1 run scoreboard players get #dummyMaxStep mines.calc

function mines_quick_action:projection_block/start


execute if data storage mines_pack:projection_block_result_success {success:0} run tell @s "前方没有方块"
execute if data storage mines_pack:projection_block_result_success {success:0} run return 0

data modify storage mines_pack:move_to_pos x set from storage mines_pack:projection_block_result_adjacent Pos[0]
data modify storage mines_pack:move_to_pos y set from storage mines_pack:projection_block_result_adjacent Pos[1]
data modify storage mines_pack:move_to_pos z set from storage mines_pack:projection_block_result_adjacent Pos[2]

function mines_quick_action:block_projection_fc/tp with storage mines_pack:move_to_pos