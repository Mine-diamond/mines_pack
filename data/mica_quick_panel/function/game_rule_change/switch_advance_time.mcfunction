execute store result score #advance_time mqp.game_rule.game_rule_state run gamerule advance_time
#tellraw @a {"score": {name: "#advance_time", objective: "mqp.game_rule.game_rule_state"}}

execute if score #advance_time mqp.game_rule.game_rule_state matches 0 run gamerule advance_time true
execute if score #advance_time mqp.game_rule.game_rule_state matches 1 run gamerule advance_time false

execute if score #advance_time mqp.game_rule.game_rule_state matches 0 run tellraw @a {"text": "[快捷功能]已将§e[游戏内时间流逝]§f调整为§btrue"}
execute if score #advance_time mqp.game_rule.game_rule_state matches 1 run tellraw @a {"text": "[快捷功能]已将§e[游戏内时间流逝]§f调整为§cfalse"}