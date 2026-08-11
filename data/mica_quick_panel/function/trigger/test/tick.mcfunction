execute as @a[scores={mqp.test.macro_test=0..}] run function mica_quick_panel:test/marco_test {say_content:5}
scoreboard players set @a[scores={mqp.test.macro_test=0..}] mqp.test.macro_test -1
scoreboard players enable @a mqp.test.macro_test
