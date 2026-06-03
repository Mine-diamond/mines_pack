#!/usr/bin/env python3
"""
Trigger 自动化生成脚本
放置于 mica_quick_panel/function/trigger/ 目录下运行。
生成各子模块的 load.mcfunction 和 tick.mcfunction，
以及主 trigger/load.mcfunction 和 trigger/tick.mcfunction。

用法:
    cd <datapack>/data/mica_quick_panel/function/trigger/
    python generate_triggers.py
"""

import os
from pathlib import Path

SCRIPT_DIR = Path(__file__).parent.resolve()

# ---------------------------------------------------------------------------
# 模块定义：每个模块包含一组 trigger 定义
# 字段说明：
#   name            - scoreboard objective 名称
#   display         - 显示名（displayname）
#   init            - 初始值（可选，默认不设置）
#   range           - tick 中 execute 的分数范围（默认 "1.."）
#   reset           - 处理后的重置值（默认 0）
#   mapping_actions - {值: 函数} 映射（可选），按值精确匹配分派
#   actions         - 通用操作函数列表，按 range 匹配执行
# ---------------------------------------------------------------------------
MODULES = [
    {
        "dir": "dialog",
        "triggers": [
            {
                "name": "mqp.dialog.game_rule",
                "display": "游戏规则设置面板",
                "actions": ["mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog"],
            },
            {
                "name": "mqp.game_rule.random_tick_speed",
                "display": "随机刻速度设置面板",
                "actions": ["mica_quick_panel:dialog/gamerule_dialog/open_random_tick_dialog"],
            },
            {
                "name": "mqp.dialog.simple_feature",
                "display": "功能设置面板",
                "actions": ["mica_quick_panel:dialog/simple_feature_dialog/open_simple_feature_dialog"],
            },
            {
                "name": "mqp.dialog.time_setting",
                "display": "时间设置面板",
                "actions": ["mica_quick_panel:dialog/time_setting_dialog/open_time_setting_dialog"],
            },
            {
                "name": "mqp.dialog.moon_phase",
                "display": "设置月相",
                "actions": ["mica_quick_panel:dialog/time_setting_dialog/open_moon_phase_setting_dialog"],
            },
            {
                "name": "mqp.dialog.highlight",
                "display": "高亮设置面板",
                "actions": ["mica_quick_panel:dialog/highlight_dialog/open_highlight_dialog"],
            },
            {
                "name": "mqp.dialog.kill_all_mob",
                "display": "清理实体确认面板",
                "actions": ["mica_quick_panel:dialog/kill_all_mob_dialog/open_kill_all_mob_dialog"],
            },
        ],
    },
    {
        "dir": "game_rule",
        "triggers": [
            {
                "name": "mqp.game_rule.change",
                "display": "修改游戏规则",
                "mapping_actions": {
                    1: "mica_quick_panel:game_rule_change/switch_advance_time",
                    2: "mica_quick_panel:game_rule_change/switch_advance_weather",
                    3: "mica_quick_panel:game_rule_change/switch_spawn_mobs",
                    4: "mica_quick_panel:game_rule_change/switch_keep_inventory",
                    5: "mica_quick_panel:game_rule_change/switch_command_block_output",
                    6: "mica_quick_panel:game_rule_change/switch_mob_drops",
                    7: "mica_quick_panel:game_rule_change/switch_block_drops",
                    8: "mica_quick_panel:game_rule_change/switch_show_advancement_messages",
                },
                "actions": ["mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog"],
            },
            {
                "name": "mqp.game_rule.set_to_preferred",
                "display": "设置为首选状态",
                "actions": [
                    "mica_quick_panel:game_rule_change/set_game_rule_to_preferred_state",
                    "mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog",
                ],
            },
            {
                "name": "mqp.game_rule.set_random_tick_speed",
                "display": "设置随机刻速度",
                "init": -1,
                "range": "0..",
                "reset": -1,
                "actions": [
                    "mica_quick_panel:game_rule_change/set_random_tick_speed_init",
                    "mica_quick_panel:dialog/gamerule_dialog/open_gamerule_dialog",
                ],
            },
        ],
    },
    {
        "dir": "simple_feature",
        "triggers": [
            {
                "name": "mqp.simple_feature.night_version",
                "display": "修改夜视效果",
                "actions": [
                    "mica_quick_panel:simple_feature/night_version/switch_night_version",
                    "mica_quick_panel:dialog/simple_feature_dialog/open_simple_feature_dialog",
                ],
            },
            {
                "name": "mqp.trigger.simple_feature.invulnerable_mode",
                "display": "修改无敌模式",
                "actions": [
                    "mica_quick_panel:simple_feature/invulnerable_mode/switch_invulnerable_mode",
                    "mica_quick_panel:dialog/simple_feature_dialog/open_simple_feature_dialog",
                ],
            },
            {
                "name": "mqp.trigger.simple_feature.run_mode",
                "display": "切换赶路模式",
                "actions": [
                    "mica_quick_panel:simple_feature/run_mode/switch_run_mode",
                    "mica_quick_panel:dialog/simple_feature_dialog/open_simple_feature_dialog",
                ],
            },
        ],
    },
    {
        "dir": "time_setting",
        "triggers": [
            {
                "name": "mqp.trigger.time_setting",
                "display": "设置时间",
                "init": -1,
                "range": "0..",
                "reset": -1,
                "actions": [
                    "mica_quick_panel:time_setting/set_time_init",
                    "mica_quick_panel:dialog/time_setting_dialog/open_time_setting_dialog",
                ],
            },
            {
                "name": "mqp.trigger.moon_phase",
                "display": "设置月相",
                "init": -1,
                "range": "0..",
                "reset": -1,
                "actions": [
                    "mica_quick_panel:time_setting/set_moon_phase",
                    "mica_quick_panel:dialog/time_setting_dialog/open_moon_phase_setting_dialog",
                ],
            },
        ],
    },
    {
        "dir": "highlight",
        "triggers": [
            {
                "name": "mqp.trigger.highlight.entity_enabled_flags",
                "display": "切换实体高亮",
                "actions": [
                    "mica_quick_panel:highlight/switch_entity_highlight",
                    "mica_quick_panel:dialog/highlight_dialog/open_highlight_dialog",
                ],
            },
            {
                "name": "mqp.trigger.highlight.player_enabled_flags",
                "display": "切换玩家高亮",
                "actions": [
                    "mica_quick_panel:highlight/switch_player_highlight",
                    "mica_quick_panel:dialog/highlight_dialog/open_highlight_dialog",
                ],
            },
            {
                "name": "mqp.trigger.highlight.item_enabled_flags",
                "display": "切换物品高亮",
                "actions": [
                    "mica_quick_panel:highlight/switch_item_highlight",
                    "mica_quick_panel:dialog/highlight_dialog/open_highlight_dialog",
                ],
            },
        ],
    },
    {
        "dir": "kill_all_mob",
        "triggers": [
            {
                "name": "mqp.trigger.kill_all_mob.close_mob_loot",
                "display": "切换击杀生物是否掉落物品",
                "actions": [
                    "mica_quick_panel:kill_all_mob/switch_gen_drops",
                    "mica_quick_panel:dialog/kill_all_mob_dialog/open_kill_all_mob_dialog",
                ],
            },
            {
                "name": "mqp.trigger.kill_all_mob.kill_type",
                "display": "切换清除类型",
                "actions": [
                    "mica_quick_panel:kill_all_mob/switch_kill_type",
                    "mica_quick_panel:dialog/kill_all_mob_dialog/open_kill_all_mob_dialog",
                ],
            },
            {
                "name": "mqp.trigger.kill_all_mob.kill_all_mob",
                "display": "清除生物",
                "actions": [
                    "mica_quick_panel:kill_all_mob/kill_all_mob",
                    "mica_quick_panel:dialog/kill_all_mob_dialog/open_kill_all_mob_dialog",
                ],
            },
        ],
    },
]


def _escape_display(text: str) -> str:
    """确保 displayname 中的引号被转义"""
    return text.replace("\\", "\\\\").replace("\"", "\\\"")


def generate_load(triggers: list) -> str:
    lines = []
    for t in triggers:
        name = t["name"]
        display = _escape_display(t["display"])
        lines.append(f"scoreboard objectives add {name} trigger")
        lines.append(f"scoreboard objectives modify {name} displayname \"{display}\"")
        lines.append(f"scoreboard players enable @a {name}")
        if t.get("init") is not None:
            lines.append(f"scoreboard players set @a {name} {t['init']}")
        lines.append("")
    return "\n".join(lines).rstrip("\n") + "\n"


def generate_tick(triggers: list) -> str:
    lines = []
    for t in triggers:
        name = t["name"]
        range_val = t.get("range", "1..")
        reset_val = t.get("reset", 0)

        # 映射分派：精确值匹配
        for value, func in sorted(t.get("mapping_actions", {}).items()):
            lines.append(f"execute as @a[scores={{{name}={value}}}] run function {func}")

        # 通用操作：范围匹配
        for func in t.get("actions", []):
            lines.append(f"execute as @a[scores={{{name}={range_val}}}] run function {func}")

        # 重置并重新启用
        lines.append(f"scoreboard players set @a[scores={{{name}={range_val}}}] {name} {reset_val}")
        lines.append(f"scoreboard players enable @a {name}")
        lines.append("")

    return "\n".join(lines).rstrip("\n") + "\n"


def generate_main_load() -> str:
    return "\n".join(
        f"function mica_quick_panel:trigger/{m['dir']}/load"
        for m in MODULES
    ) + "\n"


def generate_main_tick() -> str:
    return "\n".join(
        f"function mica_quick_panel:trigger/{m['dir']}/tick"
        for m in MODULES
    ) + "\n"


def write_file(path: Path, content: str) -> bool:
    """写入文件，仅内容变化时才真正写入。返回是否写入。"""
    path.parent.mkdir(parents=True, exist_ok=True)
    try:
        existing = path.read_text(encoding="utf-8")
        if existing == content:
            return False
    except FileNotFoundError:
        pass
    path.write_text(content, encoding="utf-8")
    return True


def main():
    generated = []

    # 各子模块的 load / tick
    for module in MODULES:
        subdir = module["dir"]
        triggers = module["triggers"]
        if not triggers:
            continue

        for filename, generator in [("load.mcfunction", generate_load),
                                    ("tick.mcfunction", generate_tick)]:
            filepath = SCRIPT_DIR / subdir / filename
            content = generator(triggers)
            if write_file(filepath, content):
                generated.append(str(filepath.relative_to(SCRIPT_DIR)))

    # 主 load / tick
    for filename, generator in [("load.mcfunction", generate_main_load),
                                ("tick.mcfunction", generate_main_tick)]:
        filepath = SCRIPT_DIR / filename
        content = generator()
        if write_file(filepath, content):
            generated.append(str(filepath.relative_to(SCRIPT_DIR)))

    if generated:
        print(f"已生成/更新 {len(generated)} 个文件:")
        for f in generated:
            print(f"  ./{f}")
    else:
        print("所有文件已是最新，无需更新。")


if __name__ == "__main__":
    main()
