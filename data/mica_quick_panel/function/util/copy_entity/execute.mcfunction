data merge storage mqp:util.entity_projection {execute_function:"mica_quick_panel:util/copy_entity/process_entity_data",execute_on_fail_function:"mica_quick_panel:util/copy_entity/execute_on_fail",inverse_selection:1,entity_type_tag:"#mica_quick_panel:entity_has_no_spawn_egg"}

execute store result storage mqp:util.copy_entity success int 1 run function mica_quick_panel:util/entity_projection/start
execute if data storage mqp:util.copy_entity {success:1} run function mica_quick_panel:util/copy_entity/give_spawn_egg with storage mqp:util.copy_entity