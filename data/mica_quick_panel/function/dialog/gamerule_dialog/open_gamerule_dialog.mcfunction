function mica_quick_panel:game_rule_change/detect

execute if score #advance_time mqp.game_rule.game_rule_state matches 0 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_advance_time":"§c禁用"}
execute if score #advance_time mqp.game_rule.game_rule_state matches 1 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_advance_time":"§b启用"}
execute if score #advance_weather mqp.game_rule.game_rule_state matches 0 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_advance_weather":"§c禁用"}
execute if score #advance_weather mqp.game_rule.game_rule_state matches 1 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_advance_weather":"§b启用"}
execute if score #spawn_mobs mqp.game_rule.game_rule_state matches 0 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_spawn_mobs":"§c禁用"}
execute if score #spawn_mobs mqp.game_rule.game_rule_state matches 1 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_spawn_mobs":"§b启用"}
execute if score #keep_inventory mqp.game_rule.game_rule_state matches 0 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_keep_inventory":"§c禁用"}
execute if score #keep_inventory mqp.game_rule.game_rule_state matches 1 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_keep_inventory":"§b启用"}
execute if score #command_block_output mqp.game_rule.game_rule_state matches 0 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_command_block_output":"§c禁用"}
execute if score #command_block_output mqp.game_rule.game_rule_state matches 1 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_command_block_output":"§b启用"}
execute if score #mob_drops mqp.game_rule.game_rule_state matches 0 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_mob_drops":"§c禁用"}
execute if score #mob_drops mqp.game_rule.game_rule_state matches 1 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_mob_drops":"§b启用"}
execute if score #block_drops mqp.game_rule.game_rule_state matches 0 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_block_drops":"§c禁用"}
execute if score #block_drops mqp.game_rule.game_rule_state matches 1 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_block_drops":"§b启用"}
execute if score #show_advancement_messages mqp.game_rule.game_rule_state matches 0 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_show_advancement_messages":"§c禁用"}
execute if score #show_advancement_messages mqp.game_rule.game_rule_state matches 1 run data modify storage map:dialog.game_rule switch_word_prepare merge value {"switch_show_advancement_messages":"§b启用"}

function mica_quick_panel:dialog/gamerule_dialog/game_rule_dialog with storage map:dialog.game_rule switch_word_prepare