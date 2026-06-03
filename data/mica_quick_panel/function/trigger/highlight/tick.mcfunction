execute as @a[scores={mqp.trigger.highlight.entity_enabled_flags=1..}] run function mica_quick_panel:highlight/switch_entity_highlight
execute as @a[scores={mqp.trigger.highlight.entity_enabled_flags=1..}] run function mica_quick_panel:dialog/highlight_dialog/open_highlight_dialog
scoreboard players set @a[scores={mqp.trigger.highlight.entity_enabled_flags=1..}] mqp.trigger.highlight.entity_enabled_flags 0
scoreboard players enable @a mqp.trigger.highlight.entity_enabled_flags

execute as @a[scores={mqp.trigger.highlight.player_enabled_flags=1..}] run function mica_quick_panel:highlight/switch_player_highlight
execute as @a[scores={mqp.trigger.highlight.player_enabled_flags=1..}] run function mica_quick_panel:dialog/highlight_dialog/open_highlight_dialog
scoreboard players set @a[scores={mqp.trigger.highlight.player_enabled_flags=1..}] mqp.trigger.highlight.player_enabled_flags 0
scoreboard players enable @a mqp.trigger.highlight.player_enabled_flags

execute as @a[scores={mqp.trigger.highlight.item_enabled_flags=1..}] run function mica_quick_panel:highlight/switch_item_highlight
execute as @a[scores={mqp.trigger.highlight.item_enabled_flags=1..}] run function mica_quick_panel:dialog/highlight_dialog/open_highlight_dialog
scoreboard players set @a[scores={mqp.trigger.highlight.item_enabled_flags=1..}] mqp.trigger.highlight.item_enabled_flags 0
scoreboard players enable @a mqp.trigger.highlight.item_enabled_flags
