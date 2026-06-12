scoreboard players operation #temp mqp.calc = @s mqp.trigger.teleport_to_look_at.teleport
scoreboard players operation #temp mqp.calc *= #5 mqp.constant.number

execute store result storage mqp:teleport_to_look_at max_step int 1 run scoreboard players get #temp mqp.calc

function mica_quick_panel:teleport_to_look_at/execute