#!/usr/bin/env python3
"""
mica_quick_panel Trigger 生成脚本 (CLI)

用法:
    python generate_triggers.py                  # 生成 .mcfunction
    python generate_triggers.py --validate       # 校验路径
    python generate_triggers.py --tree           # 列出所有可用函数
    python generate_triggers.py --discover       # 从现有文件还原 YAML
"""

import io, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

from trigger_core import (
    load_yaml, save_yaml, get_all_functions,
    validate_paths, generate_module_files,
    discover_modules, format_discover_yaml,
    YAML_PATH, SCRIPT_DIR,
)


def cmd_generate():
    modules = load_yaml()
    if not modules:
        print("错误: triggers.yaml 为空或不存在", file=sys.stderr)
        sys.exit(1)
    changed = generate_module_files(modules)
    if changed:
        print(f"已生成/更新 {len(changed)} 个文件:")
        for f in changed:
            print(f"  ./{f}")
    else:
        print("所有文件已是最新。")


def cmd_validate():
    modules = load_yaml()
    if not modules:
        print("错误: triggers.yaml 为空或不存在", file=sys.stderr)
        sys.exit(1)
    errors = validate_paths(modules)
    if errors:
        print(f"发现 {len(errors)} 个错误:\n")
        for name, field, path, hint in errors:
            print(f"  [{name}] {field}: {path}  → 不存在{hint}")
        sys.exit(1)
    else:
        print("[OK] 所有函数路径均有效")


def cmd_tree():
    for f in get_all_functions():
        print(f)


def cmd_discover():
    modules = discover_modules()
    if not modules:
        print("未发现任何现有 trigger 配置。")
        return
    yaml_text = format_discover_yaml(modules)
    print(f"发现 {sum(len(m['triggers']) for m in modules)} 个 trigger\n")
    print("-" * 50)
    print(yaml_text)
    print("-" * 50)
    yn = input("\n写入 triggers.yaml? (Y/n): ").strip().lower()
    if yn in ("", "y", "yes"):
        # 用 save_yaml 保存结构化数据, 再用格式化文本覆盖
        save_yaml(modules)
        # save_yaml 的格式可能不够美观, 替换为格式化版本
        with open(YAML_PATH, "w", encoding="utf-8") as f:
            f.write(yaml_text)
        print(f"已写入 {YAML_PATH}")
    else:
        print("已取消")


def main():
    modes = {
        "--validate": cmd_validate,
        "--tree": cmd_tree,
        "--discover": cmd_discover,
    }
    if len(sys.argv) > 2:
        print("用法: python generate_triggers.py [--validate|--tree|--discover]", file=sys.stderr)
        sys.exit(1)
    mode = sys.argv[1] if len(sys.argv) == 2 else "generate"
    if mode in modes:
        modes[mode]()
    elif mode in ("generate", "gen"):
        cmd_generate()
    else:
        print(f"未知参数: {mode}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
