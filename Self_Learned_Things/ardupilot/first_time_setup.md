# ardupilot开发环境搭建到无人机首次起飞

本文是对于每个步骤的官方指导的一个flow式总结，重点撰写一个尽可能一步一步操作的指导书，因此不甚关注背后的技术细节，当遇到问题时：

- 文档的每一节开头都会给出这一节参考的官方文档的[网页连接](url)，当遇到任何问题时请首先打开相应的官方文档，查阅相应的步骤，是否给出了troubleshoot的细节说明
- 大部分官方文档是英文，所以用好“网页翻译”和词典很重要，**原文**也很重要，**机器翻译很容易引起误解**。

## 开发环境搭建（以Windows11为例）

### 安装WSL2

- [How to install Linux on Windows with WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Set up a WSL development environment](https://learn.microsoft.com/en-us/windows/wsl/setup/environment)

1. 在开始菜单中搜索“powershell”，选择“以管理员身份运行”。

    输入命令`wsl --install`，

    >若网络连接错误，更换流量/校园网，或者打开加速器确保能连接上github

    >若命令找不到错误，尝试手动安装
    >
    >输入命令`dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`
    >
    >若命令执行错误，确保系统版本是win10 2004以上或者win11
    >
    >输入命令`dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`
    >
    >重启电脑
    >
    >重新执行命令
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

- [Setting up the Build Environment (Linux/Ubuntu)](https://ardupilot.org/dev/docs/building-setup-linux.html#building-setup-linux)

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
3. Windows端与WSL文件互相访问

    Windows端打开文件资源管理器，在左下角可以看到Linux，点击即可看到已经安装的WSL发行版，再点击即可进入WSL文件目录

    WSL终端内`cd`到 /mnt 目录，`ls`即可看到c d e盘，对应Windows系统

### 编译并在无人机模拟器上运行ardupilot系统

- [Setting up SITL on Linux](https://ardupilot.org/dev/docs/setting-up-sitl-on-linux.html)

1. ```bash
    cd 你克隆的Ardupilot目录/ArduCopter # 从copter目录启动才能模拟直升飞机，相应地，从rover目录启动就可以模拟小车
    # 初次启动模拟会自动编译ardupilot系统源代码
    sim_vehicle.py --console --map -w # 启动控制台 启动地图显示  启动时恢复固件出厂设置
    ```

## 给飞控板安装Ardupilot并进行系统初次运行硬件校正

- [First Time Setup](https://ardupilot.org/copter/docs/initial-setup.html) 以及本章下的所有小节
- [飞控调试顺序](http://pix.1yuav.com/wen-ti-ji-jin/fei-kong-diao-shi-shun-xu.html)

### 安装地面控制站软件（ground control station software）

- [Installing Ground Station (GCS) software](https://ardupilot.org/copter/docs/common-install-gcs.html)
- [如何安装地面站](http://pix.1yuav.com/ru-he-an-zhuang-di-mian-zhan.html)

>地面控制站软件可以有多种选择，连接ardupilot系统最常用的是mission planner，以下以此为例，macos系统可用apm planner，PC手机跨平台可以选择qgroundcontrol，这些软件都可以完成全部的功能

1. 前往[mission planner官网](https://ardupilot.org/planner/docs/mission-planner-installation.html)点击`Download the latest Mission Planner installer from here`下载安装包

2. 运行安装包，完成后在开始菜单内找到并打开

### 向飞控板中刷写系统固件

- [如何在线刷固件](http://pix.1yuav.com/ru-he-shua-gu-jian.html)
- [Loading Firmware](https://ardupilot.org/copter/docs/common-loading-firmware-onto-pixhawk.html)

1. 连接GCS和飞控板：使用micro usb数据线连接电脑和飞控板，在mission planner右上方选择端口为AUTO或者COM X (ARDUPILOT)，选择AUTO连接成功后会自动变成无人机所在的COM端口，选择比特率为115200，刷写固件前不需要点击连接按钮，如果已经点击了，再点击一次断开连接
2. 更换地图正常显示：点击上方“飞行计划”，在右侧将谷歌地图换成高德或者必应地图即可正常显示。
3. 刷写新版本固件：点击“初始设置”，点击“刷写固件”，点击“copter vx.x.x official”，按照提示开始刷写
4. 将飞控状态重置：下方绿色进度条下显示“scanning ports”时，使用中性笔笔尖、牙签等针状物轻戳飞控板micro usb口左侧的凹陷处（reset按钮）
5. 等待固件刷写完成：稍等片刻，进度条提示依次变为“erase”, "programming", "complete/successful"刷写完成，断电重启飞控板

### 无人机硬件校准

**飞控板供电有两种方式：一种连接USB线由电脑供电，一种连接电池供电，两种方式同时连接有烧毁无人机硬件的危险！同时只能一种方式连接！**

- [Frame Class and Type Configuration](https://ardupilot.org/copter/docs/frame-type-configuration.html)
- [如何校准加速度](http://pix.1yuav.com/ru-he-xiao-zhun-jia-su-du.html)
- [Pixhawk双罗盘校准方法](http://pix.1yuav.com/luo-pan-xiao-zhun.html)
- [遥控器校准](http://pix.1yuav.com/yao-kong-xiao-zhun.html)
- [电调油门校准](http://pix.1yuav.com/dian-diao-you-men-xiao-zhun.html)
- [多旋翼飞行器无刷电子调速器使用说明书](https://www.hobbywing.com/uploads/file/20220909/3318ca05cb373be8da82e99f3b990ddd.pdf)

1. 选择机架类型：点击“初始设置-mandatory hardware-机架选择/frame type”，选择机架的形状，匹配自己的无人机，断电重启飞控板
2. 加速度计校准：飞控放平，箭头对向电脑屏幕，当点击“校准加速度”按钮时，飞控RGB灯会红蓝闪，这时我们不可以去移动飞控，等红蓝闪过后就会提示开始校准。

    例如地面站提示放平，飞控放平，点击键盘任意键或者地面站按钮。
    飞控有箭头，校准前，飞控箭头对向电脑屏幕。
    “LEVEL”，放平，一定要确保飞控所在位置是平的，这步很重要。“LEFT” 飞控向左，“RIGHT”飞控向右，“DOWN”飞控箭头向下，“UP”飞控箭头向上。

    成功后提示“sucessful”，失败会提示"failed",失败一般是飞控没有准确放置方位。成功后，飞控断电，重新连接。

    连接后，飞控放平，点击“校准水平”，成功后断电重启。
3. 校准罗盘：成功后，飞控要断电重新连接，这步一定要做。

   飞控支持使用双罗盘（也就是内置罗盘和外置罗盘同时使用）但由于内置罗盘容易受干扰，加上如果没有正确校准，容易出现罗盘不同步的错误。所以，如果飞控加了GPS罗盘，完全可以只使用外置罗盘，因为外置罗盘不容易受干扰，比较稳定！

    飞控连接地面站，在初始设置-》指南针那里进行校准。“自动偏移量”的勾要勾起来。指南针#1 是GPS罗盘，属于外置罗盘，所以外部罗盘的勾要打起来。要选None，不可以选ROLL_180，因为GPS的罗盘和pixhawk飞控的罗盘是同一面且同方向的，这个要注意！指南针#2是飞控内置罗盘。确保选项按照上面的图正确设置，之后点击"开始"按钮即可开始校准。

    校准开始后，飞控板白色箭头指向空间的六个方向分别旋转360°，所有绿色进度条都走到头后校准成功，如果失败进度条会自动清空，需要从头旋转。
4. 点击“校准遥控器”按钮前请先打开遥控器，如果没开遥控器就点，切换到飞行数据界面，打开遥控器后再切换到遥控器校准界面。

    校准时上下左右打，再打圆球，确保每个通道的最大最小值正确采集。

    Install setup（初始设置）——Mandatory Hardware——Radio Calibrated（遥控校准）——点击窗口右边的校准遥控按钮.点击“校准遥控”，然后点击OK开始拨动遥控开关，使每个通道的红色提示条移动到上下限的位置。注意点击“校准遥控器”按钮前先打开遥控器，如果没开遥控器就点，切换到飞行数据界面再切换到遥控器校准界面。

    当每个通道的红色指示条移动到上下限位置的时候，点击Click when Done，保存校准时候，弹出两个OK窗口后完成遥控器的校准。

    如果你拨动摇杆时上面的指示条没有变化，请检查接收机连接是否正确，另外同时检查下每个通道是否对应.
5. 电调校准（以好盈为例）：开启遥控器，将油门摇杆推至最高点

    接通飞控板电源，确保遥控器和飞控板通讯正常，观察飞控板LED灯红绿蓝三色循环闪烁后飞控板断电

    保持油门摇杆最高点，接通飞控板电源，观察飞控板LED灯红绿蓝三色循环闪烁后，解锁安全开关至红灯常亮

    电机将按以下顺序循环鸣叫，“哔-哔-”油门行程校准；“哔-哔-哔-”中进角；“哔-哔-哔-哔-”高进角；听到对应的提示音后3秒内将油门摇杆打至最低点，同时遥控器断电，即可完成相应设定

    一般情况下，中进角可适用大多数马达，而且动力系统效率更高，发热量小，更具兼容性。高进角可提高电机转速，但发热量通常也会更多。
6. 无人机试解锁（***拆除螺旋桨！***）：连接电池，等待飞控板开机响声

    打开安全开关，长按至红灯常亮

    打开遥控器，油门放最低

    等待飞控板LED灯变为蓝色常亮，将遥控器油门杆打到最低，方向打到最高（最右），飞控长滴一声解锁成功

    轻推油门杆，测试电机是否全部同步转动

    将遥控器油门杆打到最低，方向打到最低（最左），飞控长滴一声锁定成功，关闭遥控器，长按关闭安全开关，断开电池，测试结束

## 初次起飞无人机并进行微调

- [First Flight with Copter](https://ardupilot.org/copter/docs/flying-arducopter.html) 以及本章下的所有小节
