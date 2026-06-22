$dialog show @s { \
    "type": "minecraft:multi_action", \
    "title": "设置随机刻", \
    "columns": 1, \
    "pause": false, \
    "after_action": "none", \
    "inputs": [ \
        { \
            "key": "input", \
            "type": "minecraft:number_range", \
            "start": 0, \
            "end": 300, \
            "label": "随机刻值", \
            "width": 300, \
            "step":1, \
            "initial": $(initial) \
        } \
    ], \
    "actions": [ \
        { \
            "label": "设置为随机刻速度", \
            "width": 120, \
            "action": { \
                "type": "dynamic/run_command", \
                "template": "trigger mqp.trigger.game_rule.set_random_tick_speed set $(input)" \
            } \
        }, \
        { \
            "label": "随机刻速度设置为§a0", \
            "width": 120, \
            "action": { \
                "type": "minecraft:run_command", \
                "command": "trigger mqp.trigger.game_rule.set_random_tick_speed set 0" \
            } \
        }, \
        { \
            "label": "随机刻速度设置为§a3§f(默认)", \
            "width": 120, \
            "action": { \
                "type": "minecraft:run_command", \
                "command": "trigger mqp.trigger.game_rule.set_random_tick_speed set 3" \
            } \
        }, \
        { \
            "label": "随机刻速度设置为§a200", \
            "width": 120, \
            "action": { \
                "type": "minecraft:run_command", \
                "command": "trigger mqp.trigger.game_rule.set_random_tick_speed set 200" \
            } \
        } \
    ], \
    "exit_action":{ \
        "label":"返回", \
        "action": { \
            "type": "run_command", \
            "command": "trigger mqp.dialog.game_rule set 1" \
        } \
    } \
}
