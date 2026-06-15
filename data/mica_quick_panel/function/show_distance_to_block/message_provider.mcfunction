execute unless score @s mqp.show_distance_to_block.enable matches 1 run return fail
execute unless score @s mqp.show_distance_to_block.max_step matches 1.. run return fail

execute if score @s mqp.show_distance_to_block.current_distance matches -1 run data modify storage mqp_actionbar:api msg set value {text:"据方块距离: 前方没有方块"}
execute unless score @s mqp.show_distance_to_block.current_distance matches -1 run data modify storage mqp_actionbar:api msg set value [{text:"据方块距离: "},{score:{name:"@s",objective:"mqp.show_distance_to_block.current_distance"}}]
function mqp_actionbar:add