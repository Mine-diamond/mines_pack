execute as @a[scores={mqp.trigger.game_rule.change=1}] run function mica_quick_panel:module/game_rule/switch_advance_time
execute as @a[scores={mqp.trigger.game_rule.change=2}] run function mica_quick_panel:module/game_rule/switch_common_game_rule {game_rule:"advance_weather", game_rule_name:"天气更替"}
execute as @a[scores={mqp.trigger.game_rule.change=3}] run function mica_quick_panel:module/game_rule/switch_common_game_rule {game_rule:"spawn_mobs", game_rule_name:"生物生成"}
execute as @a[scores={mqp.trigger.game_rule.change=4}] run function mica_quick_panel:module/game_rule/switch_common_game_rule {game_rule:"keep_inventory", game_rule_name:"死亡不掉落"}
execute as @a[scores={mqp.trigger.game_rule.change=5}] run function mica_quick_panel:module/game_rule/switch_common_game_rule {game_rule:"command_block_output", game_rule_name:"命令方块输出"}
execute as @a[scores={mqp.trigger.game_rule.change=6}] run function mica_quick_panel:module/game_rule/switch_common_game_rule {game_rule:"mob_drops", game_rule_name:"生物掉落物"}
execute as @a[scores={mqp.trigger.game_rule.change=7}] run function mica_quick_panel:module/game_rule/switch_common_game_rule {game_rule:"block_drops", game_rule_name:"方块掉落物"}
execute as @a[scores={mqp.trigger.game_rule.change=8}] run function mica_quick_panel:module/game_rule/switch_common_game_rule {game_rule:"show_advancement_messages", game_rule_name:"进度消息公告"}
execute as @a[scores={mqp.trigger.game_rule.change=1..}] run function mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog
scoreboard players set @a[scores={mqp.trigger.game_rule.change=1..}] mqp.trigger.game_rule.change 0
scoreboard players enable @a mqp.trigger.game_rule.change

execute as @a[scores={mqp.trigger.game_rule.set_to_preferred=1..}] run function mica_quick_panel:module/game_rule/set_game_rule_to_preferred_state
execute as @a[scores={mqp.trigger.game_rule.set_to_preferred=1..}] run function mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog
scoreboard players set @a[scores={mqp.trigger.game_rule.set_to_preferred=1..}] mqp.trigger.game_rule.set_to_preferred 0
scoreboard players enable @a mqp.trigger.game_rule.set_to_preferred

execute as @a[scores={mqp.trigger.game_rule.set_random_tick_speed=0..}] run function mica_quick_panel:module/game_rule/set_random_tick_speed
execute as @a[scores={mqp.trigger.game_rule.set_random_tick_speed=0..}] run function mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog
scoreboard players set @a[scores={mqp.trigger.game_rule.set_random_tick_speed=0..}] mqp.trigger.game_rule.set_random_tick_speed -1
scoreboard players enable @a mqp.trigger.game_rule.set_random_tick_speed
