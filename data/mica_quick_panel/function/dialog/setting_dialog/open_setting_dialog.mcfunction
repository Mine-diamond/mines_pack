data modify storage mqp:dialog setting_dialog_prepare set value {}

execute unless score @s mqp.core.message_feedback matches 0 run data modify storage mqp:dialog setting_dialog_prepare.switch_message_feedback set from storage mqp:constant.word on
execute if score @s mqp.core.message_feedback matches 0 run data modify storage mqp:dialog setting_dialog_prepare.switch_message_feedback set from storage mqp:constant.word off

function mica_quick_panel:dialog/setting_dialog/setting_dialog with storage mqp:dialog setting_dialog_prepare
