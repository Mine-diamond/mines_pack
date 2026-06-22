execute store result score #spawn_mobs mqp.game_rule.game_rule_state run gamerule spawn_mobs

execute if score #spawn_mobs mqp.game_rule.game_rule_state matches 0 run gamerule spawn_mobs true
execute if score #spawn_mobs mqp.game_rule.game_rule_state matches 1 run gamerule spawn_mobs false

execute if score #spawn_mobs mqp.game_rule.game_rule_state matches 0 run tellraw @a ["[快捷功能]",{"text": "已将§e[生物生成]§f调整为§btrue"}]
execute if score #spawn_mobs mqp.game_rule.game_rule_state matches 1 run tellraw @a ["[快捷功能]",{"text": "已将§e[生物生成]§f调整为§cfalse"}]