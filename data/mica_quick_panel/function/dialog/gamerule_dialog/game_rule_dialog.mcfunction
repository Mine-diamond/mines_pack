$dialog show @s { \
    "type": "minecraft:multi_action", \
    "columns": 2, \
    "external_title": "常见操作", \
    "title": "常见操作", \
    "actions": [ \
        { \
            "label": "时间循环:$(switch_advance_time)", \
            "action": { \
                "type": "run_command", \
                "command": "/trigger mqp.game_rule.change set 1" \
            } \
        }, \
        { \
            "label": "天气循环:$(switch_advance_weather)", \
            "action": { \
                "type": "run_command", \
                "command": "/trigger mqp.game_rule.change set 2" \
            } \
        }, \
        { \
            "label": "生物自然生成:$(switch_spawn_mobs)", \
            "action": { \
                "type": "run_command", \
                "command": "/trigger mqp.game_rule.change set 3" \
            } \
        }, \
        { \
            "label": "死亡不掉落:$(switch_keep_inventory)", \
            "action": { \
                "type": "run_command", \
                "command": "/trigger mqp.game_rule.change set 4" \
            } \
        }, \
        { \
            "label": "设置随机刻速度", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.dialog.game_rule.random_tick_speed set 1" \
            } \
        }, \
        { \
            "label": { \
                "text": "一键配置", \
                "color": "green" \
            }, \
            "action": { \
                "type": "run_command", \
                "command": "/trigger mqp.game_rule.set_to_preferred set 1" \
            }, \
            "tooltip": "-§c关闭§f时间循环\n-§c关闭§f天气循环\n-§c关闭§f生物自然生成\n-§b开启§f死亡不掉落" \
        }, \
        { \
            "label": "广播命令方块输出:$(switch_command_block_output)", \
            "action": { \
                "type": "run_command", \
                "command": "/trigger mqp.game_rule.change set 5" \
            } \
        }, \
        { \
            "label": "生物死亡掉落:$(switch_mob_drops)", \
            "action": { \
                "type": "run_command", \
                "command": "/trigger mqp.game_rule.change set 6" \
            } \
        }, \
        { \
            "label": "方块挖掘掉落:$(switch_block_drops)", \
            "action": { \
                "type": "run_command", \
                "command": "/trigger mqp.game_rule.change set 7" \
            } \
        }, \
        { \
            "label": "进度通知公告:$(switch_show_advancement_messages)", \
            "action": { \
                "type": "run_command", \
                "command": "/trigger mqp.game_rule.change set 8" \
            } \
        }, \
    ], \
    "exit_action":{ \
        "label":"返回", \
        "action": { \
            "type": "show_dialog", \
            "dialog": "mica_quick_panel:main/main_panel" \
        } \
    }, \
    "after_action": "none", \
    "pause": false, \
}
