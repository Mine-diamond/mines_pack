"""trigger 相关共享核心：路径扫描、YAML 读写、mcfunction 生成"""
import io, sys
from pathlib import Path

try:
    import yaml
except ImportError:
    print("错误: 需要 pyyaml。运行: pip install pyyaml", file=sys.stderr)
    sys.exit(1)

# ── 路径 ──────────────────────────────────────────────────────
SCRIPT_DIR = Path(__file__).parent.resolve()
FUNCTION_DIR = (SCRIPT_DIR / "..").resolve()          # function/
NAMESPACE_DIR = FUNCTION_DIR.parent                   # mica_quick_panel/
YAML_PATH = SCRIPT_DIR / "triggers.yaml"

DEFAULT_RANGE = "1.."
DEFAULT_RESET = 0


# ── 模块目录扫描 ──────────────────────────────────────────────

def get_module_dirs() -> list:
    """扫描 function/ 下的一级子目录（排除 trigger/），返回排序列表"""
    dirs = set()
    if not FUNCTION_DIR.exists():
        return []
    for d in FUNCTION_DIR.iterdir():
        if d.is_dir() and d.name != "trigger":
            dirs.add(d.name)
    return sorted(dirs)


# ── Trigger 名称前缀 ──────────────────────────────────────────
# 已知模块的 name 前缀约定，未知模块使用 mqp.trigger.<dir>.
NAME_PREFIXES = {
    "dialog": "mqp.dialog.",
    "game_rule": "mqp.game_rule.",
    "simple_feature": "mqp.trigger.simple_feature.",
    "time_setting": "mqp.trigger.",
    "highlight": "mqp.trigger.highlight.",
    "kill_all_mob": "mqp.trigger.kill_all_mob.",
}


def get_name_prefix(module_dir: str) -> str:
    """返回建议的 trigger name 前缀"""
    return NAME_PREFIXES.get(module_dir, f"mqp.trigger.{module_dir}.")


# ── 函数路径扫描 ──────────────────────────────────────────────

def get_all_functions() -> list:
    """返回所有 mcfunction 路径, mica_quick_panel:xxx/xxx 格式, 排序"""
    funcs = set()
    if not FUNCTION_DIR.exists():
        return []
    for f in FUNCTION_DIR.rglob("*.mcfunction"):
        rel = f.relative_to(NAMESPACE_DIR)
        parts = list(rel.parts)
        if parts and parts[0] == "function":
            parts = parts[1:]
        path = "/".join(parts).removesuffix(".mcfunction")
        if path.startswith("trigger/"):         # 排除自动生成的 trigger 文件
            continue
        funcs.add(f"mica_quick_panel:{path}")
    return sorted(funcs)


# ── YAML 读写 ─────────────────────────────────────────────────

def load_yaml() -> list:
    """读取 triggers.yaml 返回 modules 列表"""
    if not YAML_PATH.exists():
        return []
    with open(YAML_PATH, "r", encoding="utf-8") as f:
        cfg = yaml.safe_load(f)
    return cfg.get("modules", []) if cfg else []


def save_yaml(modules: list):
    """将 modules 写回 triggers.yaml, 格式干净可读"""
    lines = [
        "# 由 trigger_core 写入\n",
        "modules:",
    ]
    for m in modules:
        lines.append(f"  - dir: {m['dir']}")
        lines.append("    triggers:")
        for t in m["triggers"]:
            lines.append(f"      - name: {t['name']}")
            lines.append(f"        display: \"{t['display']}\"")
            if t.get("init") is not None:
                lines.append(f"        init: {t['init']}")
            if t.get("range") not in (None, DEFAULT_RANGE):
                lines.append(f"        range: \"{t['range']}\"")
            if t.get("reset") not in (None, DEFAULT_RESET):
                lines.append(f"        reset: {t['reset']}")
            if t.get("mapping_actions"):
                lines.append("        mapping_actions:")
                for k in sorted(t["mapping_actions"]):
                    lines.append(f"          {k}: {t['mapping_actions'][k]}")
            if t.get("actions"):
                lines.append("        actions:")
                for a in t["actions"]:
                    lines.append(f"          - {a}")
    with open(YAML_PATH, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")


# ── 路径校验 ──────────────────────────────────────────────────

def validate_paths(modules: list) -> list:
    """返回 [(trigger_name, 字段名, 路径, 建议), ...] 错误列表"""
    available = get_all_functions()
    errors = []
    from difflib import get_close_matches

    for m in modules:
        for t in m["triggers"]:
            name = t["name"]
            for v, func in t.get("mapping_actions", {}).items():
                if func not in available:
                    hints = get_close_matches(func, available, n=3, cutoff=0.4)
                    hint = f"  → {', '.join(hints)}" if hints else ""
                    errors.append((name, f"mapping [{v}]", func, hint))
            for func in t.get("actions", []):
                if func not in available:
                    hints = get_close_matches(func, available, n=3, cutoff=0.4)
                    hint = f"  → {', '.join(hints)}" if hints else ""
                    errors.append((name, "actions", func, hint))
    return errors


# ── mcfunction 生成 ───────────────────────────────────────────

def generate_load(triggers: list) -> str:
    lines = []
    for t in triggers:
        display = t["display"].replace("\\", "\\\\").replace("\"", "\\\"")
        lines.append(f"scoreboard objectives add {t['name']} trigger")
        lines.append(f"scoreboard objectives modify {t['name']} displayname \"{display}\"")
        lines.append(f"scoreboard players enable @a {t['name']}")
        if t.get("init") is not None:
            lines.append(f"scoreboard players set @a {t['name']} {t['init']}")
        lines.append("")
    return "\n".join(lines).rstrip("\n") + "\n"


def generate_tick(triggers: list) -> str:
    lines = []
    for t in triggers:
        name = t["name"]
        range_ = t.get("range", DEFAULT_RANGE)
        reset_ = t.get("reset", DEFAULT_RESET)

        for v in sorted(t.get("mapping_actions", {})):
            lines.append(f"execute as @a[scores={{{name}={v}}}] run function {t['mapping_actions'][v]}")
        for func in t.get("actions", []):
            lines.append(f"execute as @a[scores={{{name}={range_}}}] run function {func}")
        lines.append(f"scoreboard players set @a[scores={{{name}={range_}}}] {name} {reset_}")
        lines.append(f"scoreboard players enable @a {name}")
        lines.append("")
    return "\n".join(lines).rstrip("\n") + "\n"


def write_file(path: Path, content: str) -> bool:
    path.parent.mkdir(parents=True, exist_ok=True)
    try:
        if path.read_text("utf-8") == content:
            return False
    except FileNotFoundError:
        pass
    path.write_text(content, "utf-8")
    return True


def generate_module_files(modules: list) -> list:
    """生成所有 .mcfunction, 返回变更文件相对路径列表"""
    generated = []
    for module in modules:
        subdir = module["dir"]
        trgs = module["triggers"]
        if not trgs:
            continue
        for name, fn in [("load.mcfunction", generate_load),
                         ("tick.mcfunction", generate_tick)]:
            p = SCRIPT_DIR / subdir / name
            if write_file(p, fn(trgs)):
                generated.append(str(p.relative_to(SCRIPT_DIR)))

    # 主 load / tick
    for name, fn in [("load.mcfunction", lambda _: "\n".join(
        f"function mica_quick_panel:trigger/{m['dir']}/load" for m in modules) + "\n"),
                     ("tick.mcfunction", lambda _: "\n".join(
        f"function mica_quick_panel:trigger/{m['dir']}/tick" for m in modules) + "\n")]:
        p = SCRIPT_DIR / name
        if write_file(p, fn(None)):
            generated.append(str(p.relative_to(SCRIPT_DIR)))

    return generated


# ── 发现（从现有文件还原配置）──────────────────────────────────

KNOWN_MODULES = ["dialog", "game_rule", "simple_feature", "time_setting", "highlight", "kill_all_mob"]

MODULE_COMMENTS = {
    "dialog": "对话框面板",
    "game_rule": "游戏规则",
    "simple_feature": "快捷开关（夜视/无敌/赶路）",
    "time_setting": "时间设置",
    "highlight": "高亮设置",
    "kill_all_mob": "清理实体",
}

import re
_LOAD_RE = re.compile(r"scoreboard objectives add (\S+) trigger")
_DISPLAY_RE = re.compile(r'scoreboard objectives modify \S+ displayname "(.+)"')
_INIT_RE = re.compile(r"scoreboard players set @a (\S+) (-?\d+)")
_TICK_MAP_RE = re.compile(r'execute as @a\[scores=\{([^}]+)=(\d+)\}\] run function (\S+)')
_TICK_ACT_RE = re.compile(r'execute as @a\[scores=\{([^}]+)=(\d+\.\.)\}\] run function (\S+)')
_TICK_RST_RE = re.compile(r"scoreboard players set @a\[scores=\{([^}]+)=(\d+\.\.)\}\] \1 (-?\d+)")


def discover_modules() -> list:
    """扫描现有 trigger/*/load+tick 文件, 还原 modules 配置"""
    modules = []
    for subdir in KNOWN_MODULES:
        lp = SCRIPT_DIR / subdir / "load.mcfunction"
        tp = SCRIPT_DIR / subdir / "tick.mcfunction"
        if not lp.exists() or not tp.exists():
            continue

        lt = lp.read_text("utf-8")
        tt = tp.read_text("utf-8")

        # 解析 load
        names = _LOAD_RE.findall(lt)
        displays = _DISPLAY_RE.findall(lt)
        inits = {m.group(1): int(m.group(2)) for m in _INIT_RE.finditer(lt)}
        load_info = {}
        for n, d in zip(names, displays):
            info = {"display": d}
            if n in inits:
                info["init"] = inits[n]
            load_info[n] = info

        # 解析 tick (按空行分块)
        triggers = []
        for block in re.split(r"\n\s*\n", tt.strip()):
            if not block.strip():
                continue
            rst = _TICK_RST_RE.search(block)
            if not rst:
                continue
            name, range_, reset_val = rst.group(1), rst.group(2), int(rst.group(3))
            mapping = {}
            actions = []
            for line in block.splitlines():
                m = _TICK_MAP_RE.match(line)
                if m and m.group(1) == name:
                    mapping[int(m.group(2))] = m.group(3)
                    continue
                a = _TICK_ACT_RE.match(line)
                if a and a.group(1) == name:
                    actions.append(a.group(3))
            entry = {"name": name, "display": load_info.get(name, {}).get("display", name)}
            if name in inits:
                entry["init"] = inits[name]
            if range_ != DEFAULT_RANGE:
                entry["range"] = range_
            if reset_val != DEFAULT_RESET:
                entry["reset"] = reset_val
            if mapping:
                entry["mapping_actions"] = mapping
            if actions:
                entry["actions"] = actions
            triggers.append(entry)

        if triggers:
            modules.append({"dir": subdir, "triggers": triggers})
    return modules


def format_discover_yaml(modules: list) -> str:
    lines = [
        "# 自动生成的 trigger 配置文件 (--discover)",
        "",
        "modules:",
    ]
    for m in modules:
        comment = MODULE_COMMENTS.get(m["dir"], m["dir"])
        lines.append(f"  # {'─' * 2} {comment} {'─' * 45}")
        lines.append(f"  - dir: {m['dir']}")
        lines.append("    triggers:")
        for t in m["triggers"]:
            lines.append(f"      - name: {t['name']}")
            lines.append(f"        display: \"{t['display']}\"")
            if t.get("init") is not None:
                lines.append(f"        init: {t['init']}")
            if t.get("range") is not None:
                lines.append(f"        range: \"{t['range']}\"")
            if t.get("reset") is not None:
                lines.append(f"        reset: {t['reset']}")
            if t.get("mapping_actions"):
                lines.append("        mapping_actions:")
                for v in sorted(t["mapping_actions"]):
                    lines.append(f"          {v}: {t['mapping_actions'][v]}")
            if t.get("actions"):
                lines.append("        actions:")
                for a in t["actions"]:
                    lines.append(f"          - {a}")
            lines.append("")
    return "\n".join(lines)
