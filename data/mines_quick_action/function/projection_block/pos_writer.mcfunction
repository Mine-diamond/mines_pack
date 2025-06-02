execute align xyz run summon marker ~ ~ ~ {Tags:["pos_probe_target"],NoGravity:1b,Silent:1b}
execute positioned ^ ^ ^-0.1 align xyz run summon marker ~ ~ ~ {Tags:["pos_probe_adjacent"],NoGravity:1b,Silent:1b}

execute run data modify storage mines_pack:projection_block_result_target Pos set from entity @e[tag=pos_probe_target,limit=1,sort=nearest] Pos
execute run data modify storage mines_pack:projection_block_result_adjacent Pos set from entity @e[tag=pos_probe_adjacent,limit=1,sort=nearest] Pos

kill @e[tag=pos_probe_target,limit=1]
kill @e[tag=pos_probe_adjacent,limit=1]