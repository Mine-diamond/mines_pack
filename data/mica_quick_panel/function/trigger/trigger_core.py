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
    """扫描 function/ 下的一级子目录和 function/module/ 下的子目录（均排除 trigger/），返回排序列表"""
    dirs = set()
    if not FUNCTION_DIR.exists():
        return []
    for d in FUNCTION_DIR.iterdir():
        if d.is_dir() and d.name not in ("trigger", "module"):
            dirs.add(d.name)
    module_dir = FUNCTION_DIR / "module"
    if module_dir.exists():
        for d in module_dir.iterdir():
            if d.is_dir():
                dirs.add(d.name)
    return sorted(dirs)


def get_name_prefix(module_dir: str) -> str:
    """返回建议的 trigger name 前缀"""
    if (FUNCTION_DIR / "module" / module_dir).is_dir():
        return f"mqp.trigger.{module_dir}."
    if (FUNCTION_DIR / module_dir).is_dir():
        return f"mqp.{module_dir}."
    return f"mqp.trigger.{module_dir}."


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

def quote_yaml_string(value) -> str:
    """返回双引号 YAML 字符串，供手写格式化输出使用"""
    text = str(value)
    text = text.replace("\\", "\\\\")
    text = text.replace("\"", "\\\"")
    text = text.replace("\n", "\\n")
    text = text.replace("\r", "\\r")
    return f'"{text}"'


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
            lines.append(f"        display: {quote_yaml_string(t['display'])}")
            if t.get("init") is not None:
                lines.append(f"        init: {t['init']}")
            if t.get("range") not in (None, DEFAULT_RANGE):
                lines.append(f"        range: {quote_yaml_string(t['range'])}")
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

def validate_config(modules: list) -> list:
    """返回配置结构错误 [(位置, 字段, 值, 说明), ...]"""
    errors = []
    if not isinstance(modules, list):
        return [("modules", "type", type(modules).__name__, "必须是列表")]

    seen_dirs = {}
    seen_names = {}
    for mi, module in enumerate(modules):
        where = f"modules[{mi}]"
        if not isinstance(module, dict):
            errors.append((where, "type", type(module).__name__, "必须是对象"))
            continue
        module_dir = module.get("dir")
        if not isinstance(module_dir, str) or not module_dir.strip():
            errors.append((where, "dir", module_dir, "必须是非空字符串"))
        elif module_dir in seen_dirs:
            errors.append((where, "dir", module_dir, f"重复模块目录，已在 modules[{seen_dirs[module_dir]}] 使用"))
        else:
            seen_dirs[module_dir] = mi
        triggers = module.get("triggers")
        if not isinstance(triggers, list):
            errors.append((where, "triggers", type(triggers).__name__, "必须是列表"))
            continue

        for ti, trigger in enumerate(triggers):
            t_where = f"{where}.triggers[{ti}]"
            if not isinstance(trigger, dict):
                errors.append((t_where, "type", type(trigger).__name__, "必须是对象"))
                continue
            for field in ("name", "display"):
                value = trigger.get(field)
                if not isinstance(value, str) or not value.strip():
                    errors.append((t_where, field, value, "必须是非空字符串"))
            name = trigger.get("name")
            if isinstance(name, str) and name.strip():
                if name in seen_names:
                    errors.append((t_where, "name", name, f"重复 trigger name，已在 {seen_names[name]} 使用"))
                else:
                    seen_names[name] = t_where
            for field in ("init", "reset"):
                if field in trigger and not isinstance(trigger[field], int):
                    errors.append((t_where, field, trigger[field], "必须是整数"))
            if "range" in trigger and not isinstance(trigger["range"], str):
                errors.append((t_where, "range", trigger["range"], "必须是字符串"))
            actions = trigger.get("actions", [])
            if not isinstance(actions, list):
                errors.append((t_where, "actions", type(actions).__name__, "必须是列表"))
            else:
                for ai, action in enumerate(actions):
                    if not isinstance(action, str) or not action.strip():
                        errors.append((t_where, f"actions[{ai}]", action, "必须是非空字符串"))
            mapping = trigger.get("mapping_actions", {})
            if not isinstance(mapping, dict):
                errors.append((t_where, "mapping_actions", type(mapping).__name__, "必须是字典"))
            else:
                for key, action in mapping.items():
                    if not isinstance(key, int):
                        errors.append((t_where, f"mapping_actions key {key}", key, "必须是整数"))
                    if not isinstance(action, str) or not action.strip():
                        errors.append((t_where, f"mapping_actions[{key}]", action, "必须是非空字符串"))
    return errors

def validate_paths(modules: list) -> list:
    """返回 [(trigger_name, 字段名, 路径, 建议), ...] 错误列表"""
    config_errors = validate_config(modules)
    if config_errors:
        return [(where, field, str(value), f"  → {message}") for where, field, value, message in config_errors]

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
    errors = validate_config(modules)
    if errors:
        detail = "; ".join(f"{where} {field}: {message}" for where, field, _value, message in errors)
        raise ValueError(f"triggers.yaml 配置无效: {detail}")

    generated = []
    active_modules = []
    for module in modules:
        subdir = module["dir"]
        trgs = module["triggers"]
        if not trgs:
            continue
        active_modules.append(module)
        for name, fn in [("load.mcfunction", generate_load),
                         ("tick.mcfunction", generate_tick)]:
            p = SCRIPT_DIR / subdir / name
            if write_file(p, fn(trgs)):
                generated.append(str(p.relative_to(SCRIPT_DIR)))

    # 主 load / tick
    for name, fn in [("load.mcfunction", lambda _: "\n".join(
        f"function mica_quick_panel:trigger/{m['dir']}/load" for m in active_modules) + "\n"),
                     ("tick.mcfunction", lambda _: "\n".join(
        f"function mica_quick_panel:trigger/{m['dir']}/tick" for m in active_modules) + "\n")]:
        p = SCRIPT_DIR / name
        if write_file(p, fn(None)):
            generated.append(str(p.relative_to(SCRIPT_DIR)))

    return generated
