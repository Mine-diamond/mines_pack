$dialog show @s { \
    "type": "minecraft:multi_action", \
    "title": "时间设置", \
    "columns": 2, \
    "pause": false, \
    "after_action": "none", \
    "inputs": [ \
        { \
            "key": "time", \
            "type": "minecraft:number_range", \
            "label": "时间", \
            "start": 0, \
            "end": 24000, \
            "step": 10, \
            "initial": $(current_time), \
            "width": 400 \
        } \
    ], \
    "body": [ \
        { \
            "type": "minecraft:plain_message", \
            "contents": "清晨:0                   中午:6000             傍晚:12000            半夜:18000                 ", \
            "width": 500 \
        }, \
        { \
            "type": "minecraft:plain_message", \
            "contents": "↓                        ↓                       ↓                       ↓                         ", \
            "width": 500 \
        } \
    ], \
    "actions": [ \
        { \
            "label": "§b设置为当前时间", \
            "action": { \
                "type": "dynamic/run_command", \
                "template": "trigger mqp.trigger.time_setting set $(time)" \
            } \
        }, \
        { \
            "label": "月相设置", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.dialog.moon_phase" \
            } \
        }, \
        { \
            "label": "清晨", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.time_setting set 0" \
            } \
        }, \
        { \
            "label": "中午", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.time_setting set 6000" \
            } \
        }, \
        { \
            "label": "傍晚", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.time_setting set 12000" \
            } \
        }, \
        { \
            "label": "半夜", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.time_setting set 18000" \
            } \
        } \
    ], \
    "exit_action": { \
        "label": { \
            "translate": "gui.back" \
        }, \
        "action": { \
            "type": "show_dialog", \
            "dialog": "mica_quick_panel:main/main_panel" \
        } \
    } \
}