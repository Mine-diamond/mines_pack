$execute as @e[nbt={UUID:$(entity_uuid)}] run data merge entity @s {DeathTime:20}
$execute as @e[nbt={UUID:$(entity_uuid)}] run data merge entity @s {Health:0}