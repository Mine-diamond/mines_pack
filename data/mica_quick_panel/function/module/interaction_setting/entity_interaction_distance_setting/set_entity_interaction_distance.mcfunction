$attribute @s entity_interaction_range base set $(entity_interaction_range)
$tellraw @s ["","[快捷功能]","实体交互距离已设置为",{"text":"$(entity_interaction_range)","color":"green"}]

function mica_quick_panel:dialog/interaction_setting_dialog/open_entity_interaction_setting_dialog