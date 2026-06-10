$data modify storage mqp:util.str.replace input set value '$(name)'
data modify storage mqp:util.str.replace from set value "&"
data modify storage mqp:util.str.replace to set value "§"

function mica_quick_panel:util/str/replace/start
data modify storage mqp:item.advanced_name_tag name set from storage mqp:util.str.replace result