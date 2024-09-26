# ardupilot开发环境搭建到无人机首次起飞

本文是对于每个步骤的官方指导的一个flow式总结，重点撰写一个尽可能一步一步操作的指导书，因此不甚关注背后的技术细节，当遇到问题时：

- 文档的每一节开头都会给出这一节参考的官方文档的[网页连接](url)，当遇到任何问题时请首先打开相应的官方文档，查阅相应的步骤，是否给出了troubleshoot的细节说明
- 大部分官方文档是英文，所以用好“网页翻译”和词典很重要，**原文**也很重要，**机器翻译很容易引起误解**。

## 开发环境搭建（以Windows11为例）

### 安装WSL2

- [How to install Linux on Windows with WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Set up a WSL development environment](https://learn.microsoft.com/en-us/windows/wsl/setup/environment)

1. 在开始菜单中搜索“powershell”，选择“以管理员身份运行”。

    方法一：输入命令`wsl --install`，

    >若网络连接错误，更换流量/校园网，或者打开加速器确保能连接上github
    >
    >若命令找不到错误，尝试方法二

   方法二：手动安装

    输入命令`dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`
    >若命令执行错误，确保系统版本是win10 2004以上或者win11

    输入命令`dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`

    重启电脑

    重新执行方法一
2. 设置WSL2为默认版本：

    在powershell中输入`wsl --set-default-version 2`
3. 在开始菜单中搜索Ubuntu，点击打开，按照提示设置用户名和密码，不要有中文
4. 完成！使用apt安装需要的包，使用sudo以管理员执行命令，各种操作和在普通Ubuntu终端中完全一样。
5. 使用完毕后，回到powershell，输入`wsl --shutdown`可以关机WSL，输入`wsl --list -v`可以查看已经安装了哪些WSL发行版和运行状态。

---

以下是一些概念上的疑惑解答参考，什么是WSL？WSL1和2有什么区别？等等，和开发环境搭建的操作本身没有太大关系

- [What is the Windows Subsystem for Linux?](https://learn.microsoft.com/en-us/windows/wsl/about)
- [Comparing WSL Versions](https://learn.microsoft.com/en-us/windows/wsl/compare-versions)
- [Frequently Asked Questions about Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/faq)

---

### 为WSL2获取项目代码和安装编译工具

[Setting up the Build Environment (Linux/Ubuntu)](https://ardupilot.org/dev/docs/building-setup-linux.html#building-setup-linux)

1. 通过终端使用apt安装git

    ```bash
    sudo apt update
    sudo apt install git
    sudo apt install gitk git-gui
    ```

2. 使用git从GitHub克隆最新ardupilot源代码到本地目录

    ```bash
    cd ~
    mkdir 你自己放代码的目录
    cd 你自己放代码的目录
    git clone --recurse-submodules https://github.com/ArduPilot/ardupilot.git
    ```

3. 使用ardupilot仓库内置的脚本安装编译依赖的各种库

    ```bash
    cd ~/你自己放代码的目录/你克隆的Ardupilot目录
    cd Tools/environment_install/
    ./install-prereqs-ubuntu.sh -y
    ```

    > 安装过程中，报错某某包由于种种原因无法安装解决办法
    >
    >```bash
    >sudo apt install aptitude # aptitude是一种更高级的交互式的Linux包管理器
    >sudo aptitude update
    >aptitude install 报错某某包
    ># 按照提示升降级相应的包
    ># 重新执行安装脚本
    >./install-prereqs-ubuntu.sh -y
    >```

4. 关机WSL`wsl --shutdown # 在powershell中`并重新打开WSL

### 为Windows本机系统安装编译工具

- [Setting up the Build Environment on Windows 11 using WSL](https://ardupilot.org/dev/docs/building-setup-windows11.html#building-setup-windows11)

1. 安装Windows端git并与WSL内git同步

    在Windows浏览器中搜索git for windows，打开官网，点击download，下载完成后运行安装包

    打开WSL终端，输入`git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager.exe"`
2. 将Windows端vscode与WSL同步

    在Windows端vscode中安装扩展包 [remote development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

    按快捷键ctrl+shift+p呼出vscode命令面板，输入 remote wsl 点击“使用发行版连接到WSL”，选择刚才克隆Ardupilot源码的发行版（如果只有一个选项无脑选，一般是Ubuntu）

    现在在左侧资源管理器（或左上角“文件”）“打开文件夹”，即可直接打开WSL系统中的文件目录

### 编译并在无人机模拟器上运行ardupilot系统

- [Setting up SITL on Linux](https://ardupilot.org/dev/docs/setting-up-sitl-on-linux.html)

## 给飞控板安装Ardupilot并进行系统初次运行硬件校正

- [First Time Setup](https://ardupilot.org/copter/docs/initial-setup.html) 以及本章下的所有小节

## 初次起飞无人机并进行微调

- [First Flight with Copter](https://ardupilot.org/copter/docs/flying-arducopter.html) 以及本章下的所有小节
