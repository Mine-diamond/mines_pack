function mica_quick_panel:teleport_to_look_at/start with entity @s SelectedItem.components."minecraft:custom_data"
tag @s add mqp.gaze_shift_staff
schedule function mica_quick_panel:item/gaze_shift_staff/revoke_advancement 5 replace