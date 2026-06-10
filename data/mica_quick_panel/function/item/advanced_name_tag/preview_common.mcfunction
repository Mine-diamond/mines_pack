$function mica_quick_panel:item/advanced_name_tag/replace_char {name:'$(name)'}
function mica_quick_panel:item/advanced_name_tag/set_common_preview_text with storage mqp:item.advanced_name_tag

$data modify storage mqp:item.advanced_name_tag raw set value "$(name)"

function mica_quick_panel:dialog/raname_name_tag/open_rename_name_tag_common_dialog