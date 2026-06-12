execute if data storage mqp:clear_entity {close_mob_loot:1} run data modify storage mqp:dialog clear_entity_dialog_prepare.switch_mob_loot set from storage mqp:constant.word off
execute unless data storage mqp:clear_entity {close_mob_loot:1} run data modify storage mqp:dialog clear_entity_dialog_prepare.switch_mob_loot set from storage mqp:constant.word on

execute if data storage mqp:clear_entity {kill_type:0} run data modify storage mqp:dialog clear_entity_dialog_prepare merge value {switch_kill_type:"全部实体"}
execute if data storage mqp:clear_entity {kill_type:1} run data modify storage mqp:dialog clear_entity_dialog_prepare merge value {switch_kill_type:"除物品外"}
execute if data storage mqp:clear_entity {kill_type:2} run data modify storage mqp:dialog clear_entity_dialog_prepare merge value {switch_kill_type:"仅物品"}

function mica_quick_panel:dialog/clear_entity_dialog/clear_entity_dialog with storage mqp:dialog clear_entity_dialog_prepare