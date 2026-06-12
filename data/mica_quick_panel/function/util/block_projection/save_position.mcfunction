summon marker ~ ~ ~ {Tags:["mqp.temp_marker"]}
execute store result storage mqp:util.block_projection pos[0] int 1 run data get entity @e[tag=mqp.temp_marker,limit=1] Pos[0]
execute store result storage mqp:util.block_projection pos[1] int 1 run data get entity @e[tag=mqp.temp_marker,limit=1] Pos[1]
execute store result storage mqp:util.block_projection pos[2] int 1 run data get entity @e[tag=mqp.temp_marker,limit=1] Pos[2]
kill @e[tag=mqp.temp_marker]

execute positioned ^ ^ ^-0.2 run summon marker ~ ~ ~ {Tags:["mqp.temp_marker"]}
execute store result storage mqp:util.block_projection pre_pos[0] int 1 run data get entity @e[tag=mqp.temp_marker,limit=1] Pos[0]
execute store result storage mqp:util.block_projection pre_pos[1] int 1 run data get entity @e[tag=mqp.temp_marker,limit=1] Pos[1]
execute store result storage mqp:util.block_projection pre_pos[2] int 1 run data get entity @e[tag=mqp.temp_marker,limit=1] Pos[2]
kill @e[tag=mqp.temp_marker]