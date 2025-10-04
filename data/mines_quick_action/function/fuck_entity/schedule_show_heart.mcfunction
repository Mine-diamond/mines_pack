execute as @e[tag=fuck_to_love,nbt={InLove:0}] run data modify entity @s Age set value 0
execute as @e[tag=fuck_to_love,nbt={InLove:0}] run tag @s remove fuck_to_love
execute as @e[tag=fuck_to_love] run function mines_quick_action:fuck_entity/show_heart

schedule function mines_quick_action:fuck_entity/schedule_show_heart 5