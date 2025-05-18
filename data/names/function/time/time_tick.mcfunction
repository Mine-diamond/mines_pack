execute store result score #dummyCurrentPlayerTime mines.worldtime run time query gametime

execute store result score #dummyCurrentPlayerTimeHOUR mines.worldtime run scoreboard players operation #dummyCurrentPlayerTime mines.worldtime /= #dummyPlayerTimeHOUR mines.worldtime

execute store result score #dummyCurrentPlayerTime mines.worldtime run time query gametime
scoreboard players operation #dummyCurrentPlayerTime mines.worldtime %= #dummyPlayerTimeHOUR mines.worldtime
execute store result score #dummyCurrentPlayerTimeMIN mines.worldtime run scoreboard players operation #dummyCurrentPlayerTime mines.worldtime /= #dummyPlayerTimeMIN mines.worldtime

execute store result score #dummyCurrentPlayerTime mines.worldtime run time query gametime
scoreboard players operation #dummyCurrentPlayerTime mines.worldtime %= #dummyPlayerTimeMIN mines.worldtime
execute store result score #dummyCurrentPlayerTimeSEC mines.worldtime run scoreboard players operation #dummyCurrentPlayerTime mines.worldtime /= #dummyPlayerTime mines.worldtime

execute store result score #dummyCurrentPlayerTime mines.worldtime run time query gametime
execute store result score #dummyCurrentPlayerTime mines.worldtime run scoreboard players operation #dummyCurrentPlayerTime mines.worldtime /= #dummyPlayerTime mines.worldtime

execute if score #dummyPlayerTimeDiaplay mines.worldtime matches 1 run title @a actionbar [{"text":"\u00A7e世界总时间: "},{"score":{"name":"#dummyCurrentPlayerTime","objective":"mines.worldtime"}},{"text":"\u00A7e  "},{"score":{"name":"#dummyCurrentPlayerTimeHOUR","objective":"mines.worldtime"}},{"text":"\u00A7e:"},{"score":{"name":"#dummyCurrentPlayerTimeMIN","objective":"mines.worldtime"}},{"text":"\u00A7e:"},{"score":{"name":"#dummyCurrentPlayerTimeSEC","objective":"mines.worldtime"}}]