data modify storage mqp:time_setting moon_phase_prepare set value {color_0:"§f", color_1:"§f", color_2:"§f", color_3:"§f", color_4:"§f", color_5:"§f", color_6:"§f", color_7:"§f"}

execute store result score #temp mqp.calc run time query day

scoreboard players operation #current_phase mqp.calc = #temp mqp.calc
scoreboard players operation #current_phase mqp.calc %= #8 mqp.constant.number

execute if score #current_phase mqp.calc matches 0 run data modify storage mqp:time_setting moon_phase_prepare.color_0 set value "§a"
execute if score #current_phase mqp.calc matches 1 run data modify storage mqp:time_setting moon_phase_prepare.color_1 set value "§a"
execute if score #current_phase mqp.calc matches 2 run data modify storage mqp:time_setting moon_phase_prepare.color_2 set value "§a"
execute if score #current_phase mqp.calc matches 3 run data modify storage mqp:time_setting moon_phase_prepare.color_3 set value "§a"
execute if score #current_phase mqp.calc matches 4 run data modify storage mqp:time_setting moon_phase_prepare.color_4 set value "§a"
execute if score #current_phase mqp.calc matches 5 run data modify storage mqp:time_setting moon_phase_prepare.color_5 set value "§a"
execute if score #current_phase mqp.calc matches 6 run data modify storage mqp:time_setting moon_phase_prepare.color_6 set value "§a"
execute if score #current_phase mqp.calc matches 7 run data modify storage mqp:time_setting moon_phase_prepare.color_7 set value "§a"

function mica_quick_panel:dialog/time_setting_dialog/moon_phase_setting_dialog with storage mqp:time_setting moon_phase_prepare