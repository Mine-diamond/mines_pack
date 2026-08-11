function mica_quick_panel:module/game_rule/_detect_advance_time

execute if score #advance_time mqp.game_rule.game_rule_state matches 1 run time pause
execute if score #advance_time mqp.game_rule.game_rule_state matches 0 run time resume
execute if score #advance_time mqp.game_rule.game_rule_state matches 0 run gamerule advance_time true

execute if score #advance_time mqp.game_rule.game_rule_state matches 0 as @a unless score @s mqp.core.message_feedback matches 0 run tellraw @s {"text": "[快捷功能]已将§e[游戏内时间流逝]§f调整为§btrue"}
execute if score #advance_time mqp.game_rule.game_rule_state matches 1 as @a unless score @s mqp.core.message_feedback matches 0 run tellraw @s {"text": "[快捷功能]已将§e[游戏内时间流逝]§f调整为§cfalse"}
