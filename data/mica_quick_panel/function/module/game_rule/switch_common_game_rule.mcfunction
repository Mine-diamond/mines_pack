$execute store result score #$(game_rule) mqp.game_rule.game_rule_state run gamerule $(game_rule)

$execute if score #$(game_rule) mqp.game_rule.game_rule_state matches 0 run gamerule $(game_rule) true
$execute if score #$(game_rule) mqp.game_rule.game_rule_state matches 1 run gamerule $(game_rule) false

$execute if score #$(game_rule) mqp.game_rule.game_rule_state matches 0 as @a unless score @s mqp.core.message_feedback matches 0 run tellraw @s ["[快捷功能]",{"text": "已将§e[$(game_rule_name)]§f调整为§btrue"}]
$execute if score #$(game_rule) mqp.game_rule.game_rule_state matches 1 as @a unless score @s mqp.core.message_feedback matches 0 run tellraw @s ["[快捷功能]",{"text": "已将§e[$(game_rule_name)]§f调整为§cfalse"}]