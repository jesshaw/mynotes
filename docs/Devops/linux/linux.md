# linux

## wsl公钥免密登录设置

1. 生成公私钥对

    ```bash
    ssh-keygen -t rsa
    ```

1. 复制公钥到服务器

    ```bash
    # 切记复制时复制完整
    vi ~/.ssh/authorized_keys
    ```

1. 设置服务器允许公钥登录

    ```bash
    vi /etc/ssh/sshd_config
    # 打开如下配置
    RSAAuthentication yes
    PubkeyAuthentication yes
    AuthorizedKeyFiles .ssh/authorized_keys
    #重启ssh服务
    systemctl restart sshd.service
    ```

1. 验证

    ```bash
    ssh root@10.0.5.158
    ```

## 私有内网的linux如何获取出口公网地址方法

```bash
curl http://members.3322.org/dyndns/getip
```
