data modify storage mqp:dialog way_point_dialog_prepare set value {}

function mica_quick_panel:dialog/way_point_dialog/read_way_point_start

data modify storage mqp:dialog way_point_dialog_prepare.all_actions set from storage mqp:way_point.dialog all_content
function mica_quick_panel:module/way_point/dialog/clear_content

function mica_quick_panel:dialog/way_point_dialog/way_point_dialog with storage mqp:dialog way_point_dialog_prepare