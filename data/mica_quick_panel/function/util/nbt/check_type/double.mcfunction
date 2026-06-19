data modify storage mqp:util.nbt.check_type stringified_value set string storage mqp:util.nbt.check_type value
data modify storage mqp:util.nbt.check_type last_char set string storage mqp:util.nbt.check_type stringified_value -1
execute if data storage mqp:util.nbt.check_type {last_char:d} run return 1
return 0