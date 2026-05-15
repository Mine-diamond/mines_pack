data modify storage map:dialog.game_rule switch_word set value ["启用","禁用"]
data modify storage mqp:dialog.game_rule random_tick_speed_prepare set value {}

scoreboard objectives add mqp.constant.number dummy
scoreboard players set #8 mqp.constant.number 8
scoreboard players set #300 mqp.constant.number 300
scoreboard players set #24000 mqp.constant.number 24000

scoreboard objectives add mqp.calc dummy

scoreboard objectives add mqp.temp dummy