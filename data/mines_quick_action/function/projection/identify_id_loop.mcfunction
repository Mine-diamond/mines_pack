data modify storage mines_quick_action:projection_result id set value a

execute store result storage mines_quick_action:projection index int 1 run scoreboard players get #dummyCurrentIndex mines.projection

function mines_quick_action:projection/indetify_id_loop2 with storage mines_quick_action:projection

#tellraw @a [{score:{name:"#dummyCurrentIndex",objective:"mines.projection"}}]
execute unless data storage mines_quick_action:projection_result {id:a} run return fail

execute if score #dummyCurrentIndex mines.projection matches 86 run return fail
scoreboard players add #dummyCurrentIndex mines.projection 1



function mines_quick_action:projection/identify_id_loop