$dialog show @s {  \
    "type": "minecraft:multi_action",  \
    "pause": false,  \
    "after_action":"none", \
    "columns":3 ,\
    "title": "修改命名牌名称",  \
    "body": [  \
        {  \
            "type": "minecraft:plain_message",  \
            "contents": [  \
                " ",  \
                "[",  \
                {  \
                    "text": "常规模式",  \
                    "color": "#7ef386",  \
                    "underlined": true  \
                },  \
                "|",  \
                {  \
                    "text": "json模式",  \
                    "click_event": {  \
                        "action": "run_command",  \
                        "command": "trigger mqp.dialog.rename_name_tag_json"  \
                    }  \
                },  \
                "]"  \
            ]  \
        },  \
        {  \
            "type": "minecraft:plain_message",  \
            "contents": [  \
                "使用&符号来代替分节符号，",  \
                {  \
                    "text": "样式说明",  \
                    "underlined": true,  \
                    "hover_event": {  \
                        "action": "show_text",  \
                        "value": "&0 - §f黑色§r  &1 - §1深蓝色§r\n&2 - §2深绿色§r  &3 - §3深青色§r\n&4 - §4深红色§r  &5 - §5深紫色§r\n&6 - §6金色§r  &7 - §7灰色§r\n&8 - §8深灰色§r  &9 - §9蓝色§r\n&a - §a绿色§r  &b - §b青色§r\n&c - §c红色§r  &d - §d粉色§r\n&e - §e黄色§r  &f - §f白色§r\n&k - §k混淆§r  &l - §l粗体§r\n&m - §m删除线§r  &n - §n下划线§r\n&o - §o斜体§r  &r - §r重置§r"  \
                    }  \
                }  \
            ]  \
        }$(preview)  \
    ],  \
    "inputs": [  \
        {  \
            "key": "name",  \
            "type": "minecraft:text",  \
            "label": "命名牌名称",  \
            "width": 250,  \
            "max_length": 1000,  \
            initial: "$(initial)" \
        }  \
    ],  \
    "actions": [  \
        {  \
            "label": "确认",  \
            "width": 80,  \
            "action": {  \
                "type": "dynamic/run_command",  \
                "template": "function mica_quick_panel:item/advanced_name_tag/replace_common_prepare {name:\"$(name)\"}"  \
            }  \
        },  \
        {  \
            "label": "预览",  \
            "width": 80,  \
            "action": {  \
                "type": "dynamic/run_command",  \
                "template": "function mica_quick_panel:item/advanced_name_tag/preview_common {name:\"$(name)\"}"  \
            }  \
        },  \
        {  \
            "label": {"translate": "gui.cancel"},  \
            "width": 80,  \
            "action": {  \
                "type": "run_command",  \
                "command": "trigger mqp.trigger.util.close_dialog"  \
            }  \
        }  \
    ]  \
}