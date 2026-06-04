execute as @a[scores={mqp.trigger.interaction_setting.block_switch_force_mode=1..}] run function mica_quick_panel:interaction_setting/block_interaction_distance_setting/switch_force_mode
execute as @a[scores={mqp.trigger.interaction_setting.block_switch_force_mode=1..}] run function mica_quick_panel:dialog/interaction_setting_dialog/open_block_interaction_setting_dialog
scoreboard players set @a[scores={mqp.trigger.interaction_setting.block_switch_force_mode=1..}] mqp.trigger.interaction_setting.block_switch_force_mode 0
scoreboard players enable @a mqp.trigger.interaction_setting.block_switch_force_mode
