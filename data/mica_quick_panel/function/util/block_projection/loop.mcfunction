# loop
# tellraw @a ["step: ",{score:{name:"#step",objective:"mqp.util.block_projection"}}]

execute unless block ~ ~ ~ #air run function mica_quick_panel:util/block_projection/check_block_type with storage mqp:util.block_projection

execute store success score #temp mqp.temp if data storage mqp:util.block_projection {success:1}
execute if score #temp mqp.temp matches 1 run function mica_quick_panel:util/block_projection/save_position
execute if score #temp mqp.temp matches 1 run function mica_quick_panel:util/block_projection/save_distance
execute if score #temp mqp.temp matches 1 run return 1

scoreboard players add #step mqp.util.block_projection 1

execute if score #step mqp.util.block_projection = #max_step mqp.util.block_projection run return 0

return run execute positioned ^ ^ ^0.2 run function mica_quick_panel:util/block_projection/loop