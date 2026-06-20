data modify storage mqp:dialog rename_name_tag_common_dialog_prepare.initial set from storage mqp:item.advanced_name_tag raw
data modify storage mqp:dialog rename_name_tag_common_dialog_prepare.preview set from storage mqp:item.advanced_name_tag preview

# tellraw @a ["预览",{"storage":"mqp:item.advanced_name_tag",nbt:"preview"}]

data merge storage mqp:item.advanced_name_tag {"raw":"",preview:""}