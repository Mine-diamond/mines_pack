"""trigger 相关共享核心：路径扫描、YAML 读写、mcfunction 生成"""
import io, re, sys
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
    modules = cfg.get("modules", []) if cfg else []
    for m in modules:
        for t in m.get("triggers", []):
            t["actions"] = [normalize_action(a) for a in t.get("actions", [])]
            for k, v in list((t.get("mapping_actions") or {}).items()):
                t["mapping_actions"][k] = normalize_action(v)
    return modules


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
                    v = to_yaml_action(t["mapping_actions"][k])
                    if isinstance(v, str):
                        lines.append(f"          {k}: {v}")
                    else:
                        lines.append(f"          {k}:")
                        lines.append(f"            function: {v['function']}")
                        lines.append("            macro:")
                        for mk in sorted(v["macro"], key=str):
                            lines.append(f"              {mk}: {_yaml_macro_value(v['macro'][mk])}")
            if t.get("actions"):
                lines.append("        actions:")
                for a in t["actions"]:
                    a = to_yaml_action(a)
                    if isinstance(a, str):
                        lines.append(f"          - {a}")
                    else:
                        lines.append(f"          - function: {a['function']}")
                        lines.append("            macro:")
                        for mk in sorted(a["macro"], key=str):
                            lines.append(f"              {mk}: {_yaml_macro_value(a['macro'][mk])}")
    with open(YAML_PATH, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")


# ── 宏参数支持 ────────────────────────────────────────────────

MACRO_RE = re.compile(r"\$\(([A-Za-z0-9_]+)\)")


def normalize_action(a):
    """str → {"function": a, "macro": {}}；dict → 复制并补默认值。
    绝不抛异常——坏结构留给 validate_config 报友好错误。"""
    if isinstance(a, str):
        return {"function": a, "macro": {}}
    if isinstance(a, dict):
        return {"function": a.get("function", ""), "macro": dict(a.get("macro") or {})}
    return {"function": "", "macro": {}}


def to_yaml_action(a):
    """归一化 dict → YAML 写回值：无 macro 回退字符串，有 macro 返回 dict（key 排序）"""
    a = normalize_action(a)
    if not a["macro"]:
        return a["function"]
    return {"function": a["function"], "macro": {k: a["macro"][k] for k in sorted(a["macro"], key=str)}}


def function_path_to_file(path):
    """'mica_quick_panel:module/x/y' → FUNCTION_DIR/module/x/y.mcfunction；非本命名空间返回 None"""
    if not isinstance(path, str) or not path.startswith("mica_quick_panel:"):
        return None
    rel = path.split(":", 1)[1]
    return FUNCTION_DIR / f"{rel}.mcfunction"


def get_macro_names(path) -> list:
    """读取函数文件，返回其宏命令行中的 $() 宏参数名（去重排序）。

    仅识别以 $ 开头的宏命令行（如 `$say $(content)`）；普通命令（如
    `say $(content)`）与注释中的 $(...) 是字面文本，Minecraft 不替换。
    文件不存在/非本命名空间返回 []。
    """
    f = function_path_to_file(path)
    if f is None or not f.is_file():
        return []
    try:
        text = f.read_text("utf-8")
    except OSError:
        return []
    names = set()
    for line in text.splitlines():
        stripped = line.strip()
        if stripped.startswith("$"):
            names.update(MACRO_RE.findall(stripped))
    return sorted(names)


def _yaml_macro_value(v):
    """YAML 写回的宏参数值：bool/int/float 原样文本，其余带引号字符串（round-trip 类型稳定）"""
    if isinstance(v, bool):
        return "true" if v else "false"
    if isinstance(v, (int, float)):
        return str(v)
    return quote_yaml_string(str(v))


def _to_nbt(v):
    """dict/list 兜底序列化为 NBT 文本（供 YAML 手写复合/列表值使用）"""
    if isinstance(v, dict):
        return "{" + ",".join(f"{k}:{_to_nbt(x)}" for k, x in v.items()) + "}"
    if isinstance(v, (list, tuple)):
        return "[" + ",".join(_to_nbt(x) for x in v) + "]"
    return render_macro_value(v)


def render_macro_value(v):
    """自动推断类型的 NBT 值渲染（bool 必须先于 int 判断）"""
    if isinstance(v, bool):
        return "true" if v else "false"
    if isinstance(v, (int, float)):
        return str(v)
    if isinstance(v, (dict, list)):
        return _to_nbt(v)
    s = str(v)
    if s in ("true", "false"):
        return s
    if re.match(r"^-?(?:\d+\.?\d*|\.\d+)$", s):
        return s
    if s[:1] in ("{", "[", "\""):
        return s
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"') + '"'


def render_macro(macro) -> str:
    """'k1:v1, k2:v2'；空 dict 返回 ''。key 排序保证幂等。"""
    if not macro:
        return ""
    return "{" + ", ".join(
        f"{k}:{render_macro_value(v)}" for k, v in sorted(macro.items(), key=lambda kv: str(kv[0]))
    ) + "}"


def render_action_call(a) -> str:
    """'function <path>' 或 'function <path> {k:v}'，供 generate_tick 拼接在 'run ' 之后"""
    a = normalize_action(a)
    m = render_macro(a["macro"])
    return f"function {a['function']} {m}" if m else f"function {a['function']}"


def format_action(a) -> str:
    """路径 + 宏摘要，供 GUI 表格展示"""
    a = normalize_action(a)
    m = render_macro(a["macro"])
    return f"{a['function']} {m}" if m else a["function"]


# ── 路径校验 ──────────────────────────────────────────────────

def _validate_action(where, action, errors):
    """校验单条 action / mapping_action 值：允许非空字符串或 {function, macro} 对象"""
    if isinstance(action, str):
        if not action.strip():
            errors.append((where, "function", action, "必须是非空字符串"))
        return
    if isinstance(action, dict):
        func = action.get("function")
        if not isinstance(func, str) or not func.strip():
            errors.append((where, "function", func, "必须是非空字符串"))
        macro = action.get("macro")
        if macro is not None and not isinstance(macro, dict):
            errors.append((where, "macro", type(macro).__name__, "必须是字典"))
        elif isinstance(macro, dict):
            for mk, mv in macro.items():
                if not isinstance(mk, str) or not re.match(r"^[A-Za-z0-9_]+$", mk):
                    errors.append((where, f"macro key {mk!r}", mk, "必须匹配 ^[A-Za-z0-9_]+$"))
                if mv is None or not isinstance(mv, (str, int, float, bool, dict, list)):
                    errors.append((where, f"macro.{mk}", mv, "值必须是非空标量或 NBT 复合/列表"))
        return
    errors.append((where, "type", type(action).__name__, "必须是字符串或对象"))


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
                    _validate_action(f"{t_where}.actions[{ai}]", action, errors)
            mapping = trigger.get("mapping_actions", {})
            if not isinstance(mapping, dict):
                errors.append((t_where, "mapping_actions", type(mapping).__name__, "必须是字典"))
            else:
                for key, action in mapping.items():
                    if not isinstance(key, int):
                        errors.append((t_where, f"mapping_actions key {key}", key, "必须是整数"))
                    _validate_action(f"{t_where}.mapping_actions[{key}]", action, errors)
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
            for v, raw in t.get("mapping_actions", {}).items():
                func = raw["function"] if isinstance(raw, dict) else raw
                if func not in available:
                    hints = get_close_matches(func, available, n=3, cutoff=0.4)
                    hint = f"  → {', '.join(hints)}" if hints else ""
                    errors.append((name, f"mapping [{v}]", func, hint))
            for i, raw in enumerate(t.get("actions", [])):
                func = raw["function"] if isinstance(raw, dict) else raw
                if func not in available:
                    hints = get_close_matches(func, available, n=3, cutoff=0.4)
                    hint = f"  → {', '.join(hints)}" if hints else ""
                    errors.append((name, f"actions[{i}]", func, hint))
    return errors


def validate_macros(modules) -> list:
    """返回非致命宏参数提示 [(trigger_name, 字段, 函数路径, 提示), ...]
    仅检查已存在的函数路径、且用户填写了 macro 的条目。
    多余的宏参数会被游戏忽略（提示），缺失的参数允许（函数内部可有默认逻辑）。"""
    hints = []
    for m in modules:
        for t in m["triggers"]:
            name = t["name"]
            for v, raw in t.get("mapping_actions", {}).items():
                _check_macro(name, f"mapping[{v}]", raw, hints)
            for i, raw in enumerate(t.get("actions", [])):
                _check_macro(name, f"actions[{i}]", raw, hints)
    return hints


def _check_macro(name, field, raw, hints):
    d = normalize_action(raw)
    if not d["macro"]:
        return
    declared = get_macro_names(d["function"])
    extra = [k for k in d["macro"] if k not in declared]
    if extra:
        if declared:
            known = f"，该函数已定义: {', '.join(declared)}"
        else:
            known = "（该函数未定义任何 $() 宏参数）"
        hints.append((name, field, d["function"],
                      f"宏参数 {', '.join(extra)} 未在该函数 $() 定义中（未知参数会被游戏忽略），请确认是否有笔误{known}"))


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
            lines.append(f"execute as @a[scores={{{name}={v}}}] run {render_action_call(t['mapping_actions'][v])}")
        for action in t.get("actions", []):
            lines.append(f"execute as @a[scores={{{name}={range_}}}] run {render_action_call(action)}")
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
