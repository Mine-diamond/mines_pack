execute store result storage mica_quick_panel:time_setting time_setting_prepare.current_time int 1 run time query daytime
data modify storage mica_quick_panel:time_setting time_setting_prepare.time set value "$(time)"

function mica_quick_panel:dialog/time_setting_dialog/time_setting_dialog with storage mica_quick_panel:time_setting time_setting_prepare