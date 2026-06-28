execute store result score #temp mqp.temp run scoreboard players get @s mqp.core.message_feedback

execute if score #temp mqp.temp matches 0 run scoreboard players set @s mqp.core.message_feedback 1
execute unless score #temp mqp.temp matches 0 run scoreboard players set @s mqp.core.message_feedback 0


execute if score #temp mqp.temp matches 0 run tellraw @s ["[快捷功能]","消息反馈已",{"text":"开启",color:"aqua"}]
execute unless score #temp mqp.temp matches 0 run tellraw @s ["[快捷功能]","消息反馈已",{"text":"关闭",color:"red"}]
