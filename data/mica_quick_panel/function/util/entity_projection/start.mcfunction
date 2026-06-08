# 参数：
# - #step mqp.util.entity_projection：沿执行位置视线检测的最大步数；每步前进 0.2 格，需在调用前写入计分板。
# - execute_function：找到匹配实体时执行的函数路径；函数通过 with storage mqp:util.entity_projection 调用。
# - execute_on_fail_function：步数耗尽且未找到匹配实体时执行的函数路径；函数通过 with storage mqp:util.entity_projection 调用。
# - entity_type_tag：实体选择器 type 参数，可为单个实体类型或实体类型标签。
# - inverse_selection：是否反选 entity_type_tag；0 表示匹配 type=$(entity_type_tag)，1 表示排除 type=$(entity_type_tag)。
return run execute anchored eyes run function mica_quick_panel:util/entity_projection/loop