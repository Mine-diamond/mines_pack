execute if data storage mqp:highlight {EntityEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_entity set value "§b开启"
execute unless data storage mqp:highlight {EntityEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_entity set value "§c关闭"

execute if data storage mqp:highlight {ItemEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_item set value "§b开启"
execute unless data storage mqp:highlight {ItemEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_item set value "§c关闭"

execute if data storage mqp:highlight {PlayerEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_player set value "§b开启"
execute unless data storage mqp:highlight {PlayerEnabledFlags:1} run data modify storage mqp:highlight highlight_dialog_prepare.switch_player set value "§c关闭"

function mica_quick_panel:dialog/highlight_dialog/highlight_dialog with storage mqp:highlight highlight_dialog_prepare