execute store result score #temp mqp.temp run data get entity @s Health 1 

execute if score #temp mqp.temp matches ..6 run data modify storage mqp_actionbar:api msg set value {"text":"低血量!","color":"red","bold":true}
execute if score #temp mqp.temp matches ..6 run function mqp_actionbar:add
