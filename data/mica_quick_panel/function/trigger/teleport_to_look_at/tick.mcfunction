execute as @a[scores={mqp.trigger.teleport_to_look_at.teleport=1..}] run function mica_quick_panel:teleport_to_look_at/start_from_trigger
scoreboard players set @a[scores={mqp.trigger.teleport_to_look_at.teleport=1..}] mqp.trigger.teleport_to_look_at.teleport 0
scoreboard players enable @a mqp.trigger.teleport_to_look_at.teleport
