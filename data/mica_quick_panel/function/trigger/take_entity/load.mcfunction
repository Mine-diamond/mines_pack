scoreboard objectives add mqp.trigger.take_entity.take_entity trigger
scoreboard objectives modify mqp.trigger.take_entity.take_entity displayname "带走生物"
scoreboard players enable @a mqp.trigger.take_entity.take_entity
scoreboard players set @a mqp.trigger.take_entity.take_entity -1
