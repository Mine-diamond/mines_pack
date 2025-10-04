$execute as @e[nbt={UUID:$(UUID)}] unless data entity @s InLove run return 0
$execute as @e[nbt={UUID:$(UUID)}] run data modify entity @s InLove set value 600
$execute as @e[nbt={UUID:$(UUID)}] run tag @s add fuck_to_love
$data modify entity @e[nbt={UUID:$(UUID)},limit=1] LoveCause set from entity @s UUID
#$execute as @e[nbt={UUID:$(UUID)}] run say I'm here