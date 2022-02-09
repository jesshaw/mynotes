# 挂载共享文件夹

## 增加用户权限

因VirtualBox默认自动挂载的文件夹是vboxsf用户组，因此需要访问的用户加到访问组

```bash
sudo usermod -a -G vboxsf $USER
```

## 参考

[How to mount a shared folder in VirtualBox](https://www.pragmaticlinux.com/2021/02/how-to-mount-a-shared-folder-in-virtualbox/)
