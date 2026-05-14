execute store result score #command_block_output mqp.game_rule.game_rule_state run gamerule command_block_output

execute if score #command_block_output mqp.game_rule.game_rule_state matches 0 run gamerule command_block_output true
execute if score #command_block_output mqp.game_rule.game_rule_state matches 1 run gamerule command_block_output false

execute if score #command_block_output mqp.game_rule.game_rule_state matches 0 run tellraw @a ["[快捷功能]",{"text": "已将§e[命令方块输出]§f调整为§btrue"}]
execute if score #command_block_output mqp.game_rule.game_rule_state matches 1 run tellraw @a ["[快捷功能]",{"text": "已将§e[命令方块输出]§f调整为§cfalse"}]