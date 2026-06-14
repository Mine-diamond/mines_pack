$execute if data storage mqp:util.copy_entity {custom_name:""} run give @s $(entity_type)_spawn_egg[entity_data=$(entity_data),item_name=[{"text":"被带走的",italic:false},{"translate":"entity.minecraft.$(pure_entity_type)"}]]
$execute unless data storage mqp:util.copy_entity {custom_name:""} run give @s $(entity_type)_spawn_egg[entity_data=$(entity_data),item_name=[{"text":"被带走的",italic:false},{"text":"$(custom_name)",italic:true}]]

# say 执行到这里！

$execute if data storage mqp:util.copy_entity {custom_name:""} run data modify storage mqp_actionbar:api msg set value [{text:"已带走",color:"green"},{"translate":"entity.minecraft.$(pure_entity_type)"}]
$execute unless data storage mqp:util.copy_entity {custom_name:""} run data modify storage mqp_actionbar:api msg set value [{text:"已带走",color:"green"},{"text":"$(custom_name)",italic:true}]
data modify storage mqp_actionbar:api duration set value 40
data modify storage mqp_actionbar:api source set value "copy_entity"
function mqp_actionbar:timed/add_timed