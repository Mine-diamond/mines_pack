execute as @a[scores={mqp.trigger.kill_all_mob.close_mob_loot=1..}] run function mica_quick_panel:kill_all_mob/switch_gen_drops
execute as @a[scores={mqp.trigger.kill_all_mob.close_mob_loot=1..}] run function mica_quick_panel:dialog/kill_all_mob_dialog/open_kill_all_mob_dialog
scoreboard players set @a[scores={mqp.trigger.kill_all_mob.close_mob_loot=1..}] mqp.trigger.kill_all_mob.close_mob_loot 0
scoreboard players enable @a mqp.trigger.kill_all_mob.close_mob_loot

execute as @a[scores={mqp.trigger.kill_all_mob.kill_type=1..}] run function mica_quick_panel:kill_all_mob/switch_kill_type
execute as @a[scores={mqp.trigger.kill_all_mob.kill_type=1..}] run function mica_quick_panel:dialog/kill_all_mob_dialog/open_kill_all_mob_dialog
scoreboard players set @a[scores={mqp.trigger.kill_all_mob.kill_type=1..}] mqp.trigger.kill_all_mob.kill_type 0
scoreboard players enable @a mqp.trigger.kill_all_mob.kill_type

execute as @a[scores={mqp.trigger.kill_all_mob.kill_all_mob=1..}] run function mica_quick_panel:kill_all_mob/kill_all_mob
execute as @a[scores={mqp.trigger.kill_all_mob.kill_all_mob=1..}] run function mica_quick_panel:dialog/kill_all_mob_dialog/open_kill_all_mob_dialog
scoreboard players set @a[scores={mqp.trigger.kill_all_mob.kill_all_mob=1..}] mqp.trigger.kill_all_mob.kill_all_mob 0
scoreboard players enable @a mqp.trigger.kill_all_mob.kill_all_mob
