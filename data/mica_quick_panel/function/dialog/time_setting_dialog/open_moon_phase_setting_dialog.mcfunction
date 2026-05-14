data modify storage mica_quick_panel:time_setting moon_phase_prepare set value {color_0:"§f", color_1:"§f", color_2:"§f", color_3:"§f", color_4:"§f", color_5:"§f", color_6:"§f", color_7:"§f"}

execute store result score #temp mines.calc run time query day

scoreboard players operation #current_phase mines.calc = #temp mines.calc
scoreboard players operation #current_phase mines.calc %= #8 mqp.constant.number

execute if score #current_phase mines.calc matches 0 run data modify storage mica_quick_panel:time_setting moon_phase_prepare.color_0 set value "§a"
execute if score #current_phase mines.calc matches 1 run data modify storage mica_quick_panel:time_setting moon_phase_prepare.color_1 set value "§a"
execute if score #current_phase mines.calc matches 2 run data modify storage mica_quick_panel:time_setting moon_phase_prepare.color_2 set value "§a"
execute if score #current_phase mines.calc matches 3 run data modify storage mica_quick_panel:time_setting moon_phase_prepare.color_3 set value "§a"
execute if score #current_phase mines.calc matches 4 run data modify storage mica_quick_panel:time_setting moon_phase_prepare.color_4 set value "§a"
execute if score #current_phase mines.calc matches 5 run data modify storage mica_quick_panel:time_setting moon_phase_prepare.color_5 set value "§a"
execute if score #current_phase mines.calc matches 6 run data modify storage mica_quick_panel:time_setting moon_phase_prepare.color_6 set value "§a"
execute if score #current_phase mines.calc matches 7 run data modify storage mica_quick_panel:time_setting moon_phase_prepare.color_7 set value "§a"

function mica_quick_panel:dialog/time_setting_dialog/moon_phase_setting_dialog with storage mica_quick_panel:time_setting moon_phase_prepare