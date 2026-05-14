$dialog show @s { \
    "type": "minecraft:multi_action", \
    "title": "快捷开关", \
    "columns": 3, \
    "pause": false, \
    "after_action": "none", \
    "actions":[ \
        { \
            "label": "夜视:$(switch_night_version)", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.simple_feature.night_version set 1" \
            } \
        }, \
        { \
            "label": "无敌:$(switch_invulnerable_mode)", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.simple_feature.invulnerable_mode set 1" \
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