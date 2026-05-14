execute store result score #mob_drops mqp.game_rule.game_rule_state run gamerule mob_drops

execute if score #mob_drops mqp.game_rule.game_rule_state matches 0 run gamerule mob_drops true
execute if score #mob_drops mqp.game_rule.game_rule_state matches 1 run gamerule mob_drops false

execute if score #mob_drops mqp.game_rule.game_rule_state matches 0 run tellraw @a ["[快捷功能]",{"text": "已将§e[生物掉落物]§f调整为§btrue"}]
execute if score #mob_drops mqp.game_rule.game_rule_state matches 1 run tellraw @a ["[快捷功能]",{"text": "已将§e[生物掉落物]§f调整为§cfalse"}]