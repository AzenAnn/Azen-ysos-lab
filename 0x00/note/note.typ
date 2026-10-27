#import "../../template/report.typ": report

// 使用模板生成封面和正文样式。
#show: report.with(
  title: "操作系统实验学习笔记",
  subtitle: "实验零：环境搭建与准备",
  name: "Azen",
  stdid: "待填写",
  classid: "待填写",
  major: "待填写",
  school: "待填写",
  time: "2026 年 10 月 27 日",
  // 以编译时指定的项目根目录为起点。
  banner: "/template/images/sysu.png",
)

// 正文字体使用本机已有的 Noto 中文字体。
#set text(font: "Noto Serif CJK SC")
#show raw: set text(font: "Noto Sans Mono CJK SC", size: 9pt)
#show figure.caption: set text(size: 9pt)

// ---------- 软件源调整 ----------

= 更新包管理器

更新软件包时，遇到了下载速度很慢的问题。
后来将软件源从阿里云切换为华为云，下载速度得到改善。

gzgg 提供了一个与限速有关的排查线索：

#figure(
  image("image-1.png", width: 65%),
  caption: [关于软件源下载速度的交流记录],
)

随后，我又通过 Codex 排查原因，得到了类似的解释，
相关记录如下：

#figure(
  image(
    "e9452760df20e407e3a75ebf667bb565.png",
    width: 100%,
    height: 120mm,
    fit: "contain",
  ),
  caption: [通过 Codex 排查下载速度问题的记录],
)

本次可以确认的现象是：更换软件源后，下载速度得到改善。
截图中的具体限速解释暂作为排查线索保留。

// ---------- 基础环境 ----------

= 验证基础环境

使用以下命令检查 QEMU、GCC 和 GDB 是否可以正常调用，
并查看各工具的版本：

```bash
qemu-system-x86_64 --version
gcc --version
gdb --version
```

检查结果如下：

#figure(
  image("image.png", width: 100%),
  caption: [QEMU、GCC 和 GDB 的版本检查],
)

// ---------- Rust 工具链 ----------

= Rust 开发环境准备

按照教程安装 Rustup 后，在实验零的项目目录中配置工具链。

该目录包含 `rust-toolchain.toml`。
进入目录执行 Cargo 命令时，Rustup 会依据配置选择工具链，
并在需要时下载缺少的组件。

```bash
cd ~/labs/ysos/Azen-ysos-lab/0x00
cargo --version
rustup show
```

从检查结果可以看到：

- `stable` 是默认工具链。
- 当前实验目录使用 `nightly` 工具链。
- 当前工具链的选择来自项目中的 `rust-toolchain.toml`。
- 已安装 `x86_64-unknown-uefi` 编译目标。

#figure(
  image("image-2.png", width: 100%),
  caption: [实验零的 Rust 工具链检查结果],
)

// ---------- 构建工具 ----------

= 验证工作

按照教程检查 Make 和 Python，并再次确认 QEMU 可以使用：

```bash
make --version
python3 --version
qemu-system-x86_64 --version
```

对应版本为：

#figure(
  table(
    columns: (1fr, 1fr),
    align: center,
    inset: 8pt,
    table.header([*工具*], [*版本*]),
    [GNU Make], [4.3],
    [Python], [3.12.3],
    [QEMU], [8.2.2],
  ),
  caption: [基础工具版本汇总],
)

实际终端输出如下：

#figure(
  image("image-3.png", width: 100%),
  caption: [Make、Python 和 QEMU 的验证结果],
)

// ---------- Typst 安装 ----------

= 安装 Typst

使用官方提供的 Linux x86_64 预编译包，
将 Typst 安装到系统程序目录 `/usr/local/bin`。

== 下载与解压

以下变量用于缩短下载命令，方便阅读和记录：

```bash
cd ~

typst_release="https://github.com/typst/typst"
typst_release="$typst_release/releases/download/v0.15.1"
typst_archive="typst-x86_64-unknown-linux-musl.tar.xz"

curl -fL "$typst_release/$typst_archive" \
  -o "$typst_archive"

tar -xf "$typst_archive"
```

== 安装程序

将解压后的可执行文件复制到 `/usr/local/bin/typst`，
并设置执行权限：

```bash
sudo install -m 755 \
  typst-x86_64-unknown-linux-musl/typst \
  /usr/local/bin/typst
```

== 刷新缓存与验证

清除 Bash 缓存的命令路径，再检查 Typst 的位置和版本：

```bash
hash -r
command -v typst
typst --version
```

本次验证中，程序位置为 `/usr/local/bin/typst`，
版本为 `0.15.1`。