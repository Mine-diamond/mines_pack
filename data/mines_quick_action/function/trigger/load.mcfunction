scoreboard objectives add mines.meun trigger
scoreboard objectives modify mines.meun displayname "菜单操作项"
scoreboard players enable @a mines.meun

scoreboard objectives add mines.death_ops_trig trigger
scoreboard objectives modify mines.death_ops_trig displayname "死亡操作项"
scoreboard players enable @a mines.death_ops_trig

scoreboard objectives add mines.death_tp_back trigger
scoreboard objectives modify mines.death_tp_back displayname "死亡位置传送"
scoreboard players enable @a mines.death_tp_back

scoreboard objectives add mines.custom_attack_damahe_trig trigger
scoreboard objectives modify mines.custom_attack_damahe_trig displayname "自定义攻击伤害设置项"
scoreboard players enable @a mines.custom_attack_damahe_trig