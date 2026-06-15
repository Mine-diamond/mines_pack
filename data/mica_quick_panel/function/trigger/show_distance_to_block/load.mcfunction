scoreboard objectives add mqp.trigger.show_distance_to_block.switch_enable trigger
scoreboard objectives modify mqp.trigger.show_distance_to_block.switch_enable displayname "切换显示据方块距离"
scoreboard players enable @a mqp.trigger.show_distance_to_block.switch_enable

scoreboard objectives add mqp.trigger.show_distance_to_block.set_detect_distance trigger
scoreboard objectives modify mqp.trigger.show_distance_to_block.set_detect_distance displayname "设置显示方块距离检测范围"
scoreboard players enable @a mqp.trigger.show_distance_to_block.set_detect_distance
scoreboard players set @a mqp.trigger.show_distance_to_block.set_detect_distance -1
