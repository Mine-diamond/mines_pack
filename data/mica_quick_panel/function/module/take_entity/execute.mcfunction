scoreboard players operation #temp1 mqp.calc = @s mqp.trigger.take_entity.take_entity
scoreboard players operation #temp2 mqp.calc = @s mqp.trigger.take_entity.take_entity

scoreboard players operation #temp1 mqp.calc %= #10 mqp.constant.number
# 除以10乘以5
scoreboard players operation #temp2 mqp.calc /= #10 mqp.constant.number
scoreboard players operation #temp2 mqp.calc *= #5 mqp.constant.number

execute store result storage mqp:take_entity remove_entity int 1 run scoreboard players get #temp1 mqp.calc
execute store result storage mqp:take_entity step int 1 run scoreboard players get #temp2 mqp.calc

execute at @s run function mica_quick_panel:util/copy_entity/start with storage mqp:take_entity