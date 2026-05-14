scoreboard objectives add mqp.dialog.game_rule trigger
scoreboard objectives modify mqp.dialog.game_rule displayname "游戏规则设置面板"
scoreboard players enable @a mqp.dialog.game_rule

scoreboard objectives add mqp.game_rule.random_tick_speed trigger
scoreboard objectives modify mqp.game_rule.random_tick_speed displayname "随机刻速度设置面板"
scoreboard players enable @a mqp.game_rule.random_tick_speed

scoreboard objectives add mqp.dialog.simple_feature trigger
scoreboard objectives modify mqp.dialog.simple_feature displayname "功能设置面板"
scoreboard players enable @a mqp.dialog.simple_feature