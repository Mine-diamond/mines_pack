$attribute @s block_interaction_range base set $(block_interaction_range)
$execute unless score @s mqp.core.message_feedback matches 0 run tellraw @s ["","[快捷功能]","方块交互距离已设置为",{"text":"$(block_interaction_range)","color":"green"}]

function mica_quick_panel:dialog/interaction_setting_dialog/open_block_interaction_setting_dialog
