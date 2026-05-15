$dialog show @s { \
    "type": "minecraft:multi_action", \
    "title": "高亮设置", \
    "columns": 3, \
    "pause": false, \
    "after_action": "none", \
    "actions": [ \
        { \
            "label": "实体:$(switch_entity)", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.highlight.entity_enabled_flags" \
            } \
        }, \
        { \
            "label": "掉落物:$(switch_item)", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.highlight.item_enabled_flags" \
            } \
        }, \
        { \
            "label": "玩家:$(switch_player)", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.highlight.player_enabled_flags" \
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