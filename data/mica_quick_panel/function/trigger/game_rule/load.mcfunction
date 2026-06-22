scoreboard objectives add mqp.trigger.game_rule.change trigger
scoreboard objectives modify mqp.trigger.game_rule.change displayname "修改游戏规则"
scoreboard players enable @a mqp.trigger.game_rule.change

scoreboard objectives add mqp.trigger.game_rule.set_to_preferred trigger
scoreboard objectives modify mqp.trigger.game_rule.set_to_preferred displayname "设置为首选状态"
scoreboard players enable @a mqp.trigger.game_rule.set_to_preferred

scoreboard objectives add mqp.trigger.game_rule.set_random_tick_speed trigger
scoreboard objectives modify mqp.trigger.game_rule.set_random_tick_speed displayname "设置随机刻速度"
scoreboard players enable @a mqp.trigger.game_rule.set_random_tick_speed
scoreboard players set @a mqp.trigger.game_rule.set_random_tick_speed -1
