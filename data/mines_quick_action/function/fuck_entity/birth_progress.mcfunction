scoreboard players add #dummyCurrentFuckTime mines.calc 1
execute if score #dummyCurrentFuckTime mines.calc matches 400.. run say yes
execute if score #dummyCurrentFuckTime mines.calc matches 400 run function mines_quick_action:fuck_entity/summon_entity with storage mines_quick_action:projection

execute store result score #dummyCurrentFuckTimeCopy mines.calc run scoreboard players get #dummyCurrentFuckTime mines.calc
execute store result score #dummyCurrentFuckProgress mines.calc run scoreboard players operation #dummyCurrentFuckTime mines.calc /= #10 mines.calc
execute store result score #dummyCurrentFuckTime mines.calc run scoreboard players get #dummyCurrentFuckTimeCopy mines.calc
execute store result storage mines_pack:love progress_num int 1 run scoreboard players get #dummyCurrentFuckProgress mines.calc
function mines_quick_action:fuck_entity/show_progress_jump with storage mines_pack:love

execute if score #dummyCurrentFuckTime mines.calc matches 400.. run scoreboard players set #dummyCurrentFuckTime mines.calc 0
