# 输入：
# storage mqp_actionbar:api msg = JSON 文本组件字符串

execute if data storage mqp_actionbar:api msg run data modify storage mqp_actionbar:buffer parts append from storage mqp_actionbar:api msg

# 清理接口缓存
data remove storage mqp_actionbar:api msg
