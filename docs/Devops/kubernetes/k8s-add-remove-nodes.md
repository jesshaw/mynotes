# 添加删除节点

## 删掉节点

> `注意`：以下操作都是在`master`下操作。

1. 先将节点设置为维护模式(k8snode2是节点名称)

    ```bash
    kubectl drain kworker4 --delete-local-data --force --ignore-daemonsets
    ```

2. 删除节点

    ```bash
    kubectl delete node kworker4
    ```

3. 确认是否已经删除

    ```bash
    kubectl get nodes
    ```

## 生成永久Token

生成永久token存入joincluster.sh文件

```bash
kubeadm token create --ttl 0 --print-join-command > /joincluster.sh
# 查看Token确认
kubeadm token list
```

## node重新加入

> `注意`:以下操作在node下操作

1. 停掉kubelet

    ```bash
    systemctl stop kubelet
    ```

2. 删除之前的相关文件

    ```bash
    rm -rf /etc/kubernetes/*
    ```

3. 加入集群

```bash
#拷贝加入文件并执行
sshpass -p "*****" scp -o StrictHostKeyChecking=no kmaster.example.com:/joincluster.sh /joincluster.sh
bash /joincluster.sh
```

> 注意：如果你没有另创建Token，也许会报类似以下错：
> `error execution phase preflight: [preflight] Some fatal errors occurred: [ERROR FileAvailable--etc-kubernetes-kubelet.conf]: /etc/kubernetes/kubelet.conf already exists [ERROR FileAvailable--etc-kubernetes-bootstrap-kubelet.conf]: /etc/kubernetes/bootstrap-kubelet.conf already exists [ERROR Port-10250]: Port 10250 is in use [ERROR FileAvailable--etc-kubernetes-pki-ca.crt]: /etc/kubernetes/pki/ca.crt already exists [preflight] If you know what you are doing, you can make a check non-fatal with`--ignore-preflight-errors=... ``
>
> > 所以建议建立一个永久的，当然如果考虑到安全那么就需要每一次加入之前重新创建一个临时的Token.

> 解决了一个报错，这不又来了一个报错，如以下报错代码：
> `error execution phase preflight: unable to fetch the kubeadm-config ConfigMap: failed to get config map: Unauthorized`
>
> > 如遇到此报错也不要急，接着在node上敲两行代码即可，如下操作：

```bash
kubeadm reset
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
```

`操作完后再次执行加入集群命令即可。`

</article>
## 参考

- [安全地清空一个节点](https://kubernetes.io/zh/docs/tasks/administer-cluster/safely-drain-node/)
- [创建随机令牌](https://kubernetes.io/zh/docs/reference/setup-tools/kubeadm/kubeadm-token/)
