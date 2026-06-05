function mica_quick_panel:game_rule_change/detect
data modify storage mqp:dialog game_rule_dialog_prepare set value {}

execute if score #advance_time mqp.game_rule.game_rule_state matches 0 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_advance_time set from storage mqp:constant.word off
execute if score #advance_time mqp.game_rule.game_rule_state matches 1 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_advance_time set from storage mqp:constant.word on
execute if score #advance_weather mqp.game_rule.game_rule_state matches 0 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_advance_weather set from storage mqp:constant.word off
execute if score #advance_weather mqp.game_rule.game_rule_state matches 1 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_advance_weather set from storage mqp:constant.word on
execute if score #spawn_mobs mqp.game_rule.game_rule_state matches 0 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_spawn_mobs set from storage mqp:constant.word off
execute if score #spawn_mobs mqp.game_rule.game_rule_state matches 1 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_spawn_mobs set from storage mqp:constant.word on
execute if score #keep_inventory mqp.game_rule.game_rule_state matches 0 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_keep_inventory set from storage mqp:constant.word off
execute if score #keep_inventory mqp.game_rule.game_rule_state matches 1 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_keep_inventory set from storage mqp:constant.word on
execute if score #command_block_output mqp.game_rule.game_rule_state matches 0 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_command_block_output set from storage mqp:constant.word off
execute if score #command_block_output mqp.game_rule.game_rule_state matches 1 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_command_block_output set from storage mqp:constant.word on
execute if score #mob_drops mqp.game_rule.game_rule_state matches 0 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_mob_drops set from storage mqp:constant.word off
execute if score #mob_drops mqp.game_rule.game_rule_state matches 1 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_mob_drops set from storage mqp:constant.word on
execute if score #block_drops mqp.game_rule.game_rule_state matches 0 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_block_drops set from storage mqp:constant.word off
execute if score #block_drops mqp.game_rule.game_rule_state matches 1 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_block_drops set from storage mqp:constant.word on
execute if score #show_advancement_messages mqp.game_rule.game_rule_state matches 0 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_show_advancement_messages set from storage mqp:constant.word off
execute if score #show_advancement_messages mqp.game_rule.game_rule_state matches 1 run data modify storage mqp:dialog game_rule_dialog_prepare.switch_show_advancement_messages set from storage mqp:constant.word on

function mica_quick_panel:dialog/gamerule_dialog/game_rule_dialog with storage mqp:dialog game_rule_dialog_prepare