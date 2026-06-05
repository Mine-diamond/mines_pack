$dialog show @s { \
    "type": "minecraft:multi_action", \
    "title": "清理实体", \
    "after_action": "none", \
    "pause": false, \
    "body": [ \
        { \
            "type": "minecraft:plain_message", \
            "contents": [ \
                { \
                    "text": "清除附近所有生物和实体可能带来" \
                }, \
                { \
                    "text": "严重后果", \
                    "color": "red" \
                }, \
                { \
                    "text": "!\n确保周围没有重要生物。" \
                } \
            ], \
            "width": 400 \
        } \
    ], \
    "actions": [ \
        { \
            "label": "产生掉落物:$(switch_mob_loot)", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.kill_all_mob.close_mob_loot" \
            } \
        }, \
        { \
            "label": "清除类型:$(switch_kill_type)", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.kill_all_mob.kill_type" \
            } \
        }, \
        { \
            "label": "§c§l清除", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.kill_all_mob.kill_all_mob" \
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