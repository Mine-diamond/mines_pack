$scoreboard players set #dummyMaxLength mines.calc $(max_length)
execute store result score #dummyMaxStep mines.calc run scoreboard players operation #dummyMaxLength mines.calc *= #10 mines.calc

execute store result storage mines_quick_action:projection max_step int 1 run scoreboard players get #dummyMaxStep mines.calc

#$data modify storage mines_quick_action:projection max_step set value $(max_length)
function mines_quick_action:entity_copyer/get_entity_data