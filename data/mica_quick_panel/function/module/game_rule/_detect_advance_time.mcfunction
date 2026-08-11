#1->on 0->off
execute store result score #_advance_time mqp.game_rule.game_rule_state run gamerule advance_time
execute store success score #time_resume mqp.game_rule.game_rule_state run time pause
execute if score #time_resume mqp.game_rule.game_rule_state matches 1 run time resume

scoreboard players set #advance_time mqp.game_rule.game_rule_state 0
execute if score #time_resume mqp.game_rule.game_rule_state matches 1 if score #_advance_time mqp.game_rule.game_rule_state matches 1 run scoreboard players set #advance_time mqp.game_rule.game_rule_state 1