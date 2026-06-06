execute as @a[scores={mqp.trigger.easter_egg.count=1..}] run function mica_quick_panel:easter_egg/add_click_count
scoreboard players set @a[scores={mqp.trigger.easter_egg.count=1..}] mqp.trigger.easter_egg.count 0
scoreboard players enable @a mqp.trigger.easter_egg.count
