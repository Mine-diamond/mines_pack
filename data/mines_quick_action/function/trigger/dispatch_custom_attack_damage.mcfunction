execute if score @s mines.custom_attack_damahe_trig matches 1 run function mines_quick_action:attack_damage_custom/disable_attack_damage
execute if score @s mines.custom_attack_damahe_trig matches 2 run function mines_quick_action:attack_damage_custom/reset_attack_damage
execute if score @s mines.custom_attack_damahe_trig matches 3 run function mines_quick_action:attack_damage_custom/custom_attack_damage {attack_damage:10}
execute if score @s mines.custom_attack_damahe_trig matches 3 run function mines_quick_action:attack_damage_custom/custom_attack_damage {attack_damage:10000000}

scoreboard players set @s mines.custom_attack_damahe_trig 0