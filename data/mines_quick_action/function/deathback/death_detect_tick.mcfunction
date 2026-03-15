execute as @a[scores={mines.if_death=1}] store result score @s mines.death_x_pos run data get entity @s LastDeathLocation.pos[0]
execute as @a[scores={mines.if_death=1}] store result score @s mines.death_y_pos run data get entity @s LastDeathLocation.pos[1]
execute as @a[scores={mines.if_death=1}] store result score @s mines.death_z_pos run data get entity @s LastDeathLocation.pos[2]
execute as @a[scores={mines.if_death=1}] store result score @s mines.death_yaw run scoreboard players get @s mines.current_yaw
execute as @a[scores={mines.if_death=1}] store result score @s mines.death_pitch run scoreboard players get @s mines.current_pitch

execute as @a[scores={mines.if_death=0}] store result score @s mines.current_yaw run data get entity @s Rotation[0] 100
execute as @a[scores={mines.if_death=0}] store result score @s mines.current_pitch run data get entity @s Rotation[1] 100

execute as @a[scores={mines.death_ops=3}] run function mines_quick_action:deathback/set_spawnpoint

execute as @a[scores={mines.if_death=1,mines.death_ops=2}] run function mines_quick_action:deathback/show_back_text

execute as @a[scores={mines.if_death=1}] run scoreboard players set @s mines.if_death 0