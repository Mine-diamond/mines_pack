execute store result score #advance_weather mqp.game_rule.game_rule_state run gamerule advance_weather

execute if score #advance_weather mqp.game_rule.game_rule_state matches 0 run gamerule advance_weather true
execute if score #advance_weather mqp.game_rule.game_rule_state matches 1 run gamerule advance_weather false

execute if score #advance_weather mqp.game_rule.game_rule_state matches 0 run tellraw @a ["[快捷功能]",{"text": "已将§e[天气更替]§f调整为§btrue"}]
execute if score #advance_weather mqp.game_rule.game_rule_state matches 1 run tellraw @a ["[快捷功能]",{"text": "已将§e[天气更替]§f调整为§cfalse"}]