execute as @a[scores={mqp.simple_feature.night_version=1..}] run function mica_quick_panel:simple_feature/night_version/switch_night_version
execute as @a[scores={mqp.simple_feature.night_version=1..}] run function mica_quick_panel:dialog/simple_feature_dialog/open_simple_feature_dialog
scoreboard players set @a[scores={mqp.simple_feature.night_version=1..}] mqp.simple_feature.night_version 0
scoreboard players enable @a mqp.simple_feature.night_version

execute as @a[scores={mqp.trigger.simple_feature.invulnerable_mode=1..}] run function mica_quick_panel:simple_feature/invulnerable_mode/switch_invulnerable_mode
execute as @a[scores={mqp.trigger.simple_feature.invulnerable_mode=1..}] run function mica_quick_panel:dialog/simple_feature_dialog/open_simple_feature_dialog
scoreboard players set @a[scores={mqp.trigger.simple_feature.invulnerable_mode=1..}] mqp.trigger.simple_feature.invulnerable_mode 0
scoreboard players enable @a mqp.trigger.simple_feature.invulnerable_mode

execute as @a[scores={mqp.trigger.simple_feature.run_mode=1..}] run function mica_quick_panel:simple_feature/run_mode/switch_run_mode
execute as @a[scores={mqp.trigger.simple_feature.run_mode=1..}] run function mica_quick_panel:dialog/simple_feature_dialog/open_simple_feature_dialog
scoreboard players set @a[scores={mqp.trigger.simple_feature.run_mode=1..}] mqp.trigger.simple_feature.run_mode 0
scoreboard players enable @a mqp.trigger.simple_feature.run_mode
