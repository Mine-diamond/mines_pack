$dialog show @s { \
    "type": "minecraft:multi_action", \
    "title": "设置", \
    "after_action": "none", \
    "pause": false, \
    "columns": 3, \
    "actions": [ \
        { \
            "label": "消息反馈: $(switch_message_feedback)", \
            "width": 120, \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.core.switch_message_feedback" \
            } \
        } \
    ], \
    "exit_action": { \
        "label": {"translate": "gui.back"}, \
        "action": { \
            "type": "show_dialog", \
            "dialog": "mica_quick_panel:main/main_panel" \
        } \
    } \
}
