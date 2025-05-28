execute as @a[scores={mines.ifDeath=1}] store result score @s mines.DeathXPos run data get entity @s LastDeathLocation.pos[0]
execute as @a[scores={mines.ifDeath=1}] store result score @s mines.DeathYPos run data get entity @s LastDeathLocation.pos[1]
execute as @a[scores={mines.ifDeath=1}] store result score @s mines.DeathZPos run data get entity @s LastDeathLocation.pos[2]

execute as @a[scores={mines.deathOperate=2}] run function names:deathback/set_spawnpoint_jump

execute as @a[scores={mines.ifDeath=1,mines.deathOperate=1}] run function names:deathback/track_back

execute as @a[scores={mines.ifDeath=1}] run scoreboard players set @s mines.ifDeath 0