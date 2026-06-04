#!/usr/bin/env python3
"""
mica_quick_panel Trigger 配置 GUI

用法: python triggers_gui.py
"""

import io, sys
from tkinter import *
from tkinter import ttk, messagebox

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

from trigger_core import (
    get_all_functions, get_module_dirs, get_name_prefix,
    load_yaml, save_yaml, validate_paths, generate_module_files,
    DEFAULT_RANGE, DEFAULT_RESET, FUNCTION_DIR, NAMESPACE_DIR,
)


class TriggerEditor:

    def __init__(self):
        self.modules = load_yaml()
        self.all_funcs = get_all_functions()
        self.avail_dirs = get_module_dirs()
        self._mod_idx = None
        self._trg_idx = None

        self.root = Tk()
        self.root.title("Mica Quick Panel - Trigger 编辑器")
        self.root.geometry("960x600")
        self.root.minsize(800, 480)

        bar = ttk.Frame(self.root)
        bar.pack(fill=X, padx=5, pady=3)
        for txt, cmd in [("保存 (Ctrl+S)", self.save),
                         ("生成 .mcfunction", self.generate),
                         ("校验路径", self.validate)]:
            ttk.Button(bar, text=txt, command=cmd).pack(side=LEFT, padx=1)
        ttk.Label(bar, text="  ").pack(side=LEFT)
        ttk.Button(bar, text="🔄 刷新", command=self._refresh_cache).pack(side=LEFT, padx=1)

        paned = ttk.PanedWindow(self.root, orient=HORIZONTAL)
        paned.pack(fill=BOTH, expand=True, padx=5, pady=5)

        # ── 左：树 ──
        left = ttk.Frame(paned)
        paned.add(left, weight=1)
        ttk.Label(left, text="模块 / Trigger", font=("", 10, "bold")).pack(anchor=W)
        self.tree = ttk.Treeview(left, show="tree", selectmode="browse")
        self.tree.pack(fill=BOTH, expand=True)
        self.tree.bind("<<TreeviewSelect>>", self._on_select)

        bf = ttk.Frame(left)
        bf.pack(fill=X)
        for txt, cmd in [("+ 模块", self._add_module), ("- 模块", self._del_module),
                         ("+ Trigger", self._add_trigger), ("- Trigger", self._del_trigger)]:
            ttk.Button(bf, text=txt, command=cmd).pack(side=LEFT, padx=1)

        # ── 右：表单 ──
        right = ttk.Frame(paned)
        paned.add(right, weight=2)
        self._build_form(right)

        self._status = StringVar(value="就绪")
        ttk.Label(self.root, textvariable=self._status, relief=SUNKEN, anchor=W).pack(fill=X, side=BOTTOM)

        self.root.bind("<Control-s>", lambda e: self.save())
        self._refresh_tree()
        self._clear_form()

    def _refresh_cache(self):
        """重新扫描文件系统，刷新函数列表和模块目录缓存"""
        self.all_funcs = get_all_functions()
        self.avail_dirs = get_module_dirs()
        self._status.set(f"已刷新: {len(self.all_funcs)} 个函数, {len(self.avail_dirs)} 个目录")

    # ══════════════════════════════════════════════════════════
    #  表单构建
    # ══════════════════════════════════════════════════════════

    def _build_form(self, parent):
        f = ttk.Frame(parent)
        f.pack(fill=BOTH, expand=True, padx=8, pady=5)

        r = 0
        ttk.Label(f, text="基本设置", font=("", 10, "bold")).grid(row=r, column=0, columnspan=3, sticky=W, pady=(0, 5))
        r += 1

        ttk.Label(f, text="Name:").grid(row=r, column=0, sticky=W, pady=2)
        self._name_cb = ttk.Combobox(f, width=35, values=[])
        self._name_cb.grid(row=r, column=1, columnspan=2, sticky=EW, pady=2)
        self._name_cb.bind("<<Modified>>", lambda _: self._mark())
        self._name_cb.bind("<<ComboboxSelected>>", lambda _: self._mark())
        r += 1

        ttk.Label(f, text="Display:").grid(row=r, column=0, sticky=W, pady=2)
        self._disp = ttk.Entry(f, width=35)
        self._disp.grid(row=r, column=1, columnspan=2, sticky=EW, pady=2)
        self._disp.bind("<<Modified>>", lambda _: self._mark())
        r += 1

        of = ttk.Frame(f)
        of.grid(row=r, column=0, columnspan=3, sticky=W, pady=2)
        self._init_e = self._mk_inline(of, "Init:", 6)
        self._range_e = self._mk_inline(of, "Range:", 6, DEFAULT_RANGE)
        self._reset_e = self._mk_inline(of, "Reset:", 6, str(DEFAULT_RESET))
        r += 1

        ttk.Separator(f, orient=HORIZONTAL).grid(row=r, column=0, columnspan=3, sticky=EW, pady=5)
        r += 1
        ttk.Label(f, text="Actions", font=("", 9, "bold")).grid(row=r, column=0, columnspan=3, sticky=W)
        r += 1
        af = ttk.Frame(f)
        af.grid(row=r, column=0, columnspan=3, sticky=EW, pady=2)
        self._act_lb = Listbox(af, height=4)
        self._act_lb.pack(side=LEFT, fill=BOTH, expand=True)
        self._act_lb.bind("<Double-Button-1>", lambda e: self._edit_action())
        for txt, cmd in [("添加...", self._add_action), ("编辑", self._edit_action), ("删除", self._del_action)]:
            ttk.Button(af, text=txt, command=cmd).pack(side=LEFT, padx=1)
        r += 1

        ttk.Separator(f, orient=HORIZONTAL).grid(row=r, column=0, columnspan=3, sticky=EW, pady=5)
        r += 1
        ttk.Label(f, text="Mapping Actions", font=("", 9, "bold")).grid(row=r, column=0, columnspan=3, sticky=W)
        r += 1
        mf = ttk.Frame(f)
        mf.grid(row=r, column=0, columnspan=3, sticky=EW, pady=2)
        self._map_t = ttk.Treeview(mf, columns=("v", "f"), show="headings", height=4)
        self._map_t.heading("v", text="值"); self._map_t.heading("f", text="函数")
        self._map_t.column("v", width=40); self._map_t.column("f", width=360)
        self._map_t.pack(side=LEFT, fill=BOTH, expand=True)
        self._map_t.bind("<Double-Button-1>", lambda e: self._edit_mapping())
        for txt, cmd in [("添加", self._add_mapping), ("编辑", self._edit_mapping), ("删除", self._del_mapping)]:
            ttk.Button(mf, text=txt, command=cmd).pack(side=LEFT, padx=1)
        r += 1

        f.columnconfigure(1, weight=1)

    def _mk_inline(self, parent, label, width, default=""):
        ttk.Label(parent, text=label).pack(side=LEFT)
        e = ttk.Entry(parent, width=width)
        e.insert(0, default)
        e.pack(side=LEFT, padx=2)
        e.bind("<<Modified>>", lambda _: self._mark())
        return e

    # ══════════════════════════════════════════════════════════
    #  内存保存 / 表单操作
    # ══════════════════════════════════════════════════════════

    def _save_current(self):
        """将当前表单内容写入 self.modules（仅内存，不写 YAML）"""
        if self._mod_idx is None:
            return
        self.modules[self._mod_idx]["triggers"][self._trg_idx] = self._collect()

    def _refresh_tree(self):
        self.tree.delete(*self.tree.get_children())
        for mi, m in enumerate(self.modules):
            node = self.tree.insert("", END, text=f"{m['dir']} ({len(m['triggers'])})", open=True)
            for ti, t in enumerate(m["triggers"]):
                self.tree.insert(node, END, text=t["name"], tags=(str(mi), str(ti)))

    def _on_select(self, _ev):
        sel = self.tree.selection()
        if not sel:
            return
        item = sel[0]
        if not self.tree.parent(item):
            return
        # 1) 保存现有编辑到内存
        self._save_current()

        # 2) 切换到新的
        mi, ti = int(self.tree.item(item, "tags")[0]), int(self.tree.item(item, "tags")[1])
        self._mod_idx, self._trg_idx = mi, ti
        self._load_trigger(self.modules[mi]["triggers"][ti])

    def _clear_form(self):
        self._name_cb.set("")
        self._name_cb["values"] = []
        self._disp.delete(0, END)
        for w in (self._init_e, self._range_e, self._reset_e):
            w.delete(0, END)
        self._range_e.insert(0, DEFAULT_RANGE)
        self._reset_e.insert(0, str(DEFAULT_RESET))
        self._act_lb.delete(0, END)
        for i in self._map_t.get_children():
            self._map_t.delete(i)

    def _mark(self):
        pass  # 预留，不需要实际标记了

    def _update_name_suggestions(self, module_dir: str):
        """更新 Name 下拉的建议值"""
        prefix = get_name_prefix(module_dir)
        suggestions = [f"{prefix}"]
        # 加上同一模块下已有 trigger 的名称
        if self._mod_idx is not None:
            for t in self.modules[self._mod_idx]["triggers"]:
                n = t.get("name", "")
                if n and n not in suggestions:
                    suggestions.append(n)
        self._name_cb["values"] = suggestions

    def _load_trigger(self, t: dict):
        self._clear_form()
        module_dir = self.modules[self._mod_idx]["dir"]
        self._update_name_suggestions(module_dir)

        self._name_cb.set(t.get("name", ""))
        self._disp.insert(0, t.get("display", ""))
        r = t.get("range", DEFAULT_RANGE)
        self._range_e.delete(0, END); self._range_e.insert(0, r)
        rs = t.get("reset", DEFAULT_RESET)
        self._reset_e.delete(0, END); self._reset_e.insert(0, str(rs))
        if t.get("init") is not None:
            self._init_e.insert(0, str(t["init"]))
        for a in t.get("actions", []):
            self._act_lb.insert(END, a)
        for v in sorted(t.get("mapping_actions", {})):
            self._map_t.insert("", END, values=(v, t["mapping_actions"][v]))

    def _collect(self) -> dict:
        t = {}
        if n := self._name_cb.get().strip():
            t["name"] = n
        if d := self._disp.get().strip():
            t["display"] = d
        try:
            v = int(self._init_e.get().strip())
            t["init"] = v
        except (ValueError, TypeError):
            pass
        r = self._range_e.get().strip()
        if r and r != DEFAULT_RANGE:
            t["range"] = r
        try:
            v = int(self._reset_e.get().strip())
            if v != DEFAULT_RESET:
                t["reset"] = v
        except (ValueError, TypeError):
            pass
        acts = list(self._act_lb.get(0, END))
        if acts:
            t["actions"] = acts
        mapping = {}
        for item in self._map_t.get_children():
            v, f = self._map_t.item(item, "values")
            try:
                mapping[int(v)] = f
            except ValueError:
                pass
        if mapping:
            t["mapping_actions"] = mapping
        return t

    # ══════════════════════════════════════════════════════════
    #  模块 / Trigger 增删
    # ══════════════════════════════════════════════════════════

    def _add_module(self):
        """弹出下拉选择对话框，可选已有函数目录或手动输入"""
        self._refresh_cache()  # 先刷新目录列表
        d = Toplevel(self.root)
        d.title("新建模块")
        d.transient(self.root)
        d.grab_set()
        d.geometry("360x160")
        ttk.Label(d, text="模块目录名（可选已有函数目录或手动输入）:").pack(anchor=W, padx=10, pady=(10, 0))

        names = self.avail_dirs + ["(自定义)"]
        cb = ttk.Combobox(d, values=names, width=30)
        cb.set(self.avail_dirs[0] if self.avail_dirs else "(自定义)")
        cb.pack(padx=10, pady=5, fill=X)

        manual_frame = ttk.Frame(d)
        manual_frame.pack(padx=10, pady=2, fill=X)
        ttk.Label(manual_frame, text="或手动输入:").pack(side=LEFT)
        manual_e = ttk.Entry(manual_frame, width=20)
        manual_e.pack(side=LEFT, padx=5)

        def on_ok():
            name = manual_e.get().strip() or cb.get().strip()
            if not name:
                return
            if any(m["dir"] == name for m in self.modules):
                messagebox.showwarning("重复", f"模块 {name} 已存在")
                return
            self.modules.append({"dir": name, "triggers": []})
            self._refresh_tree()
            self._status.set(f"已添加模块 {name}")
            d.destroy()

        def on_cb_select(ev):
            if cb.get() in self.avail_dirs:
                manual_e.delete(0, END)

        cb.bind("<<ComboboxSelected>>", on_cb_select)
        bf = ttk.Frame(d)
        bf.pack(pady=10)
        ttk.Button(bf, text="确定", command=on_ok).pack(side=LEFT, padx=5)
        ttk.Button(bf, text="取消", command=d.destroy).pack(side=LEFT, padx=5)
        d.wait_window()

    def _del_module(self):
        sel = self.tree.selection()
        if not sel:
            return
        item = sel[0]
        if self.tree.parent(item):
            return
        idx = self.tree.index(item)
        if messagebox.askyesno("确认", f"删除模块 {self.modules[idx]['dir']}?"):
            self.modules.pop(idx)
            self._mod_idx = self._trg_idx = None
            self._clear_form()
            self._refresh_tree()

    def _add_trigger(self):
        sel = self.tree.selection()
        if not sel:
            messagebox.showinfo("提示", "请先在左侧选择一个模块")
            return
        item = sel[0]
        p = self.tree.parent(item)
        mi = int(self.tree.item(item, "tags")[0]) if p else self.tree.index(item)
        prefix = get_name_prefix(self.modules[mi]["dir"])
        self.modules[mi]["triggers"].append({
            "name": f"{prefix}new_trigger",
            "display": "新 Trigger",
            "range": DEFAULT_RANGE,
            "reset": DEFAULT_RESET,
        })
        self._refresh_tree()

    def _del_trigger(self):
        if self._mod_idx is None:
            return
        if messagebox.askyesno("确认", "删除当前 trigger?"):
            self.modules[self._mod_idx]["triggers"].pop(self._trg_idx)
            self._mod_idx = self._trg_idx = None
            self._clear_form()
            self._refresh_tree()

    # ══════════════════════════════════════════════════════════
    #  函数选择对话框
    # ══════════════════════════════════════════════════════════

    def _pick_func(self, title="选择函数") -> str:
        d = Toplevel(self.root)
        d.title(title)
        d.geometry("500x400")
        d.transient(self.root)
        d.grab_set()
        result = [None]

        f = ttk.Frame(d)
        f.pack(fill=BOTH, expand=True, padx=5, pady=5)
        ttk.Label(f, text="搜索或选择:").pack(anchor=W)
        sv = StringVar()
        ttk.Entry(f, textvariable=sv).pack(fill=X, pady=2)
        lb = Listbox(f, font=("Consolas", 9))
        lb.pack(fill=BOTH, expand=True, pady=2)

        def update(*_):
            q = sv.get().lower()
            lb.delete(0, END)
            for fn in self.all_funcs:
                if q in fn.lower():
                    lb.insert(END, fn)
        sv.trace_add("write", update)
        update()

        def ok():
            s = lb.curselection()
            if s:
                result[0] = lb.get(s[0])
            d.destroy()

        lb.bind("<Double-Button-1>", lambda _: ok())
        bf = ttk.Frame(f)
        bf.pack(fill=X)
        ttk.Button(bf, text="确定", command=ok).pack(side=RIGHT, padx=2)
        ttk.Button(bf, text="取消", command=d.destroy).pack(side=RIGHT, padx=2)
        d.wait_window()
        return result[0]

    def _add_action(self):
        if f := self._pick_func("选择 Action 函数"):
            self._act_lb.insert(END, f)
            self._mark()

    def _edit_action(self):
        s = self._act_lb.curselection()
        if not s:
            return
        if f := self._pick_func("编辑 Action 函数"):
            self._act_lb.delete(s[0])
            self._act_lb.insert(s[0], f)
            self._mark()

    def _del_action(self):
        s = self._act_lb.curselection()
        if s:
            self._act_lb.delete(s[0])
            self._mark()

    def _add_mapping(self):
        v = simpledialog.askinteger("添加 Mapping", "值:", parent=self.root, minvalue=0)
        if v is None:
            return
        if f := self._pick_func(f"值 {v} → 函数"):
            self._map_t.insert("", END, values=(v, f))
            self._mark()

    def _edit_mapping(self):
        s = self._map_t.selection()
        if not s:
            return
        v, f = self._map_t.item(s[0], "values")
        nv = simpledialog.askinteger("编辑 Mapping", "值:", parent=self.root, initialvalue=int(v), minvalue=0)
        if nv is None:
            return
        if nf := self._pick_func(f"值 {nv} → 函数"):
            self._map_t.item(s[0], values=(nv, nf))
            self._mark()

    def _del_mapping(self):
        s = self._map_t.selection()
        if s:
            self._map_t.delete(s[0])
            self._mark()

    # ══════════════════════════════════════════════════════════
    #  工具栏
    # ══════════════════════════════════════════════════════════

    def save(self):
        self._save_current()
        save_yaml(self.modules)
        self._refresh_tree()
        self._status.set("已保存")

    def generate(self):
        self._save_current()
        changed = generate_module_files(self.modules)
        if changed:
            self._status.set(f"已生成 {len(changed)} 个文件")
        else:
            self._status.set("已是最新")

    def validate(self):
        self._save_current()
        errs = validate_paths(self.modules)
        if errs:
            msg = f"发现 {len(errs)} 个错误:\n\n" + "\n".join(
                f"[{n}] {f}: {p}{h}" for n, f, p, h in errs)
            messagebox.showerror("校验结果", msg)
            self._status.set(f"校验失败: {len(errs)} 个错误")
        else:
            messagebox.showinfo("校验结果", "全部函数路径有效")
            self._status.set("校验通过")

    def run(self):
        self.root.mainloop()


if __name__ == "__main__":
    TriggerEditor().run()
