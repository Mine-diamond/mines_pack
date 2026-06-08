# 参数：
# - step：沿执行者视线检测的最大步数；每步前进 0.2 格，传入后写入计分板 #step mqp.util.entity_projection。
# - remove_entity：是否移除被复制的实体；1 表示复制后将目标实体置为死亡，其他值不移除。
# 调用方式示例：function mica_quick_panel:util/copy_entity/start with storage <包含 step 与 remove_entity 的 storage>
$scoreboard players set #step mqp.util.entity_projection $(step)
$data merge storage mqp:util.copy_entity {remove_entity:$(remove_entity)}

function mica_quick_panel:util/copy_entity/execute