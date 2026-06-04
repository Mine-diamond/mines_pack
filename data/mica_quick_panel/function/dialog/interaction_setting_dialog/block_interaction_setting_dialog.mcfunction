$dialog show @s { \
    "type": "minecraft:multi_action", \
    "title": "方块交互距离设置", \
    "columns": 2, \
    "pause": false, \
    "after_action": "none", \
    "inputs": [ \
        { \
            "key": "block_interaction_range", \
            "type": "minecraft:number_range", \
            "label": "距离", \
            "start": 0, \
            "end": 64, \
            "step": 0.1, \
            "initial": $(current_block_interaction_range), \
            "width": 400 \
        } \
    ], \
    "actions": [ \
        { \
            "label": "§b设置为当前交互距离", \
            "action": { \
                "type": "dynamic/run_command", \
                "template": "function mica_quick_panel:interaction_setting/block_interaction_distance_setting/set_block_interaction_distance {block_interaction_range:$(block_interaction_range)}" \
            } \
        }, \
        { \
            "label": "强制模式:$(switch_force_mode)", \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.interaction_setting.block_switch_force_mode" \
            }, \
            "tooltip": "当玩家处于创造模式时,游戏会自动将方块交互距离增加0.5格。\n比如,生存模式下的默认交互距离为4.5格,创造模式下则为5格(4.5默认+0.5额外)。\n\n启用“强制模式”后,无论玩家处于哪种游戏模式,都会强制使用设置的距离,不再额外增加。" \
        }, \
        { \
            "label": "无(§a0§f)", \
            "action": { \
                "type": "run_command", \
                "command": "function mica_quick_panel:interaction_setting/block_interaction_distance_setting/set_block_interaction_distance {block_interaction_range:0}" \
            } \
        }, \
        { \
            "label": "默认(§a4.5§f)", \
            "action": { \
                "type": "run_command", \
                "command": "function mica_quick_panel:interaction_setting/block_interaction_distance_setting/set_block_interaction_distance {block_interaction_range:4.5}" \
            } \
        }, \
        { \
            "label": "长(§a15§f)", \
            "action": { \
                "type": "run_command", \
                "command": "function mica_quick_panel:interaction_setting/block_interaction_distance_setting/set_block_interaction_distance {block_interaction_range:15}" \
            } \
        }, \
        { \
            "label": "最大(§a64§f)", \
            "action": { \
                "type": "run_command", \
                "command": "function mica_quick_panel:interaction_setting/block_interaction_distance_setting/set_block_interaction_distance {block_interaction_range:64}" \
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