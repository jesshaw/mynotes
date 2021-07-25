# vagrant 常用命令

## 1 下载安装 VirtualBox

> 下载地址：[VirtualBox](https://link.jianshu.com?t=https://www.virtualbox.org/wiki/Downloads)

## 2 安装Vagrant

> 下载地址：[Vagrant](https://link.jianshu.com?t=http://downloads.vagrantup.com/)

## 3 下载系统镜像

> 下载地址1：[http://www.vagrantbox.es/](https://link.jianshu.com?t=http://www.vagrantbox.es)
> 下载地址2：[vagrant box | vagrantcloud.com](https://link.jianshu.com?t=https://atlas.hashicorp.com/boxes/search?utm_source=vagrantcloud.com&vagrantcloud=1)
> 下载地址3：[diy box](https://link.jianshu.com?t=https://puphpet.com/)

## 4 常用命令

```bash
1 vagrant box list  #box列表

2 添加box
   vagrant box add (box_name)  (file_path)
   #添加box box_name 为box取的名称  file_path 系统镜像地址
   vagrant box add (vagrant_box)
   #添加box vagrant box网为vagrant box封装好的box镜像名称。
   #vagrant box add laravel/homestead
   #vagrant box add laravel/homestead --box-version=0.4.3
   #下载指定版本的系统镜像

3 vagrant init (box_name)
   #初始化 box_name 本地已安装的box名称

4 vagrant up  #启动虚拟机

5 vagrant ssh  #ssh登录虚拟机

6 vagrant halt  #关掉虚拟机

7 vagrant reload  #重启虚拟机

8 vagrant destroy  #销毁虚拟机

9 vagrant suspend  #虚拟机挂起

10 vagrant status   #查看虚拟机运行状态

11 vagrant box remove (boxname)  #删除指定的box环境

12 vagrant package   #对开发环境进行打包

13 vagrant resume   #重新恢复启动
```

> 当init 初始化 环境box后，会在当前目录中生成一个Vagrantfile配置文件。

## 5 配置环境网络

```bash
1 公有网络设置
 找到 # config.vm.network "public_network"
 去掉注释符 # 号：
 指定局域网ip:  config.vm.network "public_network", ip: "192.168.43.115"
 注：指定局域网ip时，先查看本地主机ip号段，如本地：192.168.43.229，配置192.168.43.*  如重启后提示ip占用，则换其它号段试试。

2 私有网络
找到 config.vm.network "private_network", ip: "192.168.100.100"
配置自己需要的私有ip
```

## 6 配置共享目录

```bash
默认Vagrantfile文件所在目录会跟虚拟机中根目录下的vagrant目录共享

设置其它目录
找到 # config.vm.synced_folder
去掉注释符 # 号，并设置需要同步的目录
如：
config.vm.synced_folder "/Users/flycorn/project", "/home/wwwroot/default",
create: true,  owner: "root",  group: "root"
第一个目录是指本地的目录，第二个目录是指虚拟机中的目录，create为true会在主机中自动创建该目录，owner目录所属者，group目录所属用户组。
```

## 7 环境打包

```bash
1 sudo rm -rf /etc/udev/rules.d/70-persistent-net.rules   #删除规则文件
2 vagrant package  #生成box文件
```

## 8 定义多主机

编辑Vagrantfile文件

```ruby
config.vm.box = "flycorn"

config.vm.define "development"  do  |development|
end      #定义开发环境主机名
config.vm.define "production"  do  |production|
end      #定义生产环境主机名
```

```bash
启动主机  vagrant  up  [主机名]
查看主机状态  vagrant  status  [主机名]
ssh指定登录某台主机   vagrant ssh development
```

## 9 多主机的网络设置

编辑Vagrantfile文件

```ruby
#配置私有网络
config.vm.define "development" do |development|
      development.vm.network "private_network", ip:"192.168.100.100"
  end
  config.vm.define "production" do |production|
      production.vm.network "private_network", ip:"192.168.100.101"
  end
```

重启主机

```bash
vagrant reload [主机名]
```

## 10 多主机的主机名

> Hostname 是一个用来设置或显示当前主机,域或者系统的节点名的程序.许多联网程序使用这些名字来标识机器.NIS/YP同样也使用域名.

现在两台主机的主机名都是localhost

```bash
vagrant ssh development
hostname 查看主机名
vim /etc/sysconfig/network 下面去修改, 或者在Vagrantfile里面去配置, 当启动以后,vagrant会自动的设置主机名。
```

```ruby
config.vm.define "development" do |development|
      development.vm.network "private_network", ip:"192.168.100.100"
      development.vm.hostname = "home-dev"
  end
  config.vm.define "production" do |production|
      production.vm.network "private_network", ip:"192.168.100.101"
      production.vm.hostname = "home-prod"
  end
```

```bash
vagrant reload vagrant ssh development hostname 查看发现是我们配置的
vagrant ssh production
hostname
可以看到HOSTNAME后面的值就是主机名, 可以直接修改这个值, 修改完了 service network restart就可以生效
cat /etc/sysconfig/network
```

## 11 多主机的共享目录

> 现在这两台主机都会有共同的同步目录, 也就是默认的都会使用项目的目录, 现在可以单独为第一台主机配置一个目录

```bash
mkdir development
mkdir production
```

```ruby
config.vm.define "development" do |development|
      development.vm.network "private_network", ip:"192.168.100.100"
      development.vm.hostname = "home-dev"
      development.vm.synced_folder "development", "/vagrant", create:true
  end
  config.vm.define "production" do |production|
      production.vm.network "private_network", ip:"192.168.100.101"
      production.vm.hostname = "home-prod"
      production.vm.synced_folder "production", "/vagrant", create:true
  end
```

> 问题
> 1 An error occurred while downloading the remote file. The error
> message, if any, is reproduced below. Please fix this error and try
> again.
> 2 The box 'laravel/homestead' could not be found or
> could not be accessed in the remote catalog. If this is a private
> box on HashiCorp's Atlas, please verify you're logged in via
> `vagrant login`. Also, please double-check the name. The expanded
> URL and error message are shown below:
> URL: ["[https://atlas.hashicorp.com/laravel/homestead](https://link.jianshu.com?t=https://atlas.hashicorp.com/laravel/homestead)"]
> Error:

> 解决办法：sudo rm /opt/vagrant/embedded/bin/curl

## 12 增加硬盘容量

> 一般box自带8g容量，对于一些特殊场景会不太够用。Virtualbox 本身只支持vdi硬盘文件格式的扩容，对vmdk 格式的却不支持。但是却提供vmdk到vdi格式的转化，正好可以利用这一功能进行扩容。

### 关闭虚拟机

```bash
vagrant halt
```

### 从Virtualbox管理面板上查看当前box的硬盘文件地址（选择虚拟机->右键->设置->存储->SATA Controller下对应磁盘）。进入文件所在目录内执行：

```bash
VBoxManage clonehd box-disk1.vmdk box-disk1.vdi --format VDI
```

### 给vdi格式硬盘文件扩容

```bash
VBoxManage modifyhd box-disk1.vdi --resize 20000
```

### 从Virtualbox存储界面上删除原硬盘文件，然后加入新的 vdi 格式硬盘文件

```bash
如：删除box-disk1.vmdk 添加box-disk1.vdi
```

### vagrant up 启动虚拟机，然后 vagrant ssh 进入

### 利用 cfdisk 工具创建主分区，谨记选择格式为Linux LVM (8e)

```bash
sudo cfdisk /dev/sda
```

### 重启udev守护进程

```bash
sudo udevadm trigger
```

### 查看分区

```bash
cat /proc/partitions

如没有出现新建的分区重启虚拟机：
vagrant reload
```

### 利用 pvcreate 命令给新的分区创建物理卷

```bash
sudo pvcreate /dev/sda3
```

### 查看VG Name

```bash
sudo pvdisplay | grep "VG Name"

如：VolGroup
```

### 将新分区扩展到 VolGroup 组下

```bash
vgextend VolGroup /dev/sda3
```

### 扩展逻辑分区

```bash
lvextend /dev/mapper/VolGroup-lv_root/dev/sda3
```

### resize生效

```bash
resize2fs /dev/mapper/VolGroup-lv_root
```

### 在centos 7下，这一步会出错

```bash
resize2fs 1.42.9 (28-Dec-2013)
resize2fs: Bad magic number in super-block while trying to open /dev/mapper/VolGroup-lv_root
Couldn't find valid filesystem superblock.

----------------------------------------------------------------------------------------------

执行xfs_growfs命令替换
xfs_grouwfs /dev/mapper/VolGroup-lv_root
```

### 重启成功

```bash
vagrant reload
```
