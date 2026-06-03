execute if data storage mqp:kill_all_mob {close_mob_loot:1} run data modify storage mqp:kill_all_mob kill_all_mob_dialog_prepare merge value {switch_mob_loot:"关闭"}
execute unless data storage mqp:kill_all_mob {close_mob_loot:1} run data modify storage mqp:kill_all_mob kill_all_mob_dialog_prepare merge value {switch_mob_loot:"开启"}

execute if data storage mqp:kill_all_mob {kill_type:0} run data modify storage mqp:kill_all_mob kill_all_mob_dialog_prepare merge value {switch_kill_type:"全部实体"}
execute if data storage mqp:kill_all_mob {kill_type:1} run data modify storage mqp:kill_all_mob kill_all_mob_dialog_prepare merge value {switch_kill_type:"除物品外"}
execute if data storage mqp:kill_all_mob {kill_type:2} run data modify storage mqp:kill_all_mob kill_all_mob_dialog_prepare merge value {switch_kill_type:"仅物品"}

function mica_quick_panel:dialog/kill_all_mob_dialog/kill_all_mob_dialog with storage mqp:kill_all_mob kill_all_mob_dialog_prepare