$dialog show @s { \
    "type": "minecraft:multi_action", \
    "title": "路径点", \
    "after_action": "none", \
    "pause": false, \
    "columns": 6, \
    "actions": [ \
        $(all_actions) \
        { \
            "label": "添加新路径点", \
            "width": 300, \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.way_point.new" \
            } \
        } \
    ], \
    "exit_action":{ \
        "label":"返回", \
        "action": { \
            "type": "show_dialog", \
            "dialog": "mica_quick_panel:main/main_panel" \
        } \
    } \
}