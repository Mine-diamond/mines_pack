give @s minecraft:netherite_sword[minecraft:enchantments={"minecraft:sharpness":4,"minecraft:sweeping_edge":3,"minecraft:fire_aspect":2,"minecraft:looting":3,"minecraft:unbreaking":3,"minecraft:mending":1}]
give @s netherite_spear[minecraft:enchantments={"minecraft:lunge":3,"minecraft:sharpness":5,"minecraft:fire_aspect":2,"minecraft:looting":3,"minecraft:unbreaking":3,"minecraft:mending":1}]

$execute if score #1 mqp.constant.number matches $(add_fortune) run function mica_quick_panel:item/netherite/enchanted/give_common_item_fortune
$execute if score #0 mqp.constant.number matches $(add_fortune) run function mica_quick_panel:item/netherite/enchanted/give_common_item_silk_touch