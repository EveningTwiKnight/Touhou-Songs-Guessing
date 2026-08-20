# 东方Project 原曲听力测试

一个纯前端的「听音猜曲」小游戏：随机播放《东方Project》原作 MIDI 的一个片段，玩家从四个选项里选出正确的曲名。

不加载任何音色库（.sf2），直接用 **Web Audio API** 合成声音：

- 旋律声部使用 `OscillatorNode` 方波；
- 打击乐（GM 通道 10）使用噪声与振荡器合成鼓声（Kick、Snare、Hi-Hat、Tom、Cymbal 等）。

## 怎么玩（电脑小白也能一键启动）

### Windows 用户（推荐，无需安装任何东西）

1. 下载本项目并解压。
2. **双击 `启动游戏.bat`**。
3. 会自动打开浏览器进入游戏。

原理：脚本用 Windows 自带的 PowerShell 在本地起了一个小服务器，然后自动打开游戏页面。**保持那个黑窗口开启**，关掉它游戏服务器就会停止。

### macOS / Linux 用户

在项目目录执行：

```bash
python3 -m http.server 8000
```

然后访问 `http://localhost:8000/index.html`。

> 为什么不能直接双击 `index.html`？
> 因为浏览器出于安全限制，会禁止网页用 `fetch` 读取本地 `.mid` 文件，所以必须通过本地服务器打开。

## 玩法

1. 选择难度（Easy / Normal / Hard / Lunatic，对应 6 / 5 / 3 / 1.5 秒片段）。
2. 可选开启「无尽模式」。
3. 点击「开始游戏」后，会随机播放一段 MIDI 片段。
4. 从四个曲名中选出正确答案；答完 7 题结算得分。

## 文件结构

```
.
├── index.html            # 游戏主页面（含 MIDI 解析与 Web Audio 合成引擎）
├── song_database.js      # 曲目数据库（曲名 ↔ .mid 文件路径）
├── 启动游戏.bat           # Windows 一键启动（双击运行）
├── server.ps1            # 本地服务器脚本（由 .bat 自动调用）
└── audio/
    ├── Scarlet_Devil/    # 东方红魔乡（17 首 .mid）
    ├── Perfect_Cherry/   # 东方妖妖梦（20 首 .mid）
    └── Imperishable_Night/ # 东方永夜抄（21 首 .mid）
```

## 第三方依赖与许可

本仓库本身不打包任何第三方库源码，均通过 CDN 在运行时加载：

- **[midi-parser-js](https://github.com/colxi/midi-parser-js)**（作者：colxi，v4.0.4）
  - 用途：解析 MIDI 文件。
  - 许可证：**GPL-3.0**（copyleft）。
  - 加载方式：`https://cdn.jsdelivr.net/npm/midi-parser-js@4.0.4/src/main.js`
  - ⚠️ 注意：GPL 是传染性许可证。本项目**仅通过 CDN 引用、未将该库源码纳入本仓库**；如需把库文件打包进本项目，请遵守 GPL-3.0 条款（随附许可证文本、提供源码），并评估对自身代码许可证的影响。

- **[Google Fonts](https://fonts.google.com/)：Shippori Mincho / Noto Serif JP**
  - 用途：页面字体。
  - 许可证：**SIL Open Font License 1.1**。

## 音乐版权声明

本项目中收录的 MIDI 曲目为《东方Project》系列游戏音乐，原作者为 **ZUN（上海アリス幻樂団）**。这些文件仅用于个人学习与非商业用途，版权归原作者所有。
