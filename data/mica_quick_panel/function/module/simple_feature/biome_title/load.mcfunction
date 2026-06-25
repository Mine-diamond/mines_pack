scoreboard objectives add mqp.simple_feature.biome_title.current_biome dummy
scoreboard objectives add mqp.simple_feature.biome_title.enable dummy

data modify storage mqp:simple_feature.biome_title biome_name set value [ \
    "暖水海洋", \
    "温水海洋", \
    "深温水海洋", \
    "海洋", \
    "深海", \
    "冷水海洋", \
    "深冷水海洋", \
    "冻洋", \
    "深冻洋", \
    "蘑菇岛", \
    "河流", \
    "冻河", \
    "沙滩", \
    "雪滩", \
    "石岸", \
    "草甸", \
    "樱花树林", \
    "雪林", \
    "雪山坡", \
    "尖峭山峰", \
    "冰封山峰", \
    "石峰", \
    "风袭丘陵", \
    "风袭砾质丘陵", \
    "风袭森林", \
    "森林", \
    "繁花森林", \
    "白桦森林", \
    "黑森林", \
    "原始白桦森林", \
    "原始松木针叶林", \
    "原始云杉针叶林", \
    "针叶林", \
    "雪原针叶林", \
    "丛林", \
    "稀疏丛林", \
    "竹林", \
    "平原", \
    "向日葵平原", \
    "雪原", \
    "冰刺平原", \
    "沙漠", \
    "沼泽", \
    "红树林沼泽", \
    "稀树草原", \
    "稀树草原高地", \
    "风袭稀树草原", \
    "恶地", \
    "疏林恶地", \
    "风蚀恶地", \
    "繁茂洞穴", \
    "滴水石锥洞穴", \
    "深暗之域", \
    "硫磺洞穴", \
    "苍白花园", \
    "下界荒地", \
    "绯红森林", \
    "诡异森林", \
    "灵魂沙峡谷", \
    "玄武岩三角洲", \
    "末路之地", \
    "末地高地", \
    "末地内陆", \
    "末地小型岛屿", \
    "末地荒原", \
    "虚空" \
]

schedule function mica_quick_panel:module/simple_feature/biome_title/_schedule_tick 40t replace