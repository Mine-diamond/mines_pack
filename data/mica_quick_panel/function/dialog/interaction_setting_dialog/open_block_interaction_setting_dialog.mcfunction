data modify storage mqp:dialog block_interaction_setting_dialog_prepare.block_interaction_range set value "$(block_interaction_range)"
execute store result score #temp mqp.temp run attribute @s block_interaction_range base get 10
execute store result storage mqp:dialog block_interaction_setting_dialog_prepare.current_block_interaction_range double 0.1 run scoreboard players get #temp mqp.temp

execute if score @s mqp.block_interaction_distance.force_mode matches 1 run data modify storage mqp:dialog block_interaction_setting_dialog_prepare.switch_force_mode set from storage mqp:constant.word on
execute unless score @s mqp.block_interaction_distance.force_mode matches 1 run data modify storage mqp:dialog block_interaction_setting_dialog_prepare.switch_force_mode set from storage mqp:constant.word off

function mica_quick_panel:dialog/interaction_setting_dialog/block_interaction_setting_dialog with storage mqp:dialog block_interaction_setting_dialog_prepare