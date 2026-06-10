execute as @a[scores={mqp.trigger.util.close_dialog=1..}] run function mica_quick_panel:util/dialog/close_dialog
scoreboard players set @a[scores={mqp.trigger.util.close_dialog=1..}] mqp.trigger.util.close_dialog 0
scoreboard players enable @a mqp.trigger.util.close_dialog
