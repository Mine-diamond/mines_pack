execute store result score #temp mqp.calc run time query minecraft:day repetition
scoreboard players operation #temp mqp.calc *= #24000 mqp.constant.number
scoreboard players operation #temp mqp.calc += @s mqp.trigger.time_setting


execute store result storage mqp:dialog.time_setting set_time_prepare.time int 1 run scoreboard players get #temp mqp.calc
function mica_quick_panel:time_setting/set_time with storage mqp:dialog.time_setting set_time_prepare