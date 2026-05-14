execute store result score #block_drops mqp.game_rule.game_rule_state run gamerule block_drops

execute if score #block_drops mqp.game_rule.game_rule_state matches 0 run gamerule block_drops true
execute if score #block_drops mqp.game_rule.game_rule_state matches 1 run gamerule block_drops false

execute if score #block_drops mqp.game_rule.game_rule_state matches 0 run tellraw @a ["[快捷功能]",{"text": "已将§e[方块掉落物]§f调整为§btrue"}]
execute if score #block_drops mqp.game_rule.game_rule_state matches 1 run tellraw @a ["[快捷功能]",{"text": "已将§e[方块掉落物]§f调整为§cfalse"}]