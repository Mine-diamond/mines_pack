data merge storage mqp:dialog {way_point_edit_dialog_prepare:{c_name:"$(c_name)",c_dim_id:"$(c_dim_id)",c_custom_dim:"$(c_custom_dim)",c_x:"$(c_x)",c_y:"$(c_y)",c_z:"$(c_z)",c_yaw:"$(c_yaw)",c_pitch:"$(c_pitch)"}}

execute store result storage mqp:dialog way_point_edit_dialog_prepare.id int 1 run scoreboard players get @s mqp.dialog.way_point_edit
execute store result score #temp mqp.calc run scoreboard players get @s mqp.dialog.way_point_edit
scoreboard players operation #temp mqp.calc -= #1 mqp.constant.number
execute store result storage mqp:dialog way_point_edit_dialog_prepare.index int 1 run scoreboard players get #temp mqp.calc
function mica_quick_panel:dialog/way_point_dialog/modify_wp_edit_info with storage mqp:dialog way_point_edit_dialog_prepare

function mica_quick_panel:dialog/way_point_dialog/way_point_edit_dialog with storage mqp:dialog way_point_edit_dialog_prepare
