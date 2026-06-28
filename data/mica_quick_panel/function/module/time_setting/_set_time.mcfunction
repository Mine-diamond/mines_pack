$time set $(time)
$execute unless score @s mqp.core.message_feedback matches 0 run tellraw @s ["[快捷功能]","时间已设置为", {"text": "$(time)", "color": "green"}]
