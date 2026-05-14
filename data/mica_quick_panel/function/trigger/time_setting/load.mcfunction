scoreboard objectives add mqp.trigger.time_setting trigger
scoreboard objectives modify mqp.trigger.time_setting displayname "设置时间"
scoreboard players set @a mqp.trigger.time_setting -1
scoreboard players enable @a mqp.trigger.time_setting

scoreboard objectives add mqp.trigger.moon_phase trigger
scoreboard objectives modify mqp.trigger.moon_phase displayname "设置月相"
scoreboard players set @a mqp.trigger.moon_phase -1
scoreboard players enable @a mqp.trigger.moon_phase