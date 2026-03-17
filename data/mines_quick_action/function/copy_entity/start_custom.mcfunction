$scoreboard players set #remove_entity mines.projection $(remove_entity)

$scoreboard players set #max_step_block mines.projection $(max_step_block)
execute store result score #max_step mines.projection run scoreboard players operation #max_step_block mines.projection *= #5 mines.math

function mines_quick_action:copy_entity/execute