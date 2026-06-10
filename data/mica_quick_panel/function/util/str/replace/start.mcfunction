# 初始化待处理字符串
data modify storage mqp:util.str.replace rest set string storage mqp:util.str.replace input

# 初始化输出字符串
data modify storage mqp:util.str.replace out set value ""

# clear result
data remove storage mqp:util.str.replace result

# 开始循环
function mica_quick_panel:util/str/replace/loop


# 调用示例

# data modify storage mqp:util.str.replace input set value "&c红色文字 &l加粗 &r重置"
# data modify storage mqp:util.str.replace from set value "&"
# data modify storage mqp:util.str.replace to set value "§"

# function mica_quick_panel:util/str/replace/start