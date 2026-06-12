execute if data storage mqp:highlight {entity_enabled_flags:1} run data modify storage mqp:dialog highlight_dialog_prepare.switch_entity set from storage mqp:constant.word on
execute unless data storage mqp:highlight {entity_enabled_flags:1} run data modify storage mqp:dialog highlight_dialog_prepare.switch_entity set from storage mqp:constant.word off

execute if data storage mqp:highlight {item_enabled_flags:1} run data modify storage mqp:dialog highlight_dialog_prepare.switch_item set from storage mqp:constant.word on
execute unless data storage mqp:highlight {item_enabled_flags:1} run data modify storage mqp:dialog highlight_dialog_prepare.switch_item set from storage mqp:constant.word off

execute if data storage mqp:highlight {player_enabled_flags:1} run data modify storage mqp:dialog highlight_dialog_prepare.switch_player set from storage mqp:constant.word on
execute unless data storage mqp:highlight {player_enabled_flags:1} run data modify storage mqp:dialog highlight_dialog_prepare.switch_player set from storage mqp:constant.word off

function mica_quick_panel:dialog/highlight_dialog/highlight_dialog with storage mqp:dialog highlight_dialog_prepare