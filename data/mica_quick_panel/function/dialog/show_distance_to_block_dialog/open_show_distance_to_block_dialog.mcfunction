data merge storage mqp:dialog {show_distance_to_block_dialog_prepare:{detect_range:"$(detect_range)"}}

execute store result storage mqp:dialog show_distance_to_block_dialog_prepare.current_detect_range int 0.2 run scoreboard players get @s mqp.show_distance_to_block.max_step

execute if score @s mqp.show_distance_to_block.enable matches 1 run data modify storage mqp:dialog show_distance_to_block_dialog_prepare.switch_enable set from storage mqp:constant.word enable
execute unless score @s mqp.show_distance_to_block.enable matches 1 run data modify storage mqp:dialog show_distance_to_block_dialog_prepare.switch_enable set from storage mqp:constant.word disable

function mica_quick_panel:dialog/show_distance_to_block_dialog/show_distance_to_block_dialog with storage mqp:dialog show_distance_to_block_dialog_prepare