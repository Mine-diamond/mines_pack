# 如果 rest 已经为空，则把 out 写入 result
execute if data storage mqp:util.str.replace {rest:""} run data modify storage mqp:util.str.replace result set from storage mqp:util.str.replace out

# 如果 rest 不为空，则继续处理下一个字符
execute unless data storage mqp:util.str.replace {rest:""} run function mica_quick_panel:util/str/replace/step with storage mqp:util.str.replace