execute as @a[scores={mqp.trigger.show_distance_to_block.switch_enable=1..}] run function mica_quick_panel:show_distance_to_block/switch_enable
execute as @a[scores={mqp.trigger.show_distance_to_block.switch_enable=1..}] run function mica_quick_panel:dialog/show_distance_to_block_dialog/open_show_distance_to_block_dialog
scoreboard players set @a[scores={mqp.trigger.show_distance_to_block.switch_enable=1..}] mqp.trigger.show_distance_to_block.switch_enable 0
scoreboard players enable @a mqp.trigger.show_distance_to_block.switch_enable

execute as @a[scores={mqp.trigger.show_distance_to_block.set_detect_distance=0..}] run function mica_quick_panel:show_distance_to_block/set_detect_distance
execute as @a[scores={mqp.trigger.show_distance_to_block.set_detect_distance=0..}] run function mica_quick_panel:dialog/show_distance_to_block_dialog/open_show_distance_to_block_dialog
scoreboard players set @a[scores={mqp.trigger.show_distance_to_block.set_detect_distance=0..}] mqp.trigger.show_distance_to_block.set_detect_distance -1
scoreboard players enable @a mqp.trigger.show_distance_to_block.set_detect_distance
