summon armor_stand ~ ~ ~ {Marker:1b,NoGravity:1b,Tags:["mqp.temp_vehicle"]}

ride @s mount @e[tag=mqp.temp_vehicle,limit=1,distance=..1]

data modify storage mqp:util.copy_entity entity_type set from entity @e[tag=mqp.temp_vehicle,limit=1,distance=..1] Passengers[0].id
ride @s dismount
kill @e[tag=mqp.temp_vehicle,limit=1,distance=..1]



data modify storage mqp:util.copy_entity entity_data set from entity @s
data remove storage mqp:util.copy_entity entity_data.Pos

function mica_quick_panel:util/copy_entity/get_pure_type
data modify storage mqp:util.copy_entity entity_data.id set from storage mqp:util.copy_entity pure_entity_type
execute if data storage mqp:util.copy_entity entity_data.CustomName run data modify storage mqp:util.copy_entity custom_name set from storage mqp:util.copy_entity entity_data.CustomName
execute unless data storage mqp:util.copy_entity entity_data.CustomName run data merge storage mqp:util.copy_entity {custom_name:""}

execute if data storage mqp:util.copy_entity {remove_entity:1} run function mica_quick_panel:util/copy_entity/remove_entity

# tellraw @a ["类型: ",{"storage":"mqp:util.copy_entity",nbt:"entity_type"}]