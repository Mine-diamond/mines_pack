# out = out + to
$data modify storage mqp:util.str.replace out set value '$(out)$(to)'
# $tellraw @a "$(char)->$(to)"