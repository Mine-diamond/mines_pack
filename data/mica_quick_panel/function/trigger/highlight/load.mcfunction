scoreboard objectives add mqp.trigger.highlight.entity_enabled_flags trigger
scoreboard objectives modify mqp.trigger.highlight.entity_enabled_flags displayname "切换实体高亮"
scoreboard players enable @a mqp.trigger.highlight.entity_enabled_flags

scoreboard objectives add mqp.trigger.highlight.player_enabled_flags trigger
scoreboard objectives modify mqp.trigger.highlight.player_enabled_flags displayname "切换玩家高亮"
scoreboard players enable @a mqp.trigger.highlight.player_enabled_flags

scoreboard objectives add mqp.trigger.highlight.item_enabled_flags trigger
scoreboard objectives modify mqp.trigger.highlight.item_enabled_flags displayname "切换物品高亮"
scoreboard players enable @a mqp.trigger.highlight.item_enabled_flags