execute store result score #show_advancement_messages mqp.game_rule.game_rule_state run gamerule show_advancement_messages

execute if score #show_advancement_messages mqp.game_rule.game_rule_state matches 0 run gamerule show_advancement_messages true
execute if score #show_advancement_messages mqp.game_rule.game_rule_state matches 1 run gamerule show_advancement_messages false

execute if score #show_advancement_messages mqp.game_rule.game_rule_state matches 0 run tellraw @a ["[快捷功能]",{"text": "已将§e[进度消息公告]§f调整为§btrue"}]
execute if score #show_advancement_messages mqp.game_rule.game_rule_state matches 1 run tellraw @a ["[快捷功能]",{"text": "已将§e[进度消息公告]§f调整为§cfalse"}]