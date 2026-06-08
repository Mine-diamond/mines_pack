execute as @a[scores={mqp.trigger.take_entity.take_entity=0..}] run function mica_quick_panel:take_entity/execute
scoreboard players set @a[scores={mqp.trigger.take_entity.take_entity=0..}] mqp.trigger.take_entity.take_entity -1
scoreboard players enable @a mqp.trigger.take_entity.take_entity
