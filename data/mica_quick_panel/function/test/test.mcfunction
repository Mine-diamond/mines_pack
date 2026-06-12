# - #max_step mqp.util.block_projection：沿执行位置视线检测的最大步数；每步前进 0.2 格，需在调用前写入计分板。
# - block_type_tag：方块选择器 type 参数，可为单个实体类型或实体类型标签。
# - inverse_selection：是否反选 block_type_tag；0 表示匹配 (block_type_tag)，1 表示排除 $(block_type_tag)。

scoreboard players set #max_step mqp.util.block_projection 200
data merge storage mqp:util.block_projection {block_type_tag:"air",inverse_selection:1}

function mica_quick_panel:util/block_projection/start