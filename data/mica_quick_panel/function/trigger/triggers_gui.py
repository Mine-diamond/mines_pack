#!/usr/bin/env python3
"""
mica_quick_panel Trigger 配置 GUI

用法: python triggers_gui.py
"""

import io
import sys
from tkinter import StringVar

import ttkbootstrap as ttk
from ttkbootstrap.constants import *

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

from trigger_core import (
    DEFAULT_RANGE,
    DEFAULT_RESET,
    format_action,
    generate_module_files,
    get_all_functions,
    get_macro_names,
    get_module_dirs,
    get_name_prefix,
    load_yaml,
    normalize_action,
    render_macro,
    save_yaml,
    validate_config,
    validate_macros,
    validate_paths,
)


THEME_NAME = "flatly"


class TriggerEditor:
    def __init__(self):
        self.modules = load_yaml()
        self.all_funcs = get_all_functions()
        self.avail_dirs = get_module_dirs()

        self._mod_idx = None
        self._trg_idx = None
        self._dirty = False
        self._loading_form = False
        self._form_inputs = []
        self._action_buttons = []
        self._mapping_buttons = []
        self._act_meta = {}
        self._map_meta = {}

        self.root = ttk.Window(themename=THEME_NAME)
        self.root.title("Mica Quick Panel - Trigger 编辑器")
        self.root.geometry("1120x700")
        self.root.minsize(900, 560)

        self._status = StringVar(value="就绪")
        self._build_layout()
        self._bind_events()
        self._refresh_tree()
        self._clear_form()
        self._set_form_enabled(False)

    # ------------------------------------------------------------------
    # Layout
    # ------------------------------------------------------------------

    def _build_layout(self):
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(1, weight=1)

        self._build_toolbar(self.root)

        body = ttk.Panedwindow(self.root, orient=HORIZONTAL)
        body.grid(row=1, column=0, sticky=NSEW, padx=10, pady=(0, 8))

        sidebar = ttk.Frame(body, padding=(0, 0, 8, 0))
        editor = ttk.Frame(body)
        body.add(sidebar, weight=1)
        body.add(editor, weight=3)

        self._build_sidebar(sidebar)
        self._build_editor(editor)
        self._build_statusbar(self.root)

    def _build_toolbar(self, parent):
        bar = ttk.Frame(parent, padding=10)
        bar.grid(row=0, column=0, sticky=EW)
        bar.columnconfigure(4, weight=1)

        buttons = [
            ("保存 (Ctrl+S)", self.save, SUCCESS),
            ("生成 .mcfunction", self.generate, PRIMARY),
            ("校验路径", self.validate, INFO),
            ("刷新", self._refresh_cache, SECONDARY),
        ]
        for col, (text, command, style) in enumerate(buttons):
            ttk.Button(bar, text=text, command=command, bootstyle=style).grid(row=0, column=col, padx=(0, 6))

        ttk.Label(bar, textvariable=self._status, anchor=E).grid(row=0, column=4, sticky=EW)

    def _build_sidebar(self, parent):
        parent.columnconfigure(0, weight=1)
        parent.rowconfigure(1, weight=1)

        ttk.Label(parent, text="模块 / Trigger", font=("", 11, "bold")).grid(row=0, column=0, sticky=W, pady=(0, 6))

        tree_frame = ttk.Frame(parent)
        tree_frame.grid(row=1, column=0, sticky=NSEW)
        tree_frame.columnconfigure(0, weight=1)
        tree_frame.rowconfigure(0, weight=1)

        self.tree = ttk.Treeview(tree_frame, show="tree", selectmode="browse")
        tree_scroll = ttk.Scrollbar(tree_frame, orient=VERTICAL, command=self.tree.yview)
        self.tree.configure(yscrollcommand=tree_scroll.set)
        self.tree.grid(row=0, column=0, sticky=NSEW)
        tree_scroll.grid(row=0, column=1, sticky=NS)
        self.tree.bind("<<TreeviewSelect>>", self._on_select)

        module_ops = ttk.Labelframe(parent, text="模块", padding=6)
        module_ops.grid(row=2, column=0, sticky=EW, pady=(8, 0))
        for col in range(4):
            module_ops.columnconfigure(col, weight=1)
        for col, (text, command, style) in enumerate([
            ("添加", self._add_module, SUCCESS),
            ("删除", self._del_module, DANGER),
            ("上移", self._move_module_up, SECONDARY),
            ("下移", self._move_module_down, SECONDARY),
        ]):
            ttk.Button(module_ops, text=text, command=command, bootstyle=f"{style}-outline").grid(
                row=0, column=col, sticky=EW, padx=2
            )

        trigger_ops = ttk.Labelframe(parent, text="Trigger", padding=6)
        trigger_ops.grid(row=3, column=0, sticky=EW, pady=(8, 0))
        for col in range(4):
            trigger_ops.columnconfigure(col, weight=1)
        for col, (text, command, style) in enumerate([
            ("添加", self._add_trigger, SUCCESS),
            ("删除", self._del_trigger, DANGER),
            ("上移", self._move_trigger_up, SECONDARY),
            ("下移", self._move_trigger_down, SECONDARY),
        ]):
            ttk.Button(trigger_ops, text=text, command=command, bootstyle=f"{style}-outline").grid(
                row=0, column=col, sticky=EW, padx=2
            )

    def _build_editor(self, parent):
        parent.columnconfigure(0, weight=1)
        parent.rowconfigure(1, weight=1)
        parent.rowconfigure(2, weight=1)

        self._build_basic_card(parent)
        self._build_actions_card(parent)
        self._build_mapping_card(parent)

    def _build_basic_card(self, parent):
        card = ttk.Labelframe(parent, text="基本设置", padding=10)
        card.grid(row=0, column=0, sticky=EW, pady=(0, 8))
        card.columnconfigure(1, weight=1)
        card.columnconfigure(3, weight=1)

        self._name_var = StringVar()
        self._name_var.trace_add("write", lambda *_: self._mark())
        self._disp_var = StringVar()
        self._disp_var.trace_add("write", lambda *_: self._mark())

        ttk.Label(card, text="Name").grid(row=0, column=0, sticky=W, padx=(0, 8), pady=4)
        self._name_cb = ttk.Combobox(card, values=[], textvariable=self._name_var)
        self._name_cb.grid(row=0, column=1, columnspan=3, sticky=EW, pady=4)
        self._name_cb.bind("<<ComboboxSelected>>", lambda _: self._mark())
        self._form_inputs.append(self._name_cb)

        ttk.Label(card, text="Display").grid(row=1, column=0, sticky=W, padx=(0, 8), pady=4)
        self._disp = ttk.Entry(card, textvariable=self._disp_var)
        self._disp.grid(row=1, column=1, columnspan=3, sticky=EW, pady=4)
        self._form_inputs.append(self._disp)

        self._init_e = self._mk_entry(card, "Init", 2, 0)
        self._range_e = self._mk_entry(card, "Range", 2, 2, DEFAULT_RANGE)
        self._reset_e = self._mk_entry(card, "Reset", 3, 0, str(DEFAULT_RESET))

    def _mk_entry(self, parent, label, row, col, default=""):
        ttk.Label(parent, text=label).grid(row=row, column=col, sticky=W, padx=(0, 8), pady=4)
        var = StringVar(value=default)
        var.trace_add("write", lambda *_: self._mark())
        entry = ttk.Entry(parent, textvariable=var, width=16)
        entry._var = var
        entry.grid(row=row, column=col + 1, sticky=EW, pady=4, padx=(0, 12))
        self._form_inputs.append(entry)
        return entry

    def _build_actions_card(self, parent):
        card = ttk.Labelframe(parent, text="Actions", padding=10)
        card.grid(row=1, column=0, sticky=NSEW, pady=(0, 8))
        card.columnconfigure(0, weight=1)
        card.rowconfigure(0, weight=1)

        table_frame = ttk.Frame(card)
        table_frame.grid(row=0, column=0, sticky=NSEW)
        table_frame.columnconfigure(0, weight=1)
        table_frame.rowconfigure(0, weight=1)

        self._act_t = ttk.Treeview(table_frame, columns=("idx", "func", "macro"), show="headings", selectmode="browse")
        self._act_t.heading("idx", text="#")
        self._act_t.heading("func", text="函数")
        self._act_t.heading("macro", text="宏参数")
        self._act_t.column("idx", width=45, anchor=CENTER, stretch=False)
        self._act_t.column("func", width=430)
        self._act_t.column("macro", width=120)
        act_scroll = ttk.Scrollbar(table_frame, orient=VERTICAL, command=self._act_t.yview)
        self._act_t.configure(yscrollcommand=act_scroll.set)
        self._act_t.grid(row=0, column=0, sticky=NSEW)
        act_scroll.grid(row=0, column=1, sticky=NS)
        self._act_t.bind("<Double-Button-1>", lambda _: self._edit_action())

        ops = ttk.Frame(card)
        ops.grid(row=0, column=1, sticky=NS, padx=(8, 0))
        for text, command, style in [
            ("添加", self._add_action, SUCCESS),
            ("编辑", self._edit_action, PRIMARY),
            ("删除", self._del_action, DANGER),
            ("上移", self._move_action_up, SECONDARY),
            ("下移", self._move_action_down, SECONDARY),
        ]:
            btn = ttk.Button(ops, text=text, command=command, bootstyle=f"{style}-outline")
            btn.pack(fill=X, pady=2)
            self._action_buttons.append(btn)

    def _build_mapping_card(self, parent):
        card = ttk.Labelframe(parent, text="Mapping Actions", padding=10)
        card.grid(row=2, column=0, sticky=NSEW)
        card.columnconfigure(0, weight=1)
        card.rowconfigure(0, weight=1)

        table_frame = ttk.Frame(card)
        table_frame.grid(row=0, column=0, sticky=NSEW)
        table_frame.columnconfigure(0, weight=1)
        table_frame.rowconfigure(0, weight=1)

        self._map_t = ttk.Treeview(table_frame, columns=("v", "f", "m"), show="headings", selectmode="browse")
        self._map_t.heading("v", text="值")
        self._map_t.heading("f", text="函数")
        self._map_t.heading("m", text="宏参数")
        self._map_t.column("v", width=70, anchor=CENTER, stretch=False)
        self._map_t.column("f", width=430)
        self._map_t.column("m", width=120)
        map_scroll = ttk.Scrollbar(table_frame, orient=VERTICAL, command=self._map_t.yview)
        self._map_t.configure(yscrollcommand=map_scroll.set)
        self._map_t.grid(row=0, column=0, sticky=NSEW)
        map_scroll.grid(row=0, column=1, sticky=NS)
        self._map_t.bind("<Double-Button-1>", lambda _: self._edit_mapping())

        ops = ttk.Frame(card)
        ops.grid(row=0, column=1, sticky=NS, padx=(8, 0))
        for text, command, style in [
            ("添加", self._add_mapping, SUCCESS),
            ("编辑", self._edit_mapping, PRIMARY),
            ("删除", self._del_mapping, DANGER),
        ]:
            btn = ttk.Button(ops, text=text, command=command, bootstyle=f"{style}-outline")
            btn.pack(fill=X, pady=2)
            self._mapping_buttons.append(btn)

    def _build_statusbar(self, parent):
        status = ttk.Label(parent, textvariable=self._status, bootstyle=SECONDARY, anchor=W, padding=(10, 4))
        status.grid(row=2, column=0, sticky=EW)

    def _bind_events(self):
        self.root.bind("<Control-s>", lambda _: self.save())
        self.root.protocol("WM_DELETE_WINDOW", self._on_close)

    # ------------------------------------------------------------------
    # Common dialogs
    # ------------------------------------------------------------------

    def _alert(self, title, message, kind="info"):
        dialog = ttk.Toplevel(self.root)
        dialog.title(title)
        dialog.transient(self.root)
        dialog.grab_set()
        dialog.resizable(False, False)

        frame = ttk.Frame(dialog, padding=16)
        frame.pack(fill=BOTH, expand=True)
        style = {"info": INFO, "warning": WARNING, "error": DANGER, "question": PRIMARY}.get(kind, INFO)
        ttk.Label(frame, text=title, bootstyle=style, font=("", 11, "bold")).pack(anchor=W)
        ttk.Label(frame, text=message, wraplength=520, justify=LEFT).pack(anchor=W, pady=(8, 12))
        ttk.Button(frame, text="确定", command=dialog.destroy, bootstyle=style).pack(anchor=E)
        self._center_window(dialog)
        dialog.wait_window()

    def _confirm(self, title, message) -> bool:
        dialog = ttk.Toplevel(self.root)
        dialog.title(title)
        dialog.transient(self.root)
        dialog.grab_set()
        dialog.resizable(False, False)
        result = {"ok": False}

        frame = ttk.Frame(dialog, padding=16)
        frame.pack(fill=BOTH, expand=True)
        ttk.Label(frame, text=title, bootstyle=WARNING, font=("", 11, "bold")).pack(anchor=W)
        ttk.Label(frame, text=message, wraplength=520, justify=LEFT).pack(anchor=W, pady=(8, 12))
        ops = ttk.Frame(frame)
        ops.pack(anchor=E)

        def ok():
            result["ok"] = True
            dialog.destroy()

        ttk.Button(ops, text="取消", command=dialog.destroy, bootstyle=SECONDARY).pack(side=LEFT, padx=(0, 6))
        ttk.Button(ops, text="确定", command=ok, bootstyle=DANGER).pack(side=LEFT)
        self._center_window(dialog)
        dialog.wait_window()
        return result["ok"]

    def _center_window(self, window):
        window.update_idletasks()
        root_x = self.root.winfo_rootx()
        root_y = self.root.winfo_rooty()
        root_w = self.root.winfo_width()
        root_h = self.root.winfo_height()
        w = window.winfo_width()
        h = window.winfo_height()
        x = root_x + max((root_w - w) // 2, 0)
        y = root_y + max((root_h - h) // 2, 0)
        window.geometry(f"+{x}+{y}")

    # ------------------------------------------------------------------
    # Data and form state
    # ------------------------------------------------------------------

    def _refresh_cache(self):
        self.all_funcs = get_all_functions()
        self.avail_dirs = get_module_dirs()
        self._status.set(f"已刷新: {len(self.all_funcs)} 个函数, {len(self.avail_dirs)} 个目录")

    def _save_current(self):
        if self._mod_idx is None or self._trg_idx is None:
            return
        self.modules[self._mod_idx]["triggers"][self._trg_idx] = self._collect()

    def _refresh_tree(self):
        self.tree.delete(*self.tree.get_children())
        for mi, module in enumerate(self.modules):
            node = self.tree.insert("", END, text=f"{module['dir']} ({len(module['triggers'])})", open=True, tags=(str(mi),))
            for ti, trigger in enumerate(module["triggers"]):
                self.tree.insert(node, END, text=trigger.get("name", "<unnamed>"), tags=(str(mi), str(ti)))

    def _on_select(self, _event):
        sel = self.tree.selection()
        if not sel:
            return
        item = sel[0]
        self._save_current()
        if not self.tree.parent(item):
            self._mod_idx = self._trg_idx = None
            self._clear_form()
            self._set_form_enabled(False)
            return
        mi, ti = map(int, self.tree.item(item, "tags"))
        self._mod_idx, self._trg_idx = mi, ti
        self._load_trigger(self.modules[mi]["triggers"][ti])

    def _clear_form(self):
        self._loading_form = True
        self._set_form_enabled(True)
        self._name_var.set("")
        self._name_cb["values"] = []
        self._disp_var.set("")
        self._init_e._var.set("")
        self._range_e._var.set(DEFAULT_RANGE)
        self._reset_e._var.set(str(DEFAULT_RESET))
        self._clear_actions()
        self._map_meta.clear()
        for item in self._map_t.get_children():
            self._map_t.delete(item)
        self._loading_form = False

    def _set_form_enabled(self, enabled: bool):
        state = "normal" if enabled else "disabled"
        for widget in self._form_inputs:
            widget.configure(state=state)
        self._act_t.configure(selectmode="browse" if enabled else "none")
        self._map_t.configure(selectmode="browse" if enabled else "none")
        for btn in self._action_buttons + self._mapping_buttons:
            btn.configure(state=state)

    def _mark(self):
        if self._loading_form:
            return
        self._dirty = True
        self._status.set("有未保存修改")

    def _update_name_suggestions(self, module_dir: str):
        prefix = get_name_prefix(module_dir)
        suggestions = [prefix]
        if self._mod_idx is not None:
            for trigger in self.modules[self._mod_idx]["triggers"]:
                name = trigger.get("name", "")
                if name and name not in suggestions:
                    suggestions.append(name)
        self._name_cb["values"] = suggestions

    def _load_trigger(self, trigger: dict):
        self._clear_form()
        module_dir = self.modules[self._mod_idx]["dir"]
        self._update_name_suggestions(module_dir)

        self._loading_form = True
        self._name_var.set(trigger.get("name", ""))
        self._disp_var.set(trigger.get("display", ""))
        self._range_e._var.set(trigger.get("range", DEFAULT_RANGE))
        self._reset_e._var.set(str(trigger.get("reset", DEFAULT_RESET)))
        if trigger.get("init") is not None:
            self._init_e._var.set(str(trigger["init"]))
        for action in trigger.get("actions", []):
            self._insert_action(normalize_action(action))
        for value in sorted(trigger.get("mapping_actions", {})):
            a = normalize_action(trigger["mapping_actions"][value])
            iid = self._map_t.insert("", END, values=(value, a["function"], render_macro(a["macro"])))
            self._map_meta[iid] = a
        self._loading_form = False
        self._set_form_enabled(True)

    def _collect(self) -> dict:
        trigger = {}
        if name := self._name_cb.get().strip():
            trigger["name"] = name
        if display := self._disp.get().strip():
            trigger["display"] = display
        try:
            trigger["init"] = int(self._init_e.get().strip())
        except (ValueError, TypeError):
            pass
        range_value = self._range_e.get().strip()
        if range_value and range_value != DEFAULT_RANGE:
            trigger["range"] = range_value
        try:
            reset = int(self._reset_e.get().strip())
            if reset != DEFAULT_RESET:
                trigger["reset"] = reset
        except (ValueError, TypeError):
            pass

        actions = self._get_actions()
        if actions:
            trigger["actions"] = actions

        mapping = {}
        for item in self._map_t.get_children():
            value = self._map_t.item(item, "values")[0]
            try:
                mapping[int(value)] = self._map_meta[item]
            except ValueError:
                pass
        if mapping:
            trigger["mapping_actions"] = mapping
        return trigger

    # ------------------------------------------------------------------
    # Modules and triggers
    # ------------------------------------------------------------------

    def _add_module(self):
        self._refresh_cache()
        name = self._ask_module_name()
        if not name:
            return
        if any(module["dir"] == name for module in self.modules):
            self._alert("重复", f"模块 {name} 已存在", "warning")
            return
        self.modules.append({"dir": name, "triggers": []})
        self._refresh_tree()
        self._mark()
        self._status.set(f"已添加模块 {name}")

    def _ask_module_name(self):
        dialog = ttk.Toplevel(self.root)
        dialog.title("新建模块")
        dialog.transient(self.root)
        dialog.grab_set()
        dialog.resizable(False, False)
        result = {"value": None}

        frame = ttk.Frame(dialog, padding=16)
        frame.pack(fill=BOTH, expand=True)
        ttk.Label(frame, text="模块目录名", font=("", 10, "bold")).pack(anchor=W)
        value = StringVar()
        combo = ttk.Combobox(frame, textvariable=value, values=self.avail_dirs, width=38)
        combo.pack(fill=X, pady=(8, 12))
        combo.focus_set()

        def ok():
            name = value.get().strip()
            if name:
                result["value"] = name
                dialog.destroy()

        ops = ttk.Frame(frame)
        ops.pack(anchor=E)
        ttk.Button(ops, text="取消", command=dialog.destroy, bootstyle=SECONDARY).pack(side=LEFT, padx=(0, 6))
        ttk.Button(ops, text="确定", command=ok, bootstyle=SUCCESS).pack(side=LEFT)
        dialog.bind("<Return>", lambda _: ok())
        dialog.bind("<Escape>", lambda _: dialog.destroy())
        self._center_window(dialog)
        dialog.wait_window()
        return result["value"]

    def _del_module(self):
        sel = self.tree.selection()
        if not sel:
            return
        item = sel[0]
        if self.tree.parent(item):
            return
        idx = self.tree.index(item)
        if self._confirm("确认删除", f"删除模块 {self.modules[idx]['dir']}?"):
            self.modules.pop(idx)
            self._mod_idx = self._trg_idx = None
            self._clear_form()
            self._set_form_enabled(False)
            self._refresh_tree()
            self._mark()

    def _add_trigger(self):
        sel = self.tree.selection()
        if not sel:
            self._alert("提示", "请先在左侧选择一个模块", "info")
            return
        item = sel[0]
        parent = self.tree.parent(item)
        mi = int(self.tree.item(item, "tags")[0]) if parent else self.tree.index(item)
        prefix = get_name_prefix(self.modules[mi]["dir"])
        self.modules[mi]["triggers"].append({
            "name": f"{prefix}new_trigger",
            "display": "新 Trigger",
            "init": -1,
            "range": "0..",
            "reset": -1,
        })
        self._refresh_tree()
        parent_node = self.tree.get_children()[mi]
        new_item = self.tree.get_children(parent_node)[-1]
        self.tree.selection_set(new_item)
        self.tree.focus(new_item)
        self._mark()

    def _del_trigger(self):
        if self._mod_idx is None:
            return
        if self._confirm("确认删除", "删除当前 trigger?"):
            self.modules[self._mod_idx]["triggers"].pop(self._trg_idx)
            self._mod_idx = self._trg_idx = None
            self._clear_form()
            self._set_form_enabled(False)
            self._refresh_tree()
            self._mark()

    def _move_module_up(self):
        self._move_module(-1)

    def _move_module_down(self):
        self._move_module(1)

    def _move_module(self, direction):
        sel = self.tree.selection()
        if not sel:
            return
        item = sel[0]
        if self.tree.parent(item):
            return
        idx = self.tree.index(item)
        new_idx = idx + direction
        if new_idx < 0 or new_idx >= len(self.modules):
            return
        self._save_current()
        self.modules.insert(new_idx, self.modules.pop(idx))
        self._mod_idx = self._trg_idx = None
        self._clear_form()
        self._set_form_enabled(False)
        self._refresh_tree()
        new_item = self.tree.get_children()[new_idx]
        self.tree.selection_set(new_item)
        self._mark()

    def _move_trigger_up(self):
        self._move_trigger(-1)

    def _move_trigger_down(self):
        self._move_trigger(1)

    def _move_trigger(self, direction):
        sel = self.tree.selection()
        if not sel:
            return
        item = sel[0]
        if not self.tree.parent(item):
            return
        mi, ti = map(int, self.tree.item(item, "tags"))
        new_ti = ti + direction
        if new_ti < 0 or new_ti >= len(self.modules[mi]["triggers"]):
            return
        self._save_current()
        triggers = self.modules[mi]["triggers"]
        triggers.insert(new_ti, triggers.pop(ti))
        self._mod_idx = self._trg_idx = None
        self._refresh_tree()
        parent_node = self.tree.get_children()[mi]
        new_item = self.tree.get_children(parent_node)[new_ti]
        self.tree.selection_set(new_item)
        self._mark()

    # ------------------------------------------------------------------
    # Actions
    # ------------------------------------------------------------------

    def _insert_action(self, action, index=END):
        action = normalize_action(action)
        if index == END:
            index = len(self._act_t.get_children())
        iid = self._act_t.insert("", index, values=(
            index + 1, action["function"], render_macro(action["macro"])))
        self._act_meta[iid] = action
        self._renumber_actions()
        return iid

    def _clear_actions(self):
        for item in self._act_t.get_children():
            self._act_t.delete(item)
        self._act_meta.clear()

    def _get_actions(self):
        return [self._act_meta[item] for item in self._act_t.get_children()]

    def _renumber_actions(self):
        for idx, item in enumerate(self._act_t.get_children(), start=1):
            a = self._act_meta[item]
            self._act_t.item(item, values=(idx, a["function"], render_macro(a["macro"])))

    def _add_action(self):
        result = self._ask_action("添加 Action")
        if result:
            self._insert_action(result)
            self._mark()

    def _edit_action(self):
        selection = self._act_t.selection()
        if not selection:
            return
        item = selection[0]
        result = self._ask_action("编辑 Action", self._act_meta[item])
        if result:
            self._act_meta[item] = result
            self._renumber_actions()
            self._mark()

    def _del_action(self):
        selection = self._act_t.selection()
        if not selection:
            return
        self._act_meta.pop(selection[0], None)
        self._act_t.delete(selection[0])
        self._renumber_actions()
        self._mark()

    def _move_action_up(self):
        self._move_action(-1)

    def _move_action_down(self):
        self._move_action(1)

    def _move_action(self, direction):
        selection = self._act_t.selection()
        if not selection:
            return
        item = selection[0]
        children = list(self._act_t.get_children())
        idx = children.index(item)
        new_idx = idx + direction
        if new_idx < 0 or new_idx >= len(children):
            return
        self._act_t.move(item, "", new_idx)
        self._act_t.selection_set(item)
        self._renumber_actions()
        self._mark()

    # ------------------------------------------------------------------
    # Mapping actions
    # ------------------------------------------------------------------

    def _add_mapping(self):
        result = self._ask_mapping("添加 Mapping")
        if result:
            value, action = result
            iid = self._map_t.insert("", END, values=(value, action["function"], render_macro(action["macro"])))
            self._map_meta[iid] = action
            self._mark()

    def _edit_mapping(self):
        selection = self._map_t.selection()
        if not selection:
            return
        item = selection[0]
        value = self._map_t.item(item, "values")[0]
        result = self._ask_mapping("编辑 Mapping", int(value), self._map_meta[item])
        if result:
            new_value, action = result
            self._map_meta[item] = action
            self._map_t.item(item, values=(new_value, action["function"], render_macro(action["macro"])))
            self._mark()

    def _del_mapping(self):
        selection = self._map_t.selection()
        if selection:
            self._map_meta.pop(selection[0], None)
            self._map_t.delete(selection[0])
            self._mark()

    def _ask_mapping(self, title, value=0, current_action=None):
        """返回 (整数, action dict) 或 None"""
        current_action = normalize_action(current_action) if current_action else {"function": "", "macro": {}}
        dialog = ttk.Toplevel(self.root)
        dialog.title(title)
        dialog.transient(self.root)
        dialog.grab_set()
        dialog.resizable(False, False)
        result = {"value": None}

        frame = ttk.Frame(dialog, padding=16)
        frame.pack(fill=BOTH, expand=True)
        frame.columnconfigure(1, weight=1)

        value_var = StringVar(value=str(value))

        ttk.Label(frame, text="值").grid(row=0, column=0, sticky=W, padx=(0, 8), pady=4)
        value_entry = ttk.Entry(frame, textvariable=value_var, width=12)
        value_entry.grid(row=0, column=1, sticky=EW, pady=4)

        ttk.Label(frame, text="Action").grid(row=1, column=0, sticky=W, padx=(0, 8), pady=4)
        action_label = ttk.Label(frame, text=format_action(current_action), anchor=W)
        action_label.grid(row=1, column=1, sticky=EW, pady=4)

        def edit_action():
            picked = self._ask_action(f"值 {value_var.get().strip() or 0} -> 函数", current_action)
            if picked:
                current_action.update(picked)
                action_label.configure(text=format_action(current_action))

        ttk.Button(frame, text="编辑函数与宏参数", command=edit_action, bootstyle=INFO).grid(
            row=1, column=2, sticky=EW, padx=(8, 0)
        )

        error_var = StringVar(value="")
        ttk.Label(frame, textvariable=error_var, bootstyle=DANGER).grid(row=2, column=0, columnspan=3, sticky=W, pady=(4, 0))

        def ok():
            try:
                number = int(value_var.get().strip())
            except ValueError:
                error_var.set("值必须是整数")
                return
            if number < 0:
                error_var.set("值不能小于 0")
                return
            if not current_action["function"]:
                error_var.set("请选择或输入函数")
                return
            result["value"] = (number, dict(current_action))
            dialog.destroy()

        ops = ttk.Frame(frame)
        ops.grid(row=3, column=0, columnspan=3, sticky=E, pady=(12, 0))
        ttk.Button(ops, text="取消", command=dialog.destroy, bootstyle=SECONDARY).pack(side=LEFT, padx=(0, 6))
        ttk.Button(ops, text="确定", command=ok, bootstyle=SUCCESS).pack(side=LEFT)
        value_entry.focus_set()
        dialog.bind("<Return>", lambda _: ok())
        dialog.bind("<Escape>", lambda _: dialog.destroy())
        self._center_window(dialog)
        dialog.wait_window()
        return result["value"]

    # ------------------------------------------------------------------
    # Function picker
    # ------------------------------------------------------------------

    def _ask_action(self, title="编辑 Action", current=None):
        """函数选择 + 宏参数编辑对话框，返回 {"function","macro"} 或 None"""
        current = normalize_action(current) if current else {"function": "", "macro": {}}
        self._macro_meta = {}
        self._macro_func_var = None

        dialog = ttk.Toplevel(self.root)
        dialog.title(title)
        dialog.geometry("780x600")
        dialog.transient(self.root)
        dialog.grab_set()
        result = {"value": None}

        frame = ttk.Frame(dialog, padding=12)
        frame.pack(fill=BOTH, expand=True)
        frame.columnconfigure(0, weight=1)
        frame.rowconfigure(3, weight=1)

        ttk.Label(frame, text="搜索或输入函数", font=("", 10, "bold")).grid(row=0, column=0, sticky=W)
        func_var = StringVar(value=current["function"])
        self._macro_func_var = func_var
        search = ttk.Entry(frame, textvariable=func_var)
        search.grid(row=1, column=0, sticky=EW, pady=(4, 6))

        func_table = ttk.Treeview(frame, columns=("func",), show="headings", selectmode="browse", height=9)
        func_table.heading("func", text="函数")
        func_table.column("func", width=720)
        fscroll = ttk.Scrollbar(frame, orient=VERTICAL, command=func_table.yview)
        func_table.configure(yscrollcommand=fscroll.set)
        func_table.grid(row=2, column=0, sticky=NSEW, pady=(0, 6))
        fscroll.grid(row=2, column=1, sticky=NS, pady=(0, 6))

        mframe = ttk.Labelframe(frame, text="宏参数", padding=8)
        mframe.grid(row=3, column=0, columnspan=2, sticky=NSEW)
        mframe.columnconfigure(0, weight=1)
        mframe.rowconfigure(1, weight=1)

        self._macro_label = ttk.Label(mframe, text="", foreground="#666")
        self._macro_label.grid(row=0, column=0, columnspan=3, sticky=W, pady=(0, 4))

        mtable = ttk.Treeview(mframe, columns=("k", "v"), show="headings", selectmode="browse", height=6)
        mtable.heading("k", text="参数名")
        mtable.heading("v", text="值")
        mtable.column("k", width=180)
        mtable.column("v", width=460)
        mscroll = ttk.Scrollbar(mframe, orient=VERTICAL, command=mtable.yview)
        mtable.configure(yscrollcommand=mscroll.set)
        mtable.grid(row=1, column=0, sticky=NSEW)
        mscroll.grid(row=1, column=1, sticky=NS)

        mops = ttk.Frame(mframe)
        mops.grid(row=1, column=2, sticky=NS, padx=(8, 0))
        for text, cmd, style in [
            ("添加", lambda: self._ask_macro_row(mtable), SUCCESS),
            ("编辑", lambda: self._edit_macro_row(mtable), PRIMARY),
            ("删除", lambda: self._del_macro_row(mtable), DANGER),
            ("预填缺失参数", lambda: self._prefill_macros(mtable), INFO),
        ]:
            ttk.Button(mops, text=text, command=cmd, bootstyle=f"{style}-outline").pack(fill=X, pady=2)

        ops = ttk.Frame(frame)
        ops.grid(row=4, column=0, columnspan=2, sticky=E, pady=(10, 0))
        ttk.Button(ops, text="取消", command=dialog.destroy, bootstyle=SECONDARY).pack(side=LEFT, padx=(0, 6))
        ttk.Button(ops, text="确定", command=lambda: self._ok_action(dialog, result, func_var, mtable), bootstyle=SUCCESS).pack(side=LEFT)

        func_var.trace_add("write", lambda *_: self._filter_funcs(func_table, func_var))
        func_table.bind("<<TreeviewSelect>>", lambda _: self._on_pick_func(func_table, func_var))
        func_table.bind("<Double-Button-1>", lambda _: self._on_pick_func(func_table, func_var))
        mtable.bind("<Double-Button-1>", lambda _: self._edit_macro_row(mtable))

        self._filter_funcs(func_table, func_var)
        if current["function"]:
            for iid in func_table.get_children():
                if func_table.item(iid, "values")[0] == current["function"]:
                    func_table.selection_set(iid)
                    func_table.focus(iid)
                    break
        self._update_macro_label(func_var)
        for k, v in sorted(current["macro"].items(), key=str):
            iid = mtable.insert("", END, values=(k, v))
            self._macro_meta[iid] = (k, v)

        search.focus_set()
        search.icursor(END)
        dialog.bind("<Return>", lambda _: self._ok_action(dialog, result, func_var, mtable))
        dialog.bind("<Escape>", lambda _: dialog.destroy())
        self._center_window(dialog)
        dialog.wait_window()
        return result["value"]

    def _filter_funcs(self, table, func_var):
        query = func_var.get().lower()
        table.delete(*table.get_children())
        for function in self.all_funcs:
            if query in function.lower():
                table.insert("", END, values=(function,))

    def _on_pick_func(self, func_table, func_var):
        sel = func_table.selection()
        if sel:
            func_var.set(func_table.item(sel[0], "values")[0])
        self._update_macro_label(func_var)

    def _current_macro_candidates(self):
        if self._macro_func_var is None:
            return []
        return get_macro_names(self._macro_func_var.get().strip())

    def _update_macro_label(self, func_var):
        names = get_macro_names(func_var.get().strip())
        if names:
            self._macro_label.configure(text=f"当前函数 $() 参数: {', '.join(names)}")
        else:
            self._macro_label.configure(text="当前函数未定义 $() 宏参数")

    def _ask_macro_row(self, table):
        result = self._macro_row_dialog("添加宏参数", "", "")
        if result:
            k, v = result
            iid = table.insert("", END, values=(k, v))
            self._macro_meta[iid] = (k, v)

    def _edit_macro_row(self, table):
        selection = table.selection()
        if not selection:
            return
        item = selection[0]
        k, v = self._macro_meta[item]
        result = self._macro_row_dialog("编辑宏参数", k, v)
        if result:
            nk, nv = result
            self._macro_meta[item] = (nk, nv)
            table.item(item, values=(nk, nv))

    def _del_macro_row(self, table):
        selection = table.selection()
        if selection:
            self._macro_meta.pop(selection[0], None)
            table.delete(selection[0])

    def _prefill_macros(self, table):
        names = self._current_macro_candidates()
        existing = {self._macro_meta[i][0] for i in table.get_children()}
        for n in names:
            if n not in existing:
                iid = table.insert("", END, values=(n, ""))
                self._macro_meta[iid] = (n, "")

    def _macro_row_dialog(self, title, k_initial="", v_initial=""):
        dialog = ttk.Toplevel(self.root)
        dialog.title(title)
        dialog.transient(self.root)
        dialog.grab_set()
        dialog.resizable(False, False)
        result = {"value": None}

        frame = ttk.Frame(dialog, padding=16)
        frame.pack(fill=BOTH, expand=True)
        frame.columnconfigure(1, weight=1)

        k_var = StringVar(value=k_initial)
        v_var = StringVar(value=v_initial)

        ttk.Label(frame, text="参数名").grid(row=0, column=0, sticky=W, padx=(0, 8), pady=4)
        k_combo = ttk.Combobox(frame, textvariable=k_var, values=self._current_macro_candidates(), width=24)
        k_combo.grid(row=0, column=1, sticky=EW, pady=4)

        ttk.Label(frame, text="值").grid(row=1, column=0, sticky=W, padx=(0, 8), pady=4)
        v_entry = ttk.Entry(frame, textvariable=v_var, width=40)
        v_entry.grid(row=1, column=1, sticky=EW, pady=4)

        ttk.Label(frame, text="提示: 值按类型自动推断（数字 / true / false / {..} / [..] / 以引号开头 原样输出，其余自动加引号）",
                  bootstyle=SECONDARY, wraplength=380).grid(row=2, column=0, columnspan=2, sticky=W, pady=(4, 0))

        error_var = StringVar(value="")
        ttk.Label(frame, textvariable=error_var, bootstyle=DANGER).grid(row=3, column=0, columnspan=2, sticky=W)

        def ok():
            k = k_var.get().strip()
            if not k:
                error_var.set("参数名不能为空")
                return
            result["value"] = (k, v_var.get())
            dialog.destroy()

        ops = ttk.Frame(frame)
        ops.grid(row=4, column=0, columnspan=2, sticky=E, pady=(12, 0))
        ttk.Button(ops, text="取消", command=dialog.destroy, bootstyle=SECONDARY).pack(side=LEFT, padx=(0, 6))
        ttk.Button(ops, text="确定", command=ok, bootstyle=SUCCESS).pack(side=LEFT)
        k_combo.focus_set()
        dialog.bind("<Return>", lambda _: ok())
        dialog.bind("<Escape>", lambda _: dialog.destroy())
        self._center_window(dialog)
        dialog.wait_window()
        return result["value"]

    def _ok_action(self, dialog, result, func_var, table):
        path = func_var.get().strip()
        if not path:
            dialog.destroy()
            return
        macro = {}
        for item in table.get_children():
            k, v = self._macro_meta[item]
            if k:
                macro[k] = v
        result["value"] = {"function": path, "macro": macro}
        dialog.destroy()

    # ------------------------------------------------------------------
    # Toolbar actions
    # ------------------------------------------------------------------

    def _show_config_errors(self, errors):
        message = "配置无效:\n\n" + "\n".join(
            f"[{where}] {field}: {detail}" for where, field, _value, detail in errors
        )
        self._alert("配置错误", message, "error")
        self._status.set(f"配置无效: {len(errors)} 个错误")

    def _validate_config_or_alert(self) -> bool:
        errors = validate_config(self.modules)
        if errors:
            self._show_config_errors(errors)
            return False
        return True

    def save(self):
        self._save_current()
        if not self._validate_config_or_alert():
            return
        save_yaml(self.modules)
        self._refresh_tree()
        self._dirty = False
        self._status.set("已保存")

    def generate(self):
        self._save_current()
        if not self._validate_config_or_alert():
            return
        try:
            changed = generate_module_files(self.modules)
        except ValueError as error:
            self._alert("生成失败", str(error), "error")
            self._status.set("生成失败")
            return
        if changed:
            self._status.set(f"已生成 {len(changed)} 个文件")
        else:
            self._status.set("已是最新")

    def validate(self):
        self._save_current()
        if not self._validate_config_or_alert():
            return
        errors = validate_paths(self.modules)
        if errors:
            message = f"发现 {len(errors)} 个错误:\n\n" + "\n".join(
                f"[{name}] {field}: {path}{hint}" for name, field, path, hint in errors
            )
            self._alert("校验结果", message, "error")
            self._status.set(f"校验失败: {len(errors)} 个错误")
            return
        hints = validate_macros(self.modules)
        if hints:
            message = f"发现 {len(hints)} 条宏参数提示（不会导致失败）:\n\n" + "\n".join(
                f"[{name}] {field}: {path}  {hint}" for name, field, path, hint in hints
            )
            self._alert("校验结果", message, "warning")
            self._status.set(f"宏参数提示: {len(hints)} 条")
        else:
            self._alert("校验结果", "全部函数路径有效，宏参数无多余项", "info")
            self._status.set("校验通过")

    def _on_close(self):
        if self._dirty and not self._confirm("有未保存修改", "有未保存修改，确定退出?"):
            return
        self.root.destroy()

    def run(self):
        self.root.mainloop()


if __name__ == "__main__":
    TriggerEditor().run()
