execute store result score #temp mqp.temp if data storage mqp:way_point.dialog {all_content:""}
$execute if score #temp mqp.temp matches 1 run data merge storage mqp:way_point.dialog {all_content:'$(new_row),'}
$execute unless score #temp mqp.temp matches 1 run data merge storage mqp:way_point.dialog {all_content:'$(all_content)$(new_row),'}