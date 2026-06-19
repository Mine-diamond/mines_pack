data merge storage mqp:util.nbt.check_type {int_array:[I;0,0]}
execute store success score #temp mqp.temp run data modify storage mqp:util.nbt.check_type int_array append from storage mqp:util.nbt.check_type value
return run scoreboard players get #temp mqp.temp