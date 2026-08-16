# 东方Project 原曲听力测试

基于 Web 的交互式音乐听力训练工具。玩家收听随机截取的原曲片段，从四个选项中选出对应的曲目名称。

## 背景

本项目灵感来源于 2026 年江西THO5 秋水鸣歌再宴（东方ip限定的同人展）线下活动中的“原曲听力”互动环节。本人以学习为目的，从零开始独立复刻了其核心玩法。

## 功能特性

- 四种难度：Easy / Normal / Hard / Lunatic，控制播放时长（6s / 5s / 3s / 1.5s）
- 两种游戏模式：
  - 标准模式：共 7 题，答错 4 题即失败
  - 无尽模式：前 7 题规则同上，通关后无限继续，直至连续答错 4 题
- 音频片段随机截取，每次起始位置不同
- 支持自定义曲库（修改 `song_database.js` 即可）
- 本地运行，无需服务器

## 技术栈

| 技术 | 用途 |
| --- | --- |
| HTML5 | 页面结构 |
| CSS3 | 样式主题 |
| JavaScript (ES6) | 游戏逻辑与音频控制 |
| Web Audio API | 音频加载与播放 |

## 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/EveningTwiKnight/Touhou-Songs-Guessing.git
cd Touhou-Songs-Guessing
```
或者直接选择下载压缩包，解压后即可。

另外，受Github文件上传大小的限制，对应得曲库文件请从此网盘链接下载，或者联系本人私发给你，并将文件夹解压到存储本程序对应的文件夹下。

链接：https://pan.quark.cn/s/a9e154f65dd2

为了确保程序正常运行，请查看下文提及的项目结构，并与你的文件夹内容作比对，确保一致。

### 2.运行
克隆完成之后，直接双击index.html文件即可运行

##项目结构

Touhou-Songs-Guessing/
├── index.html
├── song_database.js
├── audio/
│   ├── Scarlet_Devil/
│   ├── Perfect_Cherry/
│   └── Imperishable_Night/
└── README.md

##致谢
上海爱丽丝幻乐团  —— 原曲音乐版权方
江西THO空想豫章筹办组  —— 提供线下活动场景与灵感
以及我的所有好朋友们，感谢你们对我的精神支持！

##声明
本项目仅供同人文化交流与学习使用。所有音乐版权归上海爱丽丝幻乐团所有，请勿将音频文件用于商业用途。
