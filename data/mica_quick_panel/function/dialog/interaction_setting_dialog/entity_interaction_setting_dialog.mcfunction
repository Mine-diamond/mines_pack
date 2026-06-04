$dialog show @s { \
    "type": "minecraft:multi_action", \
    "title": "实体交互距离设置", \
    "columns": 2, \
    "pause": false, \
    "after_action": "none", \
    "inputs": [ \
        { \
            "key": "entity_interaction_range", \
            "type": "minecraft:number_range", \
            "label": "距离", \
            "start": 0, \
            "end": 64, \
            "step": 0.1, \
            "initial": $(current_entity_interaction_range), \
            "width": 400 \
        } \
    ], \
    "actions": [ \
        { \
            "label": "§b设置为当前交互距离", \
            "action": { \
                "type": "dynamic/run_command", \
                "template": "function mica_quick_panel:interaction_setting/entity_interaction_distance_setting/set_entity_interaction_distance {entity_interaction_range:$(entity_interaction_range)}" \
            } \
        }, \
        { \
            "label": "强制模式:$(switch_force_mode)", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.interaction_setting.entity_switch_force_mode" \
            }, \
            "tooltip": "当玩家处于创造模式时,游戏会自动将实体交互距离增加2格。\n比如,生存模式下的默认交互距离为3格,创造模式下则为5格(3默认+2额外)。\n\n启用“强制模式”后,无论玩家处于哪种游戏模式,都会强制使用设置的距离,不再额外增加。" \
        }, \
        { \
            "label": "无(§a0§f)", \
            "action": { \
                "type": "run_command", \
                "command": "function mica_quick_panel:interaction_setting/entity_interaction_distance_setting/set_entity_interaction_distance {entity_interaction_range:0}" \
            } \
        }, \
        { \
            "label": "默认(§a3§f)", \
            "action": { \
                "type": "run_command", \
                "command": "function mica_quick_panel:interaction_setting/entity_interaction_distance_setting/set_entity_interaction_distance {entity_interaction_range:3}" \
            } \
        }, \
        { \
            "label": "长(§a12§f)", \
            "action": { \
                "type": "run_command", \
                "command": "function mica_quick_panel:interaction_setting/entity_interaction_distance_setting/set_entity_interaction_distance {entity_interaction_range:12}" \
            } \
        }, \
        { \
            "label": "最大(§a64§f)", \
            "action": { \
                "type": "run_command", \
                "command": "function mica_quick_panel:interaction_setting/entity_interaction_distance_setting/set_entity_interaction_distance {entity_interaction_range:64}" \
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