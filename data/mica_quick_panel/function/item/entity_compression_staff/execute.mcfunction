function mica_quick_panel:util/copy_entity/start with entity @s SelectedItem.components."minecraft:custom_data"
tag @s add mqp.copy_entity
schedule function mica_quick_panel:item/entity_compression_staff/revoke_advancement 5 replace