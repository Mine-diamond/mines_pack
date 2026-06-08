# loop
# tellraw @a ["step: ",{score:{name:"#step",objective:"mqp.util.entity_projection"}}]

execute store success score #temp mqp.temp if entity @e[distance=..0.5]
execute if score #temp mqp.temp matches 1 as @e[distance=..0.5] run function mica_quick_panel:util/entity_projection/check_entity_type with storage mqp:util.entity_projection

execute store success score #temp mqp.temp if entity @e[tag=mqp.entity_projection.target]
execute if score #temp mqp.temp matches 1 as @e[tag=mqp.entity_projection.target,limit=1] run function mica_quick_panel:util/entity_projection/execute with storage mqp:util.entity_projection
execute if score #temp mqp.temp matches 1 run tag @e[tag=mqp.entity_projection.target] remove mqp.entity_projection.target
execute if score #temp mqp.temp matches 1 run return 1

scoreboard players remove #step mqp.util.entity_projection 1

execute store success score #temp mqp.temp if score #step mqp.util.entity_projection matches 0
execute if score #temp mqp.temp matches 1 run function mica_quick_panel:util/entity_projection/execute_on_fail with storage mqp:util.entity_projection
execute if score #temp mqp.temp matches 1 run return 0

return run execute positioned ^ ^ ^0.2 run function mica_quick_panel:util/entity_projection/loop