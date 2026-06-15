scoreboard players operation #temp mqp.calc = @s mqp.trigger.show_distance_to_block.set_detect_distance
scoreboard players operation #temp mqp.calc *= #5 mqp.constant.number

scoreboard players operation @s mqp.show_distance_to_block.max_step = #temp mqp.calc