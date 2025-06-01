#$scoreboard players set #dummyMaxLength mines.projection $(max_length)
scoreboard players set #dummyCurrentIndex mines.projection 0
scoreboard players set #dummyCurrentProjecteTime mines.projection 0

data remove storage mines_quick_action:projection_result entity_data
data remove storage mines_quick_action:projection_result id
data remove storage mines_quick_action:projection index
data remove storage mines_quick_action:projection id

execute anchored eyes run function mines_quick_action:projection/shoot with storage mines_quick_action:projection

data modify storage mines_quick_action:projection max_step set value 60