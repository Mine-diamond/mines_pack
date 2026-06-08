scoreboard objectives add mqp.constant.number dummy
scoreboard players set #0 mqp.constant.number 0
scoreboard players set #1 mqp.constant.number 1
scoreboard players set #5 mqp.constant.number 5
scoreboard players set #8 mqp.constant.number 8
scoreboard players set #10 mqp.constant.number 10
scoreboard players set #300 mqp.constant.number 300
scoreboard players set #24000 mqp.constant.number 24000

scoreboard objectives add mqp.calc dummy

scoreboard objectives add mqp.temp dummy


data merge storage mqp:constant.word {enable:"§b启用",disable:"§c禁用",on:"§b开启",off:"§c关闭"}