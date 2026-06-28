execute as @a[scores={mqp.util.close_dialog=1..}] run function mica_quick_panel:util/dialog/close_dialog
scoreboard players set @a[scores={mqp.util.close_dialog=1..}] mqp.util.close_dialog 0
scoreboard players enable @a mqp.util.close_dialog
