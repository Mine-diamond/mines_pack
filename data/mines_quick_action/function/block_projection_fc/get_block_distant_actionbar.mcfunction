$scoreboard players set #dummyMaxStep mines.calc $(length)
execute store result score #dummyMaxStep mines.calc run scoreboard players operation #dummyMaxStep mines.calc *= #10 mines.calc
execute store result storage mines_pack:projection_block_config max_step int 1 run scoreboard players get #dummyMaxStep mines.calc

function mines_quick_action:projection_block/start

execute if data storage mines_pack:projection_block_result_success {success:1} run title @s actionbar [{"text":"你与前方方块的距离是"},{"storage":"mines_pack:projection_block_result_distant",nbt:"distant"}]
execute unless data storage mines_pack:projection_block_result_success {success:1} run title @s actionbar [{"text":"前方没有方块"}]

#tellraw @s [{"text":"看到见我？"}]