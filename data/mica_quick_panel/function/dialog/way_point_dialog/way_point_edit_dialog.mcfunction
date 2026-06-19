$dialog show @s { \
  "type": "minecraft:confirmation", \
  "title": "编辑路径点", \
  "after_action": "none", \
  "pause": false, \
  "body": [ \
    { \
      "type": "minecraft:plain_message", \
      "contents": "编辑路径点$(id)" \
    } \
  ], \
  "inputs": [ \
    { \
      "key": "c_name", \
      "type": "minecraft:text", \
      "label": { \
        "text": "名称", \
        "color": "yellow" \
      }, \
      "initial": "$(name)", \
      "max_length": 128 \
    }, \
    { \
        "key": "c_dim_id", \
        "type": "minecraft:single_option", \
        "label": { \
            "text": "维度", \
            "color": "yellow" \
        }, \
        "options": [ \
            { \
                "id": "1", \
                "display": "主世界"$(dim_id_initial_1) \
            }, \
            { \
                "id": "2", \
                "display": "下界"$(dim_id_initial_2) \
            }, \
            { \
                "id": "3", \
                "display": "末地"$(dim_id_initial_3) \
            } \
        ] \
    }, \
    { \
      "key": "c_custom_dim", \
      "type": "minecraft:text", \
      "label": { \
        "text": "输入维度ID(覆盖上方选择)", \
        "color": "yellow" \
      }, \
      "initial": "$(custom_dim)", \
      "max_length": 128 \
    }, \
    { \
      "key": "c_x", \
      "type": "minecraft:text", \
      "label": { \
        "text": "X坐标, 整数", \
        "color": "yellow" \
      }, \
      "initial": "$(x)", \
      "max_length": 16 \
    }, \
    { \
      "key": "c_y", \
      "type": "minecraft:text", \
      "label": { \
        "text": "Y坐标, 整数", \
        "color": "yellow" \
      }, \
      "initial": "$(y)", \
      "max_length": 16 \
    }, \
    { \
      "key": "c_z", \
      "type": "minecraft:text", \
      "label": { \
        "text": "Z坐标, 整数", \
        "color": "yellow" \
      }, \
      "initial": "$(z)", \
      "max_length": 16 \
    }, \
    { \
      "key": "c_yaw", \
      "type": "minecraft:text", \
      "label": { \
        "text": "Yaw(偏转角)", \
        "color": "yellow" \
      }, \
      "initial": "$(yaw)", \
      "max_length": 32 \
    }, \
    { \
      "key": "c_pitch", \
      "type": "minecraft:text", \
      "label": { \
        "text": "Pitch(俯仰角)", \
        "color": "yellow" \
      }, \
      "initial": "$(pitch)", \
      "max_length": 32 \
    } \
  ], \
  "yes": { \
    "label": "§b应用修改", \
      "action": { \
        "type": "minecraft:dynamic/run_command", \
        "template": "function mica_quick_panel:way_point/set_info {id:$(id),name:\"$(c_name)\",dim_id:$(c_dim_id),custom_dim:\"$(c_custom_dim)\",x:$(c_x),y:$(c_y),z:$(c_z),yaw:$(c_yaw),pitch:$(c_pitch)}" \
      } \
  }, \
  "no": { \
    "label": {"translate": "gui.back"}, \
    "action": { \
      "type": "run_command", \
      "command": "trigger mqp.dialog.way_point" \
    } \
  } \
}