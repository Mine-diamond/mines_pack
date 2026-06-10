# out = out + char
$data modify storage mqp:util.str.replace out set value '$(out)$(char)'
# $tellraw @a "$(char)->$(char)"