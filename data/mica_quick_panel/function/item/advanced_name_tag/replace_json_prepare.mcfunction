$data modify storage mqp:util.str.replace input set value '$(name)'
data modify storage mqp:util.str.replace from set value "&"
data modify storage mqp:util.str.replace to set value "§"

function mica_quick_panel:util/str/replace/start
# tellraw @a ["输出：",{storage:"mqp:util.str.replace",nbt:"result"}]

data modify storage mqp:item.advanced_name_tag name set from storage mqp:util.str.replace result
function mica_quick_panel:item/advanced_name_tag/replace_json with storage mqp:item.advanced_name_tag
function mica_quick_panel:util/dialog/close_dialog