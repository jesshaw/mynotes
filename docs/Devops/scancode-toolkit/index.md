# ScanCode toolkit

一个典型的软件项目通常会重复使用数百个第三方包。许可证和来源信息并不总是容易找到且不规范化：ScanCode 会为您发现并规范化这些数据。

https://github.com/nexB/scancode-toolkit

## 为什么要使用ScanCode？

- 作为一个独立的命令行工具，ScanCode易于安装、运行和嵌入到您的 CI/CD 处理管道中。它可在Windows、macOS 和 Linux上运行。
- ScanCode 被多个项目和组织使用，例如Eclipse Foundation、 OpenEmbedded.org、FSFE、FSF、 OSS Review Toolkit、 ClearlyDefined.io、 RedHat Fabric8 分析等等。
- ScanCode 可检测源代码和二进制文件中的许可证、版权、包清单、直接依赖项等，被认为是该领域的同类最佳和参考工具，可重新用作软件组合数据收集的核心工具通过几个开源工具。
- ScanCode 提供最准确的许可证检测引擎，并在许可证文本数据库和您的代码之间进行全面比较（也称为差异或红线比较），而不是仅依赖近似正则表达式模式或概率搜索、编辑距离或机器学习。
- ScanCode 用 Python 编写，很容易通过插件进行扩展，以提供新的和改进的扫描器、数据汇总、包清单解析器和新的输出。
- 您可以将扫描结果保存为JSON、HTML、CSV 或 SPDX，或者使用 Jinja 模板创建您自己的格式。
- 您还可以使用配套的ScanCode.io Web 应用程序 在服务器端组织和运行 ScanCode，以组织和存储多个扫描项目，包括脚本化扫描管道。
- ScanCode 得到积极维护，拥有不断增长的用户和贡献者社区。
- ScanCode 注重重测试的，自动测试套件的超过20000测试。
- ScanCode 拥有广泛且不断增长的文档。
- ScanCode 可以处理这些包，构建清单和锁定文件格式以提取元数据：Alpine 包、BUCK 文件、ABOUT 文件、Android 应用程序、Autotools、Bazel、JavaScript Bower、Java Axis、MS Cab、Rust Cargo、Chef Chrome 应用程序、PHP Composer 和composer.lock、Conda、CPAN、Debian、Apple dmg、Java EAR、WAR、JAR、FreeBSD 包、Rubygems gemspec、Gemfile 和 Gemfile.lock、Go 模块、Haxe 包、InstallShield 安装程序、iOS 应用程序、ISO 映像、Apache IVY、 JBoss Sar、R CRAN、Apache Maven、Meteor、Mozilla 扩展、MSI 安装程序、JavaScript npm 包、package-lock.json、yarn.lock、NSIS 安装程序、NugGet、OPam、Cocoapods、Python PyPI setup.py、setup.cfg、以及几种相关的锁文件格式，半结构化的 README 文件，例如 README.android、README.chromium、README.facebook、README.google、README.thirdparty、RPM、Shell Archives、Squashfs 图像、Java WAR、Windows 可执行文件。

## 安装

https://scancode-toolkit.readthedocs.io/en/latest/getting-started/install.html

## 执行扫描

```bash
# 对samples目录进行版权、licenses、packages、
scancode -clpeui -n 2 --ignore "*.java" --json-pp sample.json samples
```

基本扫描项

-clpeui ： https://scancode-toolkit.readthedocs.io/en/latest/cli-reference/basic-options.html#all-basic-scan-options

核心扫描项

-n : https://scancode-toolkit.readthedocs.io/en/latest/cli-reference/core-options.html#all-core-scan-options

预定义扫描项

--ignore : https://scancode-toolkit.readthedocs.io/en/latest/cli-reference/scan-options-pre.html

扫描输出格式

--json-pp : https://scancode-toolkit.readthedocs.io/en/latest/cli-reference/output-format.html