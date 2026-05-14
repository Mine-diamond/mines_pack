$dialog show @s { \
    "type": "minecraft:multi_action", \
    "title": "月相设置", \
    "columns": 2, \
    "pause": false, \
    "after_action": "none", \
    "actions": [ \
        { \
            "label": "$(color_0)满月", \
            "action": { "type": "run_command", "command": "trigger mqp.trigger.moon_phase set 0" } \
        }, \
        { \
            "label": "$(color_1)亏凸月", \
            "action": { "type": "run_command", "command": "trigger mqp.trigger.moon_phase set 1" } \
        }, \
        { \
            "label": "$(color_2)下弦月", \
            "action": { "type": "run_command", "command": "trigger mqp.trigger.moon_phase set 2" } \
        }, \
        { \
            "label": "$(color_3)残月", \
            "action": { "type": "run_command", "command": "trigger mqp.trigger.moon_phase set 3" } \
        }, \
        { \
            "label": "$(color_4)新月", \
            "action": { "type": "run_command", "command": "trigger mqp.trigger.moon_phase set 4" } \
        }, \
        { \
            "label": "$(color_5)娥眉月", \
            "action": { "type": "run_command", "command": "trigger mqp.trigger.moon_phase set 5" } \
        }, \
        { \
            "label": "$(color_6)上弦月", \
            "action": { "type": "run_command", "command": "trigger mqp.trigger.moon_phase set 6" } \
        }, \
        { \
            "label": "$(color_7)盈凸月", \
            "action": { "type": "run_command", "command": "trigger mqp.trigger.moon_phase set 7" } \
        } \
    ], \
    "exit_action":{ \
        "label":{"translate": "gui.back"}, \
        "action": { \
            "type": "run_command", \
            "command": "trigger mqp.dialog.time_setting" \
        } \
    } \
}