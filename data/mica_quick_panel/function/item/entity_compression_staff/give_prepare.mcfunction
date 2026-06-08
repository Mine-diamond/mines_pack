scoreboard players operation #temp1 mqp.calc = @s mqp.trigger.item.entity_compression_staff.get
scoreboard players operation #temp2 mqp.calc = @s mqp.trigger.item.entity_compression_staff.get
scoreboard players operation #temp3 mqp.calc = @s mqp.trigger.item.entity_compression_staff.get

# 个位：清除生物
scoreboard players operation #temp1 mqp.calc %= #10 mqp.constant.number
# 高位：检测长度
# 除以10乘以5，算step值
scoreboard players operation #temp2 mqp.calc /= #10 mqp.constant.number
scoreboard players operation #temp2 mqp.calc *= #5 mqp.constant.number
# 算长度值
scoreboard players operation #temp3 mqp.calc /= #10 mqp.constant.number

execute store result storage mqp:item.entity_compression_staff give_prepare.remove_entity int 1 run scoreboard players get #temp1 mqp.calc
execute store result storage mqp:item.entity_compression_staff give_prepare.step int 1 run scoreboard players get #temp2 mqp.calc
execute store result storage mqp:item.entity_compression_staff give_prepare.length int 1 run scoreboard players get #temp3 mqp.calc

function mica_quick_panel:item/entity_compression_staff/give with storage mqp:item.entity_compression_staff give_prepare