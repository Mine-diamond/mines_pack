execute unless data storage mqp:way_point.dialog waypoints[0] run return 0

scoreboard players add #number mqp.calc 1
execute store result storage mqp:way_point.dialog wp_info.number int 1 run scoreboard players get #number mqp.calc
data modify storage mqp:way_point.dialog wp_info.name set from storage mqp:way_point.dialog waypoints[0].name
execute if data storage mqp:way_point.dialog {wp_info:{name:""}} run function mica_quick_panel:dialog/way_point_dialog/set_default_wp_name with storage mqp:way_point.dialog wp_info

data remove storage mqp:way_point.dialog waypoints[0]
function mica_quick_panel:module/way_point/dialog/add_row_content with storage mqp:way_point.dialog wp_info
function mica_quick_panel:dialog/way_point_dialog/read_way_point_loop