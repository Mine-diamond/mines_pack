execute as @a[scores={mqp.dialog.game_rule=1..}] run function mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog
scoreboard players set @a[scores={mqp.dialog.game_rule=1..}] mqp.dialog.game_rule 0
scoreboard players enable @a mqp.dialog.game_rule

execute as @a[scores={mqp.game_rule.random_tick_speed=1..}] run function mica_quick_panel:dialog/gamerule_dialog/open_random_tick_dialog
scoreboard players set @a[scores={mqp.game_rule.random_tick_speed=1..}] mqp.game_rule.random_tick_speed 0
scoreboard players enable @a mqp.game_rule.random_tick_speed

execute as @a[scores={mqp.dialog.simple_feature=1..}] run function mica_quick_panel:dialog/simple_feature_dialog/open_simple_feature_dialog
scoreboard players set @a[scores={mqp.dialog.simple_feature=1..}] mqp.dialog.simple_feature 0
scoreboard players enable @a mqp.dialog.simple_feature

execute as @a[scores={mqp.dialog.time_setting=1..}] run function mica_quick_panel:dialog/time_setting_dialog/open_time_setting_dialog
scoreboard players set @a[scores={mqp.dialog.time_setting=1..}] mqp.dialog.time_setting 0
scoreboard players enable @a mqp.dialog.time_setting

execute as @a[scores={mqp.dialog.moon_phase=1..}] run function mica_quick_panel:dialog/time_setting_dialog/open_moon_phase_setting_dialog
scoreboard players set @a[scores={mqp.dialog.moon_phase=1..}] mqp.dialog.moon_phase 0
scoreboard players enable @a mqp.dialog.moon_phase

execute as @a[scores={mqp.dialog.highlight=1..}] run function mica_quick_panel:dialog/highlight_dialog/open_highlight_dialog
scoreboard players set @a[scores={mqp.dialog.highlight=1..}] mqp.dialog.highlight 0
scoreboard players enable @a mqp.dialog.highlight

execute as @a[scores={mqp.dialog.kill_all_mob=1..}] run function mica_quick_panel:dialog/kill_all_mob_dialog/open_kill_all_mob_dialog
scoreboard players set @a[scores={mqp.dialog.kill_all_mob=1..}] mqp.dialog.kill_all_mob 0
scoreboard players enable @a mqp.dialog.kill_all_mob
