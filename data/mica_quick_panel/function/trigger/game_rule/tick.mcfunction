execute as @a[scores={mqp.game_rule.change=1}] run function mica_quick_panel:game_rule_change/switch_advance_time
execute as @a[scores={mqp.game_rule.change=2}] run function mica_quick_panel:game_rule_change/switch_advance_weather
execute as @a[scores={mqp.game_rule.change=3}] run function mica_quick_panel:game_rule_change/switch_spawn_mobs
execute as @a[scores={mqp.game_rule.change=4}] run function mica_quick_panel:game_rule_change/switch_keep_inventory
execute as @a[scores={mqp.game_rule.change=5}] run function mica_quick_panel:game_rule_change/switch_command_block_output
execute as @a[scores={mqp.game_rule.change=6}] run function mica_quick_panel:game_rule_change/switch_mob_drops
execute as @a[scores={mqp.game_rule.change=7}] run function mica_quick_panel:game_rule_change/switch_block_drops
execute as @a[scores={mqp.game_rule.change=8}] run function mica_quick_panel:game_rule_change/switch_show_advancement_messages

execute as @a[scores={mqp.game_rule.change=1..}] run function mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog
scoreboard players set @a[scores={mqp.game_rule.change=1..}] mqp.game_rule.change 0
scoreboard players enable @a mqp.game_rule.change

execute as @a[scores={mqp.game_rule.set_to_preferred=1..}] run function mica_quick_panel:game_rule_change/set_game_rule_to_preferred_state
execute as @a[scores={mqp.game_rule.set_to_preferred=1..}] run function mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog
scoreboard players set @a[scores={mqp.game_rule.set_to_preferred=1..}] mqp.game_rule.set_to_preferred 0
scoreboard players enable @a mqp.game_rule.set_to_preferred

execute as @a[scores={mqp.game_rule.set_random_tick_speed=0..}] run function mica_quick_panel:game_rule_change/set_random_tick_speed_init
execute as @a[scores={mqp.game_rule.set_random_tick_speed=0..}] run function mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog
scoreboard players set @a[scores={mqp.game_rule.set_random_tick_speed=0..}] mqp.game_rule.set_random_tick_speed -1
scoreboard players enable @a mqp.game_rule.set_random_tick_speed