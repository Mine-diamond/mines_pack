$data merge storage mqp:way_point.dialog {new_row:'{ \
            "label": "$(name)", \
            "width": 100 \
        }, \
        { \
            "label": "传送", \
            "width": 50, \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.way_point.tp set $(number)" \
            } \
        }, \
        { \
            "label": "编辑", \
            "width": 50, \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.dialog.way_point_edit set $(number)" \
            } \
        }, \
        { \
            "label": "删除", \
            "width": 50, \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.way_point.del set $(number)" \
            } \
        }, \
        { \
            "label": "↑上移", \
            "width": 50, \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.way_point.up set $(number)" \
            } \
        }, \
        { \
            "label": "↓下移", \
            "width": 50, \
            "action": { \
                "type": "run_command", \
                "command": "trigger mqp.trigger.way_point.down set $(number)" \
            } \
        }'}
execute unless data storage mqp:way_point.dialog all_content run data merge storage mqp:way_point.dialog {all_content:""}
function mica_quick_panel:way_point/dialog/concat_str with storage mqp:way_point.dialog