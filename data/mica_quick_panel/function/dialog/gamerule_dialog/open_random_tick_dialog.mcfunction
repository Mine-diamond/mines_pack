data modify storage mqp:dialog.game_rule random_tick_speed_prepare set value {}

execute store result score #random_tick_speed mqp.game_rule.game_rule_state run gamerule random_tick_speed
execute if score #random_tick_speed mqp.game_rule.game_rule_state <= #300 mqp.constant.number store result storage mqp:dialog.game_rule random_tick_speed_prepare.initial int 1 run scoreboard players get #random_tick_speed mqp.game_rule.game_rule_state
execute unless score #random_tick_speed mqp.game_rule.game_rule_state <= #300 mqp.constant.number run data modify storage mqp:dialog.game_rule random_tick_speed_prepare.initial set value 3
data modify storage mqp:dialog.game_rule random_tick_speed_prepare.input set value "$(input)"

function mica_quick_panel:dialog/gamerule_dialog/random_tick_dialog with storage mqp:dialog.game_rule random_tick_speed_prepare