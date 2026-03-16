execute if score @s mines.netherite_item_trig matches 1001 run function mines_quick_action:netherite_item/get_unenchanted_netherite_item
execute if score @s mines.netherite_item_trig matches 1002 run function mines_quick_action:netherite_item/equip_unenchanted_netherite_item
execute if score @s mines.netherite_item_trig matches 1003 run function mines_quick_action:netherite_item/get_enchanted_netherite_item {add_fortune:1}
execute if score @s mines.netherite_item_trig matches 1004 run function mines_quick_action:netherite_item/equip_enchanted_netherite_item {add_fortune:1}
execute if score @s mines.netherite_item_trig matches 1005 run function mines_quick_action:netherite_item/get_enchanted_netherite_item {add_fortune:0}
execute if score @s mines.netherite_item_trig matches 1006 run function mines_quick_action:netherite_item/equip_enchanted_netherite_item {add_fortune:0}

execute if score @s mines.netherite_item_trig matches 11 run give @s minecraft:netherite_helmet
execute if score @s mines.netherite_item_trig matches 12 run item replace entity @s armor.head with minecraft:netherite_helmet
execute if score @s mines.netherite_item_trig matches 13 run give @s minecraft:netherite_helmet[minecraft:enchantments={"minecraft:protection":4,"minecraft:respiration":3,"minecraft:aqua_affinity":1,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 14 run item replace entity @s armor.head with minecraft:netherite_helmet[minecraft:enchantments={"minecraft:protection":4,"minecraft:respiration":3,"minecraft:aqua_affinity":1,"minecraft:unbreaking":3,"minecraft:mending":1}]

execute if score @s mines.netherite_item_trig matches 21 run give @s minecraft:netherite_chestplate
execute if score @s mines.netherite_item_trig matches 22 run item replace entity @s armor.chest with minecraft:netherite_chestplate
execute if score @s mines.netherite_item_trig matches 23 run give @s minecraft:netherite_chestplate[minecraft:enchantments={"minecraft:protection":4,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 24 run item replace entity @s armor.chest with minecraft:netherite_chestplate[minecraft:enchantments={"minecraft:protection":4,"minecraft:unbreaking":3,"minecraft:mending":1}]

execute if score @s mines.netherite_item_trig matches 31 run give @s minecraft:netherite_leggings
execute if score @s mines.netherite_item_trig matches 32 run item replace entity @s armor.legs with minecraft:netherite_leggings
execute if score @s mines.netherite_item_trig matches 33 run give @s minecraft:netherite_leggings[minecraft:enchantments={"minecraft:protection":4,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 34 run item replace entity @s armor.legs with minecraft:netherite_leggings[minecraft:enchantments={"minecraft:protection":4,"minecraft:unbreaking":3,"minecraft:mending":1}]

execute if score @s mines.netherite_item_trig matches 41 run give @s minecraft:netherite_boots
execute if score @s mines.netherite_item_trig matches 42 run item replace entity @s armor.feet with minecraft:netherite_boots
execute if score @s mines.netherite_item_trig matches 43 run give @s minecraft:netherite_boots[minecraft:enchantments={"minecraft:protection":4,"minecraft:feather_falling":4,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 44 run item replace entity @s armor.feet with minecraft:netherite_boots[minecraft:enchantments={"minecraft:protection":4,"minecraft:feather_falling":4,"minecraft:unbreaking":3,"minecraft:mending":1}]

execute if score @s mines.netherite_item_trig matches 51 run give @s minecraft:netherite_sword
execute if score @s mines.netherite_item_trig matches 52 run item replace entity @s weapon.mainhand with minecraft:netherite_sword
execute if score @s mines.netherite_item_trig matches 53 run give @s minecraft:netherite_sword[minecraft:enchantments={"minecraft:sharpness":4,"minecraft:sweeping_edge":3,"minecraft:fire_aspect":2,"minecraft:looting":3,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 54 run item replace entity @s weapon.mainhand with minecraft:netherite_sword[minecraft:enchantments={"minecraft:sharpness":4,"minecraft:sweeping_edge":3,"minecraft:fire_aspect":2,"minecraft:looting":3,"minecraft:unbreaking":3,"minecraft:mending":1}]

execute if score @s mines.netherite_item_trig matches 61 run give @s minecraft:netherite_axe
execute if score @s mines.netherite_item_trig matches 62 run item replace entity @s weapon.mainhand with minecraft:netherite_axe
execute if score @s mines.netherite_item_trig matches 63 run give @s minecraft:netherite_axe[minecraft:enchantments={"minecraft:sharpness":5,"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 64 run item replace entity @s weapon.mainhand with minecraft:netherite_axe[minecraft:enchantments={"minecraft:sharpness":5,"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 65 run give @s minecraft:netherite_axe[minecraft:enchantments={"minecraft:sharpness":5,"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 66 run item replace entity @s weapon.mainhand with minecraft:netherite_axe[minecraft:enchantments={"minecraft:sharpness":5,"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]

execute if score @s mines.netherite_item_trig matches 71 run give @s netherite_spear
execute if score @s mines.netherite_item_trig matches 72 run item replace entity @s weapon.mainhand with netherite_spear
execute if score @s mines.netherite_item_trig matches 73 run give @s netherite_spear[minecraft:enchantments={"minecraft:lunge":3,"minecraft:sharpness":5,"minecraft:fire_aspect":2,"minecraft:looting":3,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 74 run item replace entity @s weapon.mainhand with netherite_spear[minecraft:enchantments={"minecraft:lunge":3,"minecraft:sharpness":5,"minecraft:fire_aspect":2,"minecraft:looting":3,"minecraft:unbreaking":3,"minecraft:mending":1}]

execute if score @s mines.netherite_item_trig matches 81 run give @s minecraft:netherite_pickaxe
execute if score @s mines.netherite_item_trig matches 82 run item replace entity @s weapon.mainhand with minecraft:netherite_pickaxe
execute if score @s mines.netherite_item_trig matches 83 run give @s minecraft:netherite_pickaxe[minecraft:enchantments={"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 84 run item replace entity @s weapon.mainhand with minecraft:netherite_pickaxe[minecraft:enchantments={"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 85 run give @s minecraft:netherite_pickaxe[minecraft:enchantments={"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 86 run item replace entity @s weapon.mainhand with minecraft:netherite_pickaxe[minecraft:enchantments={"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]

execute if score @s mines.netherite_item_trig matches 91 run give @s minecraft:netherite_shovel
execute if score @s mines.netherite_item_trig matches 92 run item replace entity @s weapon.mainhand with minecraft:netherite_shovel
execute if score @s mines.netherite_item_trig matches 93 run give @s minecraft:netherite_shovel[minecraft:enchantments={"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 94 run item replace entity @s weapon.mainhand with minecraft:netherite_shovel[minecraft:enchantments={"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 95 run give @s minecraft:netherite_shovel[minecraft:enchantments={"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 96 run item replace entity @s weapon.mainhand with minecraft:netherite_shovel[minecraft:enchantments={"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]

execute if score @s mines.netherite_item_trig matches 101 run give @s minecraft:netherite_hoe
execute if score @s mines.netherite_item_trig matches 102 run item replace entity @s weapon.mainhand with minecraft:netherite_hoe
execute if score @s mines.netherite_item_trig matches 103 run give @s minecraft:netherite_hoe[minecraft:enchantments={"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 104 run item replace entity @s weapon.mainhand with minecraft:netherite_hoe[minecraft:enchantments={"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 105 run give @s minecraft:netherite_hoe[minecraft:enchantments={"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
execute if score @s mines.netherite_item_trig matches 106 run item replace entity @s weapon.mainhand with minecraft:netherite_hoe[minecraft:enchantments={"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]


scoreboard players set @s mines.netherite_item_trig 0