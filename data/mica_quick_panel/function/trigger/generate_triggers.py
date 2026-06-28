#!/usr/bin/env python3
"""
mica_quick_panel Trigger 生成脚本 (CLI)

用法:
    python generate_triggers.py                  # 生成 .mcfunction
    python generate_triggers.py --validate       # 校验路径
    python generate_triggers.py --tree           # 列出所有可用函数
"""

import io, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

from trigger_core import (
    load_yaml, get_all_functions,
    validate_paths, generate_module_files,
)


def cmd_generate():
    modules = load_yaml()
    if not modules:
        print("错误: triggers.yaml 为空或不存在", file=sys.stderr)
        sys.exit(1)
    try:
        changed = generate_module_files(modules)
    except ValueError as e:
        print(f"错误: {e}", file=sys.stderr)
        sys.exit(1)
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


def main():
    modes = {
        "--validate": cmd_validate,
        "--tree": cmd_tree,
    }
    if len(sys.argv) > 2:
        print("用法: python generate_triggers.py [--validate|--tree]", file=sys.stderr)
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
