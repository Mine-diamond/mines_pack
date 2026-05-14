execute as @a[scores={mqp.trigger.time_setting=0..}] run function mica_quick_panel:time_setting/set_time_init
execute as @a[scores={mqp.trigger.time_setting=0..}] run function mica_quick_panel:dialog/time_setting_dialog/open_time_setting_dialog
scoreboard players set @a[scores={mqp.trigger.time_setting=0..}] mqp.trigger.time_setting -1
scoreboard players enable @a mqp.trigger.time_setting

execute as @a[scores={mqp.trigger.moon_phase=0..}] run function mica_quick_panel:time_setting/set_moon_phase
execute as @a[scores={mqp.trigger.moon_phase=0..}] run function mica_quick_panel:dialog/time_setting_dialog/open_moon_phase_setting_dialog
scoreboard players set @a[scores={mqp.trigger.moon_phase=0..}] mqp.trigger.moon_phase -1
scoreboard players enable @a mqp.trigger.moon_phase