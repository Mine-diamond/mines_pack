$dialog show @s { \
    "type": "minecraft:multi_action", \
    "title": "显示方块距离", \
    "columns": 2, \
    "pause": false, \
    "after_action": "none", \
    "inputs": [ \
        { \
            "key": "detect_range", \
            "type": "minecraft:number_range", \
            "label": "距离", \
            "start": 1, \
            "end": 400, \
            "step": 1, \
            "initial": $(current_detect_range), \
            "width": 400 \
        } \
    ], \
    "actions": [ \
        { \
            "label": "设置为当前交互距离", \
            "action": { \
                "type": "dynamic/run_command", \
                "template": "trigger mqp.trigger.show_distance_to_block.set_detect_distance set $(detect_range)" \
            } \
        }, \
        { \
            "label": "显示方块距离:$(switch_enable)", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.show_distance_to_block.switch_enable" \
            }, \
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