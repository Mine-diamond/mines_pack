scoreboard players set #number mqp.calc 0

execute store result score #temp mqp.temp unless data storage mqp_wp:data waypoints
execute if score #temp mqp.temp matches 0 store result score #temp mqp.temp if data storage mqp_wp:data {waypoints:[]}
execute if score #temp mqp.temp matches 1 run data merge storage mqp:way_point.dialog {all_content:""}
execute if score #temp mqp.temp matches 1 run return 1

data modify storage mqp:way_point.dialog waypoints set from storage mqp_wp:data waypoints

function mica_quick_panel:dialog/way_point_dialog/read_way_point_loop