$execute as @e[nbt={UUID:$(UUID)}] run data modify entity @s InLove set value 600
$execute as @e[nbt={UUID:$(UUID)}] run tag @s add fuck_to_love
$data modify entity @e[nbt={UUID:$(UUID)},limit=1] LoveCause set from entity @s UUID
$execute as @e[nbt={UUID:$(UUID)}] run damage @s 0.01
$execute as @e[nbt={UUID:$(UUID)}] run say I'm here