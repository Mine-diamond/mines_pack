$gamerule random_tick_speed $(input)
$execute as @a unless score @s mqp.core.message_feedback matches 0 run tellraw @s ["[快捷功能]",{"text": "已将§e[随机刻速度]§f调整为§b$(input)"}]
