$data modify storage mqp:dialog way_point_edit_dialog_prepare merge from storage mqp_wp:data waypoints[$(index)]

scoreboard players set #temp mqp.temp 0
execute if data storage mqp:dialog {way_point_edit_dialog_prepare:{dim:"minecraft:overworld"}} run scoreboard players set #temp mqp.temp 1
execute if data storage mqp:dialog {way_point_edit_dialog_prepare:{dim:"minecraft:the_nether"}} run scoreboard players set #temp mqp.temp 2
execute if data storage mqp:dialog {way_point_edit_dialog_prepare:{dim:"minecraft:the_end"}} run scoreboard players set #temp mqp.temp 3

data merge storage mqp:dialog {way_point_edit_dialog_prepare:{dim_id_initial_1:"",dim_id_initial_2:"",dim_id_initial_3:""}}

execute if score #temp mqp.temp matches 0..1 run data merge storage mqp:dialog {way_point_edit_dialog_prepare:{dim_id_initial_1:',"initial": true'}}
execute if score #temp mqp.temp matches 2 run data merge storage mqp:dialog {way_point_edit_dialog_prepare:{dim_id_initial_2:',"initial": true'}}
execute if score #temp mqp.temp matches 3 run data merge storage mqp:dialog {way_point_edit_dialog_prepare:{dim_id_initial_3:',"initial": true'}}

execute if score #temp mqp.temp matches 0 run data modify storage mqp:dialog way_point_edit_dialog_prepare.custom_dim set from storage mqp:dialog way_point_edit_dialog_prepare.dim
execute unless score #temp mqp.temp matches 0 run data modify storage mqp:dialog way_point_edit_dialog_prepare.custom_dim set value ""
