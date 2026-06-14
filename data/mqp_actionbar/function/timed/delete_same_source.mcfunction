$execute as @e[type=marker,tag=mqp_actionbar.timed_msg] if score @s mqp_actionbar.id = $owner mqp_actionbar.id if data entity @s {data:{source:"$(source)"}} run kill @s
