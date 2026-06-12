scoreboard players operation #temp mqp.calc = #step mqp.util.block_projection
execute store result storage mqp:util.block_projection distance double 0.1 run scoreboard players operation #temp mqp.calc *= #2 mqp.constant.number
execute store result storage mqp:util.block_projection int_distance int 1 run data get storage mqp:util.block_projection distance