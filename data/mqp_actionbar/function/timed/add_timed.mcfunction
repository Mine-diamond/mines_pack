# 输入：
# storage mqp_actionbar:api msg
# storage mqp_actionbar:api duration，可选，默认 40
# storage mqp_actionbar:api source，可选

# 如果没有 duration，默认显示 40 tick
execute unless data storage mqp_actionbar:api duration run data modify storage mqp_actionbar:api duration set value 40

# 只有存在 msg 时才真正创建消息
execute if data storage mqp_actionbar:api msg run function mqp_actionbar:timed/add_timed_impl

# 清理接口缓存
data remove storage mqp_actionbar:api msg
data remove storage mqp_actionbar:api duration
data remove storage mqp_actionbar:api source