execute if data storage mqp:highlight {EntityEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_entity set from storage mqp:constant.word on
execute unless data storage mqp:highlight {EntityEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_entity set from storage mqp:constant.word off

execute if data storage mqp:highlight {ItemEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_item set from storage mqp:constant.word on
execute unless data storage mqp:highlight {ItemEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_item set from storage mqp:constant.word off

execute if data storage mqp:highlight {PlayerEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_player set from storage mqp:constant.word on
execute unless data storage mqp:highlight {PlayerEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_player set from storage mqp:constant.word off

function mica_quick_panel:dialog/highlight_dialog/highlight_dialog with storage mqp:highlight highlight_dialog_prepare