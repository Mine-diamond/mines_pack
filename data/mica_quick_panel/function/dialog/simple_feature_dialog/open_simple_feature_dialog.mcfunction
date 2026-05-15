execute if predicate mica_quick_panel:simple_feature/night_version run data modify storage map:dialog.simple_feature switch_word_prepare merge value {"switch_night_version":"§b启用"}
execute unless predicate mica_quick_panel:simple_feature/night_version run data modify storage map:dialog.simple_feature switch_word_prepare merge value {"switch_night_version":"§c禁用"}

execute if score @s mqp.simple_feature.invulnerable_mode matches 1 run data modify storage map:dialog.simple_feature switch_word_prepare merge value {"switch_invulnerable_mode":"§b启用"}
execute unless score @s mqp.simple_feature.invulnerable_mode matches 1 run data modify storage map:dialog.simple_feature switch_word_prepare merge value {"switch_invulnerable_mode":"§c禁用"}

execute if score @s mqp.simple_feature.run_mode matches 1 run data modify storage map:dialog.simple_feature switch_word_prepare merge value {"switch_run_mode":"§b启用"}
execute unless score @s mqp.simple_feature.run_mode matches 1 run data modify storage map:dialog.simple_feature switch_word_prepare merge value {"switch_run_mode":"§c禁用"}

function mica_quick_panel:dialog/simple_feature_dialog/simple_feature_dialog with storage map:dialog.simple_feature switch_word_prepare