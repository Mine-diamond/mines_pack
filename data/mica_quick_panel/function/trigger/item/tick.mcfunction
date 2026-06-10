execute as @a[scores={mqp.trigger.item.entity_compression_staff.get=1..}] run function mica_quick_panel:item/entity_compression_staff/give_prepare
scoreboard players set @a[scores={mqp.trigger.item.entity_compression_staff.get=1..}] mqp.trigger.item.entity_compression_staff.get 0
scoreboard players enable @a mqp.trigger.item.entity_compression_staff.get

execute as @a[scores={mqp.trigger.item.advanced_name_tag.get=1..}] run function mica_quick_panel:item/advanced_name_tag/give
scoreboard players set @a[scores={mqp.trigger.item.advanced_name_tag.get=1..}] mqp.trigger.item.advanced_name_tag.get 0
scoreboard players enable @a mqp.trigger.item.advanced_name_tag.get
