# 取出 rest 的第一个字符
data modify storage mqp:util.str.replace char set string storage mqp:util.str.replace rest 0 1

# 删除 rest 的第一个字符
data modify storage mqp:util.str.replace rest set string storage mqp:util.str.replace rest 1

# tellraw @a ["rest: ",{storage:"mqp:util.str.replace",nbt:"rest"}]

# 如果当前字符等于 from，则追加 to
$execute if data storage mqp:util.str.replace {char:"$(from)"} run function mica_quick_panel:util/str/replace/append_to with storage mqp:util.str.replace

# 如果当前字符不等于 from，则追加原字符 char
$execute unless data storage mqp:util.str.replace {char:"$(from)"} run function mica_quick_panel:util/str/replace/append_char with storage mqp:util.str.replace

# 注意：必须在两个分支判断之后再统一继续循环
function mica_quick_panel:util/str/replace/loop