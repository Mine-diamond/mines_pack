execute as @a run tellraw @s [{"text": "你的生命状态: ","color": "gray"},{"selector": "@s[scores={health=..5}]","color": "dark_red","bold": true,separator:"a","extra":[{text:"危险"}]},{"selector": "@s[scores={health=6..15}]","color": "red",separator:"a","extra":[{text:"普通"}]},{"selector": "@s[scores={health=16..}]","color": "green",separator:"a","extra":[{text:"健康"}]}]

return fail