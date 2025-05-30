scoreboard objectives add mines.calc dummy
$scoreboard players set #dummyTimeSet mines.calc $(time)
$scoreboard players set #dummyLunarPhaseSet mines.calc $(lunar_phase)

scoreboard players set #dummyTimeBase mines.calc 24000
scoreboard players set #10 mines.calc 10

execute if score #dummyLunarPhaseSet mines.calc = #10 mines.calc store result score #dummyLunarPhaseSet mines.calc run time query day

execute store result score #dummyLunarPhaseAdd mines.calc run scoreboard players operation #dummyLunarPhaseSet mines.calc *= #dummyTimeBase mines.calc
execute store result score #dummyTimeFianl mines.calc run scoreboard players operation #dummyTimeSet mines.calc += #dummyLunarPhaseAdd mines.calc
execute store result storage mines_pack:time_set time int 1 run scoreboard players get #dummyTimeFianl mines.calc

function mines_quick_action:day_time_change/time_set with storage mines_pack:time_set