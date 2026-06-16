# MQP-WP 全局动态路径点 使用帮助文档

## 1. 功能概述

MQP-WP 是一个基于 Minecraft Java 版数据包的全局路径点系统。

路径点具有以下特性：

- 全服共享，不区分玩家
- 使用动态编号，不保存永久 ID
- 支持新建、传送、删除、上移、下移
- 普通玩家可通过 `/trigger` 使用基础功能
- 支持名称字段
- 支持手动修改维度、坐标、角度
- 支持主世界、下界、末地和自定义维度
- 坐标以整数保存
- 路径点数据保存在 `storage mqp_wp:data waypoints`

---

## 2. 路径点编号规则

路径点编号由列表顺序动态决定。

内部数据使用列表存储：

```mcfunction
storage mqp_wp:data waypoints
```

编号规则为：

```text
waypoints[0] -> 路径点 1
waypoints[1] -> 路径点 2
waypoints[2] -> 路径点 3
```

路径点本身不会保存永久 `id` 字段。

---

## 3. 普通玩家命令

以下命令无需 OP 权限。

---

### 3.1 新建路径点

```mcfunction
/trigger wp_new
```

或：

```mcfunction
/trigger wp_new set 1
```

效果：

- 在全局路径点列表末尾新增一个路径点
- 使用执行者当前所在维度
- 使用执行者当前坐标
- 使用执行者当前朝向
- 名称默认为空字符串 `""`
- 坐标保存为整数

---

### 3.2 传送到路径点

```mcfunction
/trigger wp_tp set <路径点编号>
```

例如：

```mcfunction
/trigger wp_tp set 1
```

效果：

- 将执行者传送到指定编号的路径点
- 支持跨维度传送

要求：

- 编号必须从 `1` 开始
- 目标路径点必须存在

---

### 3.3 删除路径点

```mcfunction
/trigger wp_del set <路径点编号>
```

例如：

```mcfunction
/trigger wp_del set 2
```

效果：

- 删除指定编号的路径点
- 后续路径点编号自动前移

示例变化：

```text
删除前：
1: A
2: B
3: C

删除 2 后：
1: A
2: C
```

---

### 3.4 上移路径点

```mcfunction
/trigger wp_up set <路径点编号>
```

例如：

```mcfunction
/trigger wp_up set 3
```

效果：

- 将指定路径点与它前一个路径点交换位置
- 路径点编号随列表顺序变化

示例变化：

```text
执行前：
1: A
2: B
3: C

执行 /trigger wp_up set 3 后：
1: A
2: C
3: B
```

限制：

- 编号 `1` 的路径点已经在最上方，不能上移
- 目标路径点必须存在

---

### 3.5 下移路径点

```mcfunction
/trigger wp_down set <路径点编号>
```

例如：

```mcfunction
/trigger wp_down set 2
```

效果：

- 将指定路径点与它后一个路径点交换位置
- 路径点编号随列表顺序变化

示例变化：

```text
执行前：
1: A
2: B
3: C

执行 /trigger wp_down set 2 后：
1: A
2: C
3: B
```

限制：

- 最后一个路径点已经在最下方，不能下移
- 目标路径点必须存在

---

## 4. OP 管理命令

以下命令需要 OP 或命令方块 / 函数等高权限环境执行。

OP 修改功能通过：

```mcfunction
storage mqp_wp:args
```

传入参数，然后调用对应函数。

---

## 5. 修改路径点名称

### 5.1 参数格式

```snbt
{id:<路径点编号>,name:"<名称>"}
```

### 5.2 执行命令

```mcfunction
data modify storage mqp_wp:args set value {id:1,name:"主基地"}
function mqp_wp:op/name
```

效果：

- 修改编号为 `1` 的路径点的 `name` 字段
- 名称只用于展示或外部解析
- 名称不参与传送、删除、上移、下移等定位逻辑

---

## 6. 修改路径点坐标

### 6.1 参数格式

```snbt
{id:<路径点编号>,x:<整数>,y:<整数>,z:<整数>}
```

### 6.2 执行命令

```mcfunction
data modify storage mqp_wp:args set value {id:1,x:100,y:64,z:-200}
function mqp_wp:op/pos
```

效果：

- 修改编号为 `1` 的路径点坐标
- 坐标会保存为整数

---

## 7. 修改路径点角度

### 7.1 参数格式

```snbt
{id:<路径点编号>,yaw:<水平角度>,pitch:<垂直角度>}
```

### 7.2 执行命令

```mcfunction
data modify storage mqp_wp:args set value {id:1,yaw:90.0f,pitch:0.0f}
function mqp_wp:op/rot
```

效果：

- 修改编号为 `1` 的路径点朝向
- `yaw` 为水平角度
- `pitch` 为垂直角度

---

## 8. 修改路径点维度

### 8.1 参数格式

```snbt
{id:<路径点编号>,dim:"<维度ID>"}
```

### 8.2 执行命令

```mcfunction
data modify storage mqp_wp:args set value {id:1,dim:"minecraft:overworld"}
function mqp_wp:op/dim
```

常见维度 ID：

```text
minecraft:overworld
minecraft:the_nether
minecraft:the_end
```

效果：

- 修改编号为 `1` 的路径点维度
- 支持自定义维度

---

## 9. 同时修改完整路径点信息

### 9.1 参数格式

```snbt
{
  id:<路径点编号>,
  name:"<名称>",
  dim:"<维度ID>",
  x:<整数>,
  y:<整数>,
  z:<整数>,
  yaw:<水平角度>,
  pitch:<垂直角度>
}
```

### 9.2 执行命令

```mcfunction
data modify storage mqp_wp:args set value {id:1,name:"主基地",dim:"minecraft:overworld",x:100,y:64,z:-200,yaw:90.0f,pitch:0.0f}
function mqp_wp:op/all
```

效果：

- 同时修改名称、维度、坐标、角度

---

## 10. 数据存储结构

路径点数据保存在：

```mcfunction
storage mqp_wp:data waypoints
```

示例结构：

```snbt
{
  waypoints: [
    {
      name: "主基地",
      dim: "minecraft:overworld",
      x: 100,
      y: 64,
      z: -200,
      yaw: 90.0f,
      pitch: 0.0f
    },
    {
      name: "下界门",
      dim: "minecraft:the_nether",
      x: 12,
      y: 70,
      z: -35,
      yaw: 180.0f,
      pitch: 10.0f
    }
  ]
}
```

---

## 11. 字段说明

单个路径点结构：

```snbt
{
  name: "名称",
  dim: "维度ID",
  x: 0,
  y: 64,
  z: 0,
  yaw: 0.0f,
  pitch: 0.0f
}
```

字段说明：

| 字段 | 类型 | 说明 |
|---|---|---|
| `name` | 字符串 | 路径点名称，仅用于展示或外部解析 |
| `dim` | 字符串 | 维度 ID |
| `x` | 整数 | X 坐标 |
| `y` | 整数 | Y 坐标 |
| `z` | 整数 | Z 坐标 |
| `yaw` | 浮点数 | 水平朝向 |
| `pitch` | 浮点数 | 垂直朝向 |

---

## 12. 编号与列表关系

路径点编号不是永久字段。

编号根据 `waypoints` 列表顺序实时决定：

```text
显示编号 = 列表下标 + 1
```

即：

```text
编号 1 = waypoints[0]
编号 2 = waypoints[1]
编号 3 = waypoints[2]
```

删除、上移、下移都会改变路径点编号。

---

## 13. 外部展示系统解析建议

如果需要在其他系统中展示路径点列表，应直接读取：

```mcfunction
storage mqp_wp:data waypoints
```

展示时动态生成编号。

例如：

```text
第 i 个元素的显示编号 = i + 1
```

不要依赖路径点内部的 `id` 字段，因为路径点内部没有永久 `id`。

---

## 14. 错误提示说明

可能出现的提示包括：

```text
路径点编号必须从 1 开始
```

表示传入编号小于 `1`。

```text
路径点 <id> 不存在
```

表示指定编号超出当前路径点列表范围。

```text
该路径点已经在最上方，无法上移
```

表示尝试上移编号 `1` 的路径点。

```text
该路径点不存在，或已经在最下方，无法下移
```

表示路径点不存在，或指定路径点已经是最后一个。

---

## 15. 权限说明

无需 OP 的命令：

```mcfunction
/trigger wp_new
/trigger wp_tp set <id>
/trigger wp_del set <id>
/trigger wp_up set <id>
/trigger wp_down set <id>
```

需要 OP 的功能：

```mcfunction
function mqp_wp:op/name
function mqp_wp:op/pos
function mqp_wp:op/rot
function mqp_wp:op/dim
function mqp_wp:op/all
```

以及对应的：

```mcfunction
data modify storage mqp_wp:args ...
```

---

## 16. 注意事项

1. 路径点是全服共享的，不区分玩家。
2. 删除、上移、下移会改变路径点编号。
3. 名称字段仅用于展示或外部解析，不参与功能逻辑。
4. 坐标保存为整数。
5. 传送支持跨维度。
6. 若维度 ID 不存在，传送会失败。
7. 路径点位置所在区块不需要提前加载。
8. 本系统默认编号从 `1` 开始。