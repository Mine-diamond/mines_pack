data modify storage mqp:temp first_char set string storage mqp:util.copy_entity pure_entity_type 0 1

execute if data storage mqp:temp {first_char:":"} run data modify storage mqp:util.copy_entity pure_entity_type set string storage mqp:util.copy_entity pure_entity_type 1
execute if data storage mqp:temp {first_char:":"} run return 1

data modify storage mqp:util.copy_entity pure_entity_type set string storage mqp:util.copy_entity pure_entity_type 1

function mica_quick_panel:util/copy_entity/get_pure_type_loop