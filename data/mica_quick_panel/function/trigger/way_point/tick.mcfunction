execute as @a[scores={mqp.trigger.way_point.tp=1..}] run function mica_quick_panel:module/way_point/trigger/tp
scoreboard players set @a[scores={mqp.trigger.way_point.tp=1..}] mqp.trigger.way_point.tp 0
scoreboard players enable @a mqp.trigger.way_point.tp

execute as @a[scores={mqp.trigger.way_point.new=1..}] run function mica_quick_panel:module/way_point/trigger/new
execute as @a[scores={mqp.trigger.way_point.new=1..}] run function mica_quick_panel:dialog/way_point_dialog/open_way_point_dialog
scoreboard players set @a[scores={mqp.trigger.way_point.new=1..}] mqp.trigger.way_point.new 0
scoreboard players enable @a mqp.trigger.way_point.new

execute as @a[scores={mqp.trigger.way_point.del=1..}] run function mica_quick_panel:module/way_point/trigger/del
execute as @a[scores={mqp.trigger.way_point.del=1..}] run function mica_quick_panel:dialog/way_point_dialog/open_way_point_dialog
scoreboard players set @a[scores={mqp.trigger.way_point.del=1..}] mqp.trigger.way_point.del 0
scoreboard players enable @a mqp.trigger.way_point.del

execute as @a[scores={mqp.trigger.way_point.up=1..}] run function mica_quick_panel:module/way_point/trigger/up
execute as @a[scores={mqp.trigger.way_point.up=1..}] run function mica_quick_panel:dialog/way_point_dialog/open_way_point_dialog
scoreboard players set @a[scores={mqp.trigger.way_point.up=1..}] mqp.trigger.way_point.up 0
scoreboard players enable @a mqp.trigger.way_point.up

execute as @a[scores={mqp.trigger.way_point.down=1..}] run function mica_quick_panel:module/way_point/trigger/down
execute as @a[scores={mqp.trigger.way_point.down=1..}] run function mica_quick_panel:dialog/way_point_dialog/open_way_point_dialog
scoreboard players set @a[scores={mqp.trigger.way_point.down=1..}] mqp.trigger.way_point.down 0
scoreboard players enable @a mqp.trigger.way_point.down
