$data merge storage mqp:way_point {args:{id:$(id),name:"$(name)",dim_id:$(dim_id),custom_dim:"$(custom_dim)",x:$(x),y:$(y),z:$(z),yaw:$(yaw),pitch:$(pitch)}}

execute store result score #temp mqp.temp if data storage mqp:way_point {args:{custom_dim:""}}
execute if score #temp mqp.temp matches 1 store result score #temp mqp.temp run data get storage mqp:way_point args.dim_id

execute if score #temp mqp.temp matches 0 run data modify storage mqp:way_point args.dim set from storage mqp:way_point args.custom_dim
execute if score #temp mqp.temp matches 1 run data merge storage mqp:way_point {args:{dim:"minecraft:overworld"}}
execute if score #temp mqp.temp matches 2 run data merge storage mqp:way_point {args:{dim:"minecraft:the_nether"}}
execute if score #temp mqp.temp matches 3 run data merge storage mqp:way_point {args:{dim:"minecraft:the_end"}}

data remove storage mqp:way_point args.dim_id
data remove storage mqp:way_point args.custom_dim

data remove storage mqp_wp:args input
data modify storage mqp_wp:args input set from storage mqp:way_point args

function mqp_wp:op/all

function mica_quick_panel:dialog/way_point_dialog/open_way_point_dialog