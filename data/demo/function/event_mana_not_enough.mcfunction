data modify storage mqp_actionbar:api msg set value {"text":"魔力不足","color":"red"}
data modify storage mqp_actionbar:api duration set value 40
data modify storage mqp_actionbar:api source set value "skill.mana"
execute as @s run function mqp_actionbar:timed/add_timed