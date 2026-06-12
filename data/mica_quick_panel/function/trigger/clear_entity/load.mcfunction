scoreboard objectives add mqp.trigger.clear_entity.switch_mob_loot trigger
scoreboard objectives modify mqp.trigger.clear_entity.switch_mob_loot displayname "切换击杀生物是否掉落物品"
scoreboard players enable @a mqp.trigger.clear_entity.switch_mob_loot

scoreboard objectives add mqp.trigger.clear_entity.switch_kill_type trigger
scoreboard objectives modify mqp.trigger.clear_entity.switch_kill_type displayname "切换清除类型"
scoreboard players enable @a mqp.trigger.clear_entity.switch_kill_type

scoreboard objectives add mqp.trigger.clear_entity.clear_entity trigger
scoreboard objectives modify mqp.trigger.clear_entity.clear_entity displayname "清除生物"
scoreboard players enable @a mqp.trigger.clear_entity.clear_entity
