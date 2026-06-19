scoreboard objectives add mqp.trigger.way_point.tp trigger
scoreboard objectives modify mqp.trigger.way_point.tp displayname "路径点:tp"
scoreboard players enable @a mqp.trigger.way_point.tp

scoreboard objectives add mqp.trigger.way_point.new trigger
scoreboard objectives modify mqp.trigger.way_point.new displayname "路径点:新建"
scoreboard players enable @a mqp.trigger.way_point.new

scoreboard objectives add mqp.trigger.way_point.del trigger
scoreboard objectives modify mqp.trigger.way_point.del displayname "路径点:删除"
scoreboard players enable @a mqp.trigger.way_point.del

scoreboard objectives add mqp.trigger.way_point.up trigger
scoreboard objectives modify mqp.trigger.way_point.up displayname "路径点:上移"
scoreboard players enable @a mqp.trigger.way_point.up

scoreboard objectives add mqp.trigger.way_point.down trigger
scoreboard objectives modify mqp.trigger.way_point.down displayname "路径点:下移"
scoreboard players enable @a mqp.trigger.way_point.down
