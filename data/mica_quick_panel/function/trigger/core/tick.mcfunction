execute as @a[scores={mqp.core.switch_message_feedback=0..}] run function mica_quick_panel:core/switch_message_feedback
execute as @a[scores={mqp.core.switch_message_feedback=0..}] run function mica_quick_panel:dialog/setting_dialog/open_setting_dialog
scoreboard players set @a[scores={mqp.core.switch_message_feedback=0..}] mqp.core.switch_message_feedback -1
scoreboard players enable @a mqp.core.switch_message_feedback
