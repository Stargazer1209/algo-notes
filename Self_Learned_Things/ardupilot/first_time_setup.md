# ardupilot开发环境搭建到无人机首次起飞

本文是对于每个步骤的官方指导的一个flow式总结，重点撰写一个尽可能一步一步操作的指导书，因此不甚关注背后的技术细节，当遇到问题时：

- 文档的每一节开头都会给出这一节参考的官方文档的[网页连接](url)，当遇到任何问题时请首先打开相应的官方文档，查阅相应的步骤，是否给出了troubleshoot的细节说明
- 大部分官方文档是英文，所以用好“网页翻译”和词典很重要，**原文**也很重要，**机器翻译很容易引起误解**。

## 开发环境搭建（以Windows11为例）

### 安装WSL2

- [How to install Linux on Windows with WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Set up a WSL development environment](https://learn.microsoft.com/en-us/windows/wsl/setup/environment)
- [Setting up the Build Environment on Windows 11 using WSL](https://ardupilot.org/dev/docs/building-setup-windows11.html#building-setup-windows11)

---

以下是一些概念上的疑惑解答参考，什么是WSL？WSL1和2有什么区别？等等，和开发环境搭建的操作本身没有太大关系

- [What is the Windows Subsystem for Linux?](https://learn.microsoft.com/en-us/windows/wsl/about)
- [Comparing WSL Versions](https://learn.microsoft.com/en-us/windows/wsl/compare-versions)
- [Frequently Asked Questions about Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/faq)

---

### 为WSL2获取项目代码和安装编译工具

[Setting up the Build Environment (Linux/Ubuntu)](https://ardupilot.org/dev/docs/building-setup-linux.html#building-setup-linux)

### 为Windows本机系统安装编译工具

### 编译并在无人机模拟器上运行ardupilot系统

- [Setting up SITL on Linux](https://ardupilot.org/dev/docs/setting-up-sitl-on-linux.html)

## 给飞控板安装Ardupilot并进行系统初次运行硬件校正

- [First Time Setup](https://ardupilot.org/copter/docs/initial-setup.html) 以及本章下的所有小节

## 初次起飞无人机并进行微调

- [First Flight with Copter](https://ardupilot.org/copter/docs/flying-arducopter.html) 以及本章下的所有小节
