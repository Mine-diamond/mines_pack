execute as @a[predicate=mica_quick_panel:interaction_setting/need_reduce_block_interaction_distance] run attribute @s block_interaction_range modifier add mqp:remove_create_distance -0.5 add_value
execute as @a[predicate=!mica_quick_panel:interaction_setting/need_reduce_block_interaction_distance] run attribute @s block_interaction_range modifier remove mqp:remove_create_distance

execute as @a[predicate=mica_quick_panel:interaction_setting/need_reduce_entity_interaction_distance] run attribute @s entity_interaction_range modifier add mqp:remove_create_distance -2 add_value
execute as @a[predicate=!mica_quick_panel:interaction_setting/need_reduce_entity_interaction_distance] run attribute @s entity_interaction_range modifier remove mqp:remove_create_distance