execute as @a[scores={mqp.trigger.clear_entity.switch_mob_loot=1..}] run function mica_quick_panel:clear_entity/switch_gen_drops
execute as @a[scores={mqp.trigger.clear_entity.switch_mob_loot=1..}] run function mica_quick_panel:dialog/clear_entity_dialog/open_clear_entity_dialog
scoreboard players set @a[scores={mqp.trigger.clear_entity.switch_mob_loot=1..}] mqp.trigger.clear_entity.switch_mob_loot 0
scoreboard players enable @a mqp.trigger.clear_entity.switch_mob_loot

execute as @a[scores={mqp.trigger.clear_entity.switch_kill_type=1..}] run function mica_quick_panel:clear_entity/switch_kill_type
execute as @a[scores={mqp.trigger.clear_entity.switch_kill_type=1..}] run function mica_quick_panel:dialog/clear_entity_dialog/open_clear_entity_dialog
scoreboard players set @a[scores={mqp.trigger.clear_entity.switch_kill_type=1..}] mqp.trigger.clear_entity.switch_kill_type 0
scoreboard players enable @a mqp.trigger.clear_entity.switch_kill_type

execute as @a[scores={mqp.trigger.clear_entity.clear_entity=1..}] run function mica_quick_panel:clear_entity/clear_entity
execute as @a[scores={mqp.trigger.clear_entity.clear_entity=1..}] run function mica_quick_panel:dialog/clear_entity_dialog/open_clear_entity_dialog
scoreboard players set @a[scores={mqp.trigger.clear_entity.clear_entity=1..}] mqp.trigger.clear_entity.clear_entity 0
scoreboard players enable @a mqp.trigger.clear_entity.clear_entity
