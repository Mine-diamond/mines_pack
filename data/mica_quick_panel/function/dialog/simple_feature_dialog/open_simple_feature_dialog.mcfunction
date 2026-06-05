data modify storage mqp:dialog simple_feature_dialog_prepare set value {}

execute if predicate mica_quick_panel:simple_feature/night_version run data modify storage mqp:dialog simple_feature_dialog_prepare.switch_night_version set from storage mqp:constant.word enable
execute unless predicate mica_quick_panel:simple_feature/night_version run data modify storage mqp:dialog simple_feature_dialog_prepare.switch_night_version set from storage mqp:constant.word disable

execute if score @s mqp.simple_feature.invulnerable_mode matches 1 run data modify storage mqp:dialog simple_feature_dialog_prepare.switch_invulnerable_mode set from storage mqp:constant.word enable
execute unless score @s mqp.simple_feature.invulnerable_mode matches 1 run data modify storage mqp:dialog simple_feature_dialog_prepare.switch_invulnerable_mode set from storage mqp:constant.word disable

execute if score @s mqp.simple_feature.run_mode matches 1 run data modify storage mqp:dialog simple_feature_dialog_prepare.switch_run_mode set from storage mqp:constant.word enable
execute unless score @s mqp.simple_feature.run_mode matches 1 run data modify storage mqp:dialog simple_feature_dialog_prepare.switch_run_mode set from storage mqp:constant.word disable

function mica_quick_panel:dialog/simple_feature_dialog/simple_feature_dialog with storage mqp:dialog simple_feature_dialog_prepare