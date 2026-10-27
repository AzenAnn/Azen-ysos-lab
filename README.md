<div align="center">

# Azen · YatSenOS Lab

**从第一行 Rust，到自己的操作系统。**

跟随 YatSenOS v2，记录代码、实验与每一次「原来如此」。

![Rust](https://img.shields.io/badge/Rust-nightly-CE422B?style=flat-square&logo=rust&logoColor=white)
![Architecture](https://img.shields.io/badge/Arch-x86__64-2563EB?style=flat-square)
![Boot](https://img.shields.io/badge/Boot-UEFI-7C3AED?style=flat-square)
![Emulator](https://img.shields.io/badge/Emulator-QEMU-EF4444?style=flat-square&logo=qemu&logoColor=white)
![Status](https://img.shields.io/badge/Status-Learning-16A34A?style=flat-square)

[实验导航](#-实验导航) · [学习笔记](0x00/note/note.md) · [开发环境](#-开发环境) · [原版教程](https://ysos.gzti.me/)

</div>

---

## 🌱 关于这个仓库

这是 Azen 跟随 [YatSenOS-Tutorial-Volume-2](https://github.com/YatSenOS/YatSenOS-Tutorial-Volume-2) 学习操作系统的个人实验仓库。

以 Rust 为主要语言，在 QEMU 提供的 x86_64 虚拟机中，从 UEFI 启动出发，逐步理解内核、中断与底层运行机制。这里保存每个阶段的实验代码，也记录环境配置、调试过程和问题背后的原因。

> **当前进度：** 已完成基础开发环境与实验零 Rust 工具链的配置和验证，接下来进行 Rust 练习与 UEFI 启动实验。仓库中的起始代码仍有待实现部分。

## 🧭 实验导航

| 实验 | 主题 | 状态 | 入口 |
| :--- | :--- | :--- | :--- |
| `0x00` | 环境搭建与实验准备 | 🟡 环境验证完成，编程任务待完成 | [代码](0x00/) · [笔记](0x00/note/note.md) |
| `0x01` | 操作系统的启动 | ⚪ 已放入起始代码，待学习 | [代码](0x01/) |
| `0x02` | 中断处理 | ⚪ 已放入起始代码，待学习 | [代码](0x02/) |

后续实验随学习进度逐步加入。

### 实验零 · 下一步

- [x] 验证 Make、Python、QEMU 等基础工具
- [x] 配置 Rust nightly、开发组件与 UEFI 编译目标
- [x] 记录环境搭建过程与截图
- [ ] 完成 Rust 基础编程练习
- [ ] 使用 QEMU 启动 UEFI Shell
- [ ] 完成并运行第一个 UEFI 程序
- [ ] 整理实验思考题与结果

## 🗂️ 目录结构

```text
Azen-ysos-lab/
├── README.md                 # 仓库介绍与学习进度
├── .gitignore                # 构建产物与本地文件忽略规则
├── LICENSE.upstream          # 上游 YatSenOS 代码的 MIT 许可证
├── 0x00/                     # 实验零：环境搭建与实验准备
│   ├── .cargo/               # Cargo 配置
│   ├── assets/               # UEFI 固件等实验资源
│   ├── crates/boot/          # UEFI 启动程序
│   ├── note/                 # 学习笔记与截图
│   ├── Cargo.toml            # 实验工作区配置
│   ├── rust-toolchain.toml   # 工具链、组件与编译目标声明
│   ├── Makefile              # 构建与运行入口
│   └── ysos.py               # Python 构建与运行脚本
├── 0x01/                     # 实验一的起始代码
└── 0x02/                     # 实验二的起始代码
```

每个阶段的代码以对应教程为准；后续实验存在前后依赖，需要在学习过程中补全和整合。

## 🛠️ 开发环境

以下是环境搭建阶段实际验证过的配置，供复现时参考。

| 工具 / 平台 | 已验证配置 | 用途 |
| :--- | :--- | :--- |
| Ubuntu | 24.04 · x86_64 | 开发环境 |
| Rust | nightly，由实验目录中的配置文件选择 | 编译实验代码 |
| 编译目标 | `x86_64-unknown-uefi` | 构建 UEFI 程序 |
| Rust 组件 | `clippy`、`rust-src`、`rustfmt` | 代码检查、库源码与格式化 |
| GNU Make | 4.3 | 执行构建任务 |
| Python | 3.12.3 | 运行实验脚本 |
| QEMU | 8.2.2 | 模拟实验计算机 |

### 检查实验零的工具链

在仓库根目录打开终端，进入实验目录后执行：

```bash
cd 0x00
cargo --version
rustup show
```

Rustup 会依据当前项目的 `rust-toolchain.toml` 选择工具链，并在需要时下载缺少的组件。当前实验应使用 `nightly`，已安装目标中应包含 `x86_64-unknown-uefi`。

如果安装 Rust 后，旧终端仍提示找不到 `cargo`，可在该终端加载环境：

```bash
source "$HOME/.cargo/env"
```

### 构建与运行入口

以下命令均在 `0x00/` 下执行。**当前启动程序仍需补全；这些是后续实验的操作入口，尚未完成运行验证。**

```bash
# 预览脚本将执行的步骤，不实际编译或启动虚拟机
python3 ysos.py run --dry-run

# 补全实验代码后，编译并运行
make run

# 也可以使用 Python 脚本编译并运行
python3 ysos.py run
```

QEMU 使用终端模式运行时，先按 `Ctrl+A`，再按 `X` 退出。

## 📝 学习记录

采用「理解 → 实现 → 验证 → 记录」的节奏推进实验：

- **理解：** 梳理概念，弄清每条命令和每段代码的作用。
- **实现：** 在教程起始代码上逐步完成实验任务。
- **验证：** 保留关键输出、运行截图和调试结果。
- **记录：** 写下遇到的问题、原因和解决方法。

第一篇记录：[实验零 · 环境搭建笔记](0x00/note/note.md)。

## 📚 来源与致谢

本仓库的实验起始代码来自 [YatSenOS-Tutorial-Volume-2](https://github.com/YatSenOS/YatSenOS-Tutorial-Volume-2)，实验内容参考 [YatSenOS v2 在线教程](https://ysos.gzti.me/)。感谢原项目作者和贡献者提供教程与代码。

上游项目采用 MIT 许可证，其版权声明与许可全文保留在 [LICENSE.upstream](LICENSE.upstream) 中。本仓库记录个人学习过程，实验完成情况以导航表和实际代码为准。

---

<div align="center">

<sub>一点点理解，一步步启动。</sub>

</div>
