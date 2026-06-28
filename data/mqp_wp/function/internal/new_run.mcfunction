data modify storage mqp_wp:temp point set value {name:"",dim:"minecraft:overworld",x:0,y:0,z:0,yaw:0.0f,pitch:0.0f}

data modify storage mqp_wp:temp point.dim set from entity @s Dimension

execute store result storage mqp_wp:temp point.x int 1 run data get entity @s Pos[0] 1
execute store result storage mqp_wp:temp point.y int 1 run data get entity @s Pos[1] 1
execute store result storage mqp_wp:temp point.z int 1 run data get entity @s Pos[2] 1

data modify storage mqp_wp:temp point.yaw set from entity @s Rotation[0]
data modify storage mqp_wp:temp point.pitch set from entity @s Rotation[1]

data modify storage mqp_wp:data waypoints append from storage mqp_wp:temp point

execute store result storage mqp_wp:ctx new_id int 1 run data get storage mqp_wp:data waypoints

execute unless score @s mqp.core.message_feedback matches 0 run tellraw @s [{"text":"[快捷功能:路径点]","color":"white"},{"text":" 已新建全局路径点 ","color":"green"},{"nbt":"new_id","storage":"mqp_wp:ctx","color":"yellow"}]
