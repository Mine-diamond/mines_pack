execute store result storage mqp:dialog time_setting_dialog_prepare.current_time int 1 run time query daytime
data modify storage mqp:dialog time_setting_dialog_prepare.time set value "$(time)"

function mica_quick_panel:dialog/time_setting_dialog/time_setting_dialog with storage mqp:dialog time_setting_dialog_prepare