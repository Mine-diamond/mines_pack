scoreboard players operation #temp1 mqp.calc = @s mqp.trigger.item.gaze_shift_staff.get
scoreboard players operation #temp2 mqp.calc = @s mqp.trigger.item.gaze_shift_staff.get

scoreboard players operation #temp1 mqp.calc *= #5 mqp.constant.number

execute store result storage mqp:item.gaze_shift_staff give_prepare.max_step int 1 run scoreboard players get #temp1 mqp.calc
execute store result storage mqp:item.gaze_shift_staff give_prepare.length int 1 run scoreboard players get #temp2 mqp.calc

execute at @s run function mica_quick_panel:item/gaze_shift_staff/give with storage mqp:item.gaze_shift_staff give_prepare