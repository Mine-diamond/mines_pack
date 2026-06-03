scoreboard objectives add mqp.trigger.kill_all_mob.close_mob_loot trigger
scoreboard objectives modify mqp.trigger.kill_all_mob.close_mob_loot displayname "切换击杀生物是否掉落物品"
scoreboard players enable @a mqp.trigger.kill_all_mob.close_mob_loot

scoreboard objectives add mqp.trigger.kill_all_mob.kill_type trigger
scoreboard objectives modify mqp.trigger.kill_all_mob.kill_type displayname "切换清除类型"
scoreboard players enable @a mqp.trigger.kill_all_mob.kill_type

scoreboard objectives add mqp.trigger.kill_all_mob.kill_all_mob trigger
scoreboard objectives modify mqp.trigger.kill_all_mob.kill_all_mob displayname "清除生物"
scoreboard players enable @a mqp.trigger.kill_all_mob.kill_all_mob
