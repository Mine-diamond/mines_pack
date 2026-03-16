give @s minecraft:netherite_sword[minecraft:enchantments={"minecraft:sharpness":4,"minecraft:sweeping_edge":3,"minecraft:fire_aspect":2,"minecraft:looting":3,"minecraft:unbreaking":3,"minecraft:mending":1}]

$execute if score #true mines.logic matches $(add_fortune) run give @s minecraft:netherite_axe[minecraft:enchantments={"minecraft:sharpness":5,"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
$execute if score #false mines.logic matches $(add_fortune) run give @s minecraft:netherite_axe[minecraft:enchantments={"minecraft:sharpness":5,"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]

give @s netherite_spear[minecraft:enchantments={"minecraft:lunge":3,"minecraft:sharpness":5,"minecraft:fire_aspect":2,"minecraft:looting":3,"minecraft:unbreaking":3,"minecraft:mending":1}]

$execute if score #true mines.logic matches $(add_fortune) run give @s minecraft:netherite_pickaxe[minecraft:enchantments={"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
$execute if score #false mines.logic matches $(add_fortune) run give @s minecraft:netherite_pickaxe[minecraft:enchantments={"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]

$execute if score #true mines.logic matches $(add_fortune) run give @s minecraft:netherite_shovel[minecraft:enchantments={"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
$execute if score #false mines.logic matches $(add_fortune) run give @s minecraft:netherite_shovel[minecraft:enchantments={"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]

$execute if score #true mines.logic matches $(add_fortune) run give @s minecraft:netherite_hoe[minecraft:enchantments={"minecraft:fortune":3,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]
$execute if score #false mines.logic matches $(add_fortune) run give @s minecraft:netherite_hoe[minecraft:enchantments={"minecraft:silk_touch":1,"minecraft:efficiency":5,"minecraft:unbreaking":3,"minecraft:mending":1}]