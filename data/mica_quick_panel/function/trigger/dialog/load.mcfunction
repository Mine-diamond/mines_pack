scoreboard objectives add mqp.dialog.game_rule trigger
scoreboard objectives modify mqp.dialog.game_rule displayname "游戏规则设置面板"
scoreboard players enable @a mqp.dialog.game_rule

scoreboard objectives add mqp.game_rule.random_tick_speed trigger
scoreboard objectives modify mqp.game_rule.random_tick_speed displayname "随机刻速度设置面板"
scoreboard players enable @a mqp.game_rule.random_tick_speed

scoreboard objectives add mqp.dialog.simple_feature trigger
scoreboard objectives modify mqp.dialog.simple_feature displayname "功能设置面板"
scoreboard players enable @a mqp.dialog.simple_feature

scoreboard objectives add mqp.dialog.time_setting trigger
scoreboard objectives modify mqp.dialog.time_setting displayname "时间设置面板"
scoreboard players enable @a mqp.dialog.time_setting

scoreboard objectives add mqp.dialog.moon_phase trigger
scoreboard objectives modify mqp.dialog.moon_phase displayname "设置月相"
scoreboard players enable @a mqp.dialog.moon_phase

scoreboard objectives add mqp.dialog.highlight trigger
scoreboard objectives modify mqp.dialog.highlight displayname "高亮设置面板"
scoreboard players enable @a mqp.dialog.highlight

scoreboard objectives add mqp.dialog.kill_all_mob trigger
scoreboard objectives modify mqp.dialog.kill_all_mob displayname "清理实体确认面板"
scoreboard players enable @a mqp.dialog.kill_all_mob
