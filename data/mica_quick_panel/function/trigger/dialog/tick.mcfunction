execute as @a[scores={mqp.dialog.game_rule=1..}] run function mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog
scoreboard players set @a[scores={mqp.dialog.game_rule=1..}] mqp.dialog.game_rule 0
scoreboard players enable @a mqp.dialog.game_rule

execute as @a[scores={mqp.game_rule.random_tick_speed=1..}] run function mica_quick_panel:dialog/gamerule_dialog/open_random_tick_dialog
scoreboard players set @a[scores={mqp.game_rule.random_tick_speed=1..}] mqp.game_rule.random_tick_speed 0
scoreboard players enable @a mqp.game_rule.random_tick_speed

execute as @a[scores={mqp.dialog.simple_feature=1..}] run function mica_quick_panel:dialog/simple_feature_dialog/open_simple_feature_dialog
scoreboard players set @a[scores={mqp.dialog.simple_feature=1..}] mqp.dialog.simple_feature 0
scoreboard players enable @a mqp.dialog.simple_feature