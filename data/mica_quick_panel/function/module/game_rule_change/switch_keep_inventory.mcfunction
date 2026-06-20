execute store result score #keep_inventory mqp.game_rule.game_rule_state run gamerule keep_inventory

execute if score #keep_inventory mqp.game_rule.game_rule_state matches 0 run gamerule keep_inventory true
execute if score #keep_inventory mqp.game_rule.game_rule_state matches 1 run gamerule keep_inventory false

execute if score #keep_inventory mqp.game_rule.game_rule_state matches 0 run tellraw @a ["[快捷功能]",{"text": "已将§e[死亡不掉落]§f调整为§btrue"}]
execute if score #keep_inventory mqp.game_rule.game_rule_state matches 1 run tellraw @a ["[快捷功能]",{"text": "已将§e[死亡不掉落]§f调整为§cfalse"}]