# `mqp_actionbar` 使用帮助文档

`mqp_actionbar` 是一个 Minecraft Java 数据包 actionbar 管理器，用于统一管理玩家的动作栏显示。

它解决的问题是：

> Minecraft 的 actionbar 同一时间只能显示一条内容。
> 如果多个系统都直接执行 `title @s actionbar ...`，后执行的内容会覆盖先执行的内容。

使用 `mqp_actionbar` 后，不同系统可以把消息提交给管理器，由管理器统一合并显示。

例如多个系统同时提交：

```text
金币: 188
低血量!
购买完成
```

最终玩家看到：

```text
金币: 188 | 低血量! | 购买完成
```

---

# 1. 核心概念

`mqp_actionbar` 支持两类消息：

| 类型 | 接口 | 适合场景 |
|---|---|---|
| 当前 tick 消息 | `mqp_actionbar:add` | 状态型、持续刷新的内容 |
| 定时消息 | `mqp_actionbar:timed/add_timed` | 事件型、一次性提示 |

---

# 2. 当前 tick 消息

## 2.1 作用

当前 tick 消息只在当前 tick 参与 actionbar 合并。

下一 tick 会被自动清空。

如果你希望它持续显示，就需要每 tick 提交一次。

---

## 2.2 适合显示什么？

适合状态型内容，例如：

```text
金币: 188
等级: 10
低血量!
所在区域: 主城
技能冷却中
战斗状态
```

这些内容通常和玩家当前状态有关，本来就应该每 tick 检查或刷新。

---

## 2.3 基本用法

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"金币: 188",color:"gold"}
function mqp_actionbar:add
```

显示效果：

```text
金币: 188
```

---

## 2.4 带计分板的文本

例如显示玩家的 `coin` 分数：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"金币: ",color:"gold",extra:[{score:{name:"@s",objective:"coin"}}]}
function mqp_actionbar:add
```

如果玩家 `coin = 188`，则显示：

```text
金币: 188
```

---

# 3. 定时消息

## 3.1 作用

定时消息只需要在事件发生时提交一次。

管理器会在指定时间内自动持续显示它。

---

## 3.2 适合显示什么？

适合事件型提示，例如：

```text
购买完成
金币不足
任务完成
获得奖励
传送成功
技能释放成功
魔力不足
背包已满
```

这些消息通常不需要每 tick 判断，只在某个逻辑发生时提示玩家。

---

## 3.3 基本用法

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"购买完成",color:"green"}
data modify storage mqp_actionbar:api duration set value 40
function mqp_actionbar:timed/add_timed
```

含义：

```text
显示“购买完成”40 tick，约 2 秒。
```

---

## 3.4 `duration`

`duration` 表示持续时间，单位是 tick。

常见值：

| tick | 大约时间 |
|---:|---:|
| 20 | 1 秒 |
| 40 | 2 秒 |
| 60 | 3 秒 |
| 100 | 5 秒 |

例如显示 3 秒：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"任务完成!",color:"green",bold:true}
data modify storage mqp_actionbar:api duration set value 60
function mqp_actionbar:timed/add_timed
```

如果不设置 `duration`，默认显示 40 tick。

---

# 4. `source` 来源覆盖

## 4.1 为什么需要 source？

如果一次性消息短时间内连续触发，而不做处理，就可能重复显示：

```text
购买完成 | 购买完成 | 购买完成
```

通常这不是想要的效果。

所以定时消息支持 `source`。

---

## 4.2 source 的作用

`source` 表示这条消息的来源或频道。

同一玩家、同一 `source` 的定时消息同时最多存在一条。

如果新的同源消息被提交，旧消息会被覆盖。

---

## 4.3 使用示例

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"购买完成",color:"green"}
data modify storage mqp_actionbar:api duration set value 40
data modify storage mqp_actionbar:api source set value "shop.purchase"
function mqp_actionbar:timed/add_timed
```

如果玩家快速购买多次，最终不会显示成：

```text
购买完成 | 购买完成 | 购买完成
```

而是始终只保留一条：

```text
购买完成
```

并且每次触发都会刷新持续时间。

---

## 4.4 source 命名建议

建议使用清晰、稳定的字符串：

```text
shop.purchase
shop.error
skill.mana
skill.cooldown
quest.complete
item.pickup
teleport.notice
```

如果你有多个系统，建议加上系统名前缀：

```text
my_shop.purchase
my_shop.error
my_skill.mana
```

---

# 5. `msg` 格式要求

这是最重要的注意事项。

`msg` 必须是 **文本组件 NBT compound**，不是 JSON 字符串。

---

## 5.1 正确写法

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"购买完成",color:"green"}
```

这是 NBT compound。

---

## 5.2 错误写法

```mcfunction
data modify storage mqp_actionbar:api msg set value '{"text":"购买完成","color":"green"}'
```

这是字符串。

这种写法会导致 actionbar 显示出原始 JSON 内容，而不是渲染后的文本。

例如可能显示成：

```text
{"text":"购买完成","color":"green"}
```

---

## 5.3 更多正确示例

普通文本：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"传送成功",color:"aqua"}
```

粗体文本：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"低血量!",color:"red",bold:true}
```

带计分板：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"金币: ",color:"gold",extra:[{score:{name:"@s",objective:"coin"}}]}
```

多段文本：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"获得 ",color:"white",extra:[{text:"钻石",color:"aqua"},{text:" x1",color:"white"}]}
```

---

# 6. 什么时候用 provider？

## 6.1 provider 是什么？

provider 是每 tick 由 `mqp_actionbar` 自动调用的函数。

它用于提交“当前 tick 消息”。

所有 provider 注册在：

```text
data/mqp_actionbar/tags/functions/actionbar_providers.json
```

---

## 6.2 provider 适合什么？

provider 适合持续状态。

例如：

```text
金币余额
血量警告
当前区域
技能冷却
战斗状态
```

---

## 6.3 provider 示例：金币显示

`data/demo/functions/provider_coin.mcfunction`

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"金币: ",color:"gold",extra:[{score:{name:"@s",objective:"coin"}}]}
function mqp_actionbar:add
```

然后注册到：

`data/mqp_actionbar/tags/functions/actionbar_providers.json`

```json
{
  "values": [
    "demo:provider_coin"
  ]
}
```

这样每个玩家每 tick 都会显示自己的金币。

---

## 6.4 provider 示例：低血量提示

```mcfunction
execute if score @s hp matches ..6 run data modify storage mqp_actionbar:api msg set value {text:"低血量!",color:"red",bold:true}
execute if score @s hp matches ..6 run function mqp_actionbar:add
```

低血量是状态型条件，所以适合 provider。

---

# 7. 什么时候直接调用定时 API？

事件型消息应该在事件发生的地方直接调用：

```mcfunction
function mqp_actionbar:timed/add_timed
```

不需要注册 provider。

---

## 7.1 示例：购买完成

原来可能写：

```mcfunction
title @s actionbar {"text":"购买完成","color":"green"}
```

现在改成：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"购买完成",color:"green"}
data modify storage mqp_actionbar:api duration set value 40
data modify storage mqp_actionbar:api source set value "shop.purchase"
function mqp_actionbar:timed/add_timed
```

---

## 7.2 示例：金币不足

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"金币不足",color:"red"}
data modify storage mqp_actionbar:api duration set value 40
data modify storage mqp_actionbar:api source set value "shop.error"
function mqp_actionbar:timed/add_timed
```

---

## 7.3 示例：任务完成

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"任务完成!",color:"green",bold:true}
data modify storage mqp_actionbar:api duration set value 60
data modify storage mqp_actionbar:api source set value "quest.complete"
function mqp_actionbar:timed/add_timed
```

---

## 7.4 示例：魔力不足

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"魔力不足",color:"red"}
data modify storage mqp_actionbar:api duration set value 30
data modify storage mqp_actionbar:api source set value "skill.mana"
function mqp_actionbar:timed/add_timed
```

---

# 8. 接口总结

## 8.1 当前 tick 消息接口

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"内容",color:"颜色"}
function mqp_actionbar:add
```

特点：

```text
只在当前 tick 生效。
需要每 tick 调用才会持续显示。
适合 provider。
```

---

## 8.2 定时消息接口

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"内容",color:"颜色"}
data modify storage mqp_actionbar:api duration set value 40
function mqp_actionbar:timed/add_timed
```

特点：

```text
调用一次，持续显示指定 tick。
适合事件提示。
```

---

## 8.3 带 source 的定时消息接口

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"内容",color:"颜色"}
data modify storage mqp_actionbar:api duration set value 40
data modify storage mqp_actionbar:api source set value "your.source"
function mqp_actionbar:timed/add_timed
```

特点：

```text
同一玩家同一 source 只保留一条。
新消息会覆盖旧消息。
适合高频事件。
```

---

# 9. 推荐使用规则

| 场景 | 推荐方式 |
|---|---|
| 金币余额 | provider + `mqp_actionbar:add` |
| 低血量提示 | provider + `mqp_actionbar:add` |
| 当前区域 | provider + `mqp_actionbar:add` |
| 购买完成 | 事件处直接调用 `mqp_actionbar:timed/add_timed` |
| 金币不足 | 事件处直接调用 `mqp_actionbar:timed/add_timed` |
| 任务完成 | 事件处直接调用 `mqp_actionbar:timed/add_timed` |
| 魔力不足 | 事件处直接调用 `mqp_actionbar:timed/add_timed` |
| 高频重复提示 | 定时消息 + `source` |

一句话：

> 持续状态用 provider，事件提示直接调用 timed API。

---

# 10. 注意事项

## 10.1 不要直接写 actionbar

不推荐：

```mcfunction
title @s actionbar {"text":"提示"}
```

推荐：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"提示"}
function mqp_actionbar:add
```

或：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"提示"}
data modify storage mqp_actionbar:api duration set value 40
function mqp_actionbar:timed/add_timed
```

---

## 10.2 `msg` 不要写成字符串

错误：

```mcfunction
data modify storage mqp_actionbar:api msg set value '{"text":"提示"}'
```

正确：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"提示"}
```

---

## 10.3 持续状态不要每 tick 调用定时消息

例如低血量不要这样：

```mcfunction
execute if score @s hp matches ..6 run data modify storage mqp_actionbar:api msg set value {text:"低血量!",color:"red"}
execute if score @s hp matches ..6 run data modify storage mqp_actionbar:api duration set value 40
execute if score @s hp matches ..6 run function mqp_actionbar:timed/add_timed
```

这会不断刷新定时消息，不符合状态型信息的语义。

应该用：

```mcfunction
execute if score @s hp matches ..6 run data modify storage mqp_actionbar:api msg set value {text:"低血量!",color:"red"}
execute if score @s hp matches ..6 run function mqp_actionbar:add
```

---

## 10.4 高频事件建议设置 source

例如：

```mcfunction
data modify storage mqp_actionbar:api source set value "shop.purchase"
```

这样可以避免重复堆叠。

---

# 11. 常见问题

## Q1：为什么我的 actionbar 显示了 `{text:"xxx"}`？

因为你可能把 `msg` 写成了字符串。

错误：

```mcfunction
data modify storage mqp_actionbar:api msg set value '{"text":"xxx"}'
```

正确：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"xxx"}
```

---

## Q2：购买完成这种提示要注册 provider 吗？

不需要。

购买完成是事件型提示，直接在购买逻辑中调用：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"购买完成",color:"green"}
data modify storage mqp_actionbar:api duration set value 40
data modify storage mqp_actionbar:api source set value "shop.purchase"
function mqp_actionbar:timed/add_timed
```

---

## Q3：金币、血量这种信息怎么写？

注册 provider，每 tick 提交当前 tick 消息。

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"金币: ",color:"gold",extra:[{score:{name:"@s",objective:"coin"}}]}
function mqp_actionbar:add
```

---

## Q4：多个消息会怎么显示？

如果同一 tick 有：

```text
金币: 188
低血量!
购买完成
```

最终显示：

```text
金币: 188 | 低血量! | 购买完成
```

分隔符是灰色的：

```text
 | 
```

---

## Q5：同一个 source 的消息会怎样？

同一玩家同一 source 只保留最新一条。

例如连续调用：

```text
购买完成：钻石
购买完成：金苹果
```

如果它们都使用：

```text
shop.purchase
```

最终只显示：

```text
购买完成：金苹果
```

---

# 12. 最小示例

## 12.1 注册一个 provider

`data/mqp_actionbar/tags/functions/actionbar_providers.json`

```json
{
  "values": [
    "demo:provider_coin"
  ]
}
```

`data/demo/functions/provider_coin.mcfunction`

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"金币: ",color:"gold",extra:[{score:{name:"@s",objective:"coin"}}]}
function mqp_actionbar:add
```

---

## 12.2 在事件中显示一次性提示

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"购买完成",color:"green"}
data modify storage mqp_actionbar:api duration set value 40
data modify storage mqp_actionbar:api source set value "shop.purchase"
function mqp_actionbar:timed/add_timed
```

最终如果金币 provider 和购买提示同时存在，玩家看到：

```text
金币: 188 | 购买完成
```

---

# 13. 简短结论

使用 `mqp_actionbar` 时记住三点：

1. **不要直接 `title actionbar`**，统一交给管理器。
2. **状态型信息用 provider + `mqp_actionbar:add`。**
3. **一次性事件提示直接调用 `mqp_actionbar:timed/add_timed`，高频事件加 `source`。**

最常用写法：

```mcfunction
data modify storage mqp_actionbar:api msg set value {text:"提示内容",color:"green"}
data modify storage mqp_actionbar:api duration set value 40
data modify storage mqp_actionbar:api source set value "your.source"
function mqp_actionbar:timed/add_timed
```