# helm常用命令

## helm search

- helm search hub 从 Artifact Hub 中查找并列出 helm charts。
- helm search repo 从你添加（使用 helm repo add）到本地 helm 客户端中的仓库中进行查找

```bash
# 从 Artifact Hub 中查找并列出 helm charts
helm search hub mysql
# 搜索指定仓库的所有chart
helm search repo brigade

# 模糊搜索kash的所有chart
helm search repo kash


 # 模糊搜索kash的所有chart的所有版本
 helm search repo memcached -l 

# helm安装包下载存放位置
/root/.helm/cache/archive
```

## helm install

```bash
## 安装release版本
helm install happy-panda bitnami/wordpress
## 查看release的状态
helm status happy-panda
## 检测渲染过的模板，调试，试运行查看生成的yaml
helm install mydemo mychart/ --debug --dry-run
## 查看安装后已经加载实际的版本
helm get manifest mydemo
```

### 安装前自定义chart

安装过程中有两种方式传递配置数据：

--values (或 -f)：使用 YAML 文件覆盖配置。可以指定多次，优先使用最右边的文件。
--set：通过命令行的方式对指定项进行覆盖。

同时存在会合并，但--set优先级更高

在--set 中覆盖的内容会被被保存在 ConfigMap 中。可以通过 helm get values <release-name> 来查看指定 release 中 --set 设置的值。也可以通过运行 helm upgrade 并指定 --reset-values 字段来清除 --set 中设置的值。

[set设置语法参考](https://helm.sh/zh/docs/intro/using_helm/)

```bash
## 查看chart中的可配置选项
helm show values bitnami/wordpress
## 指定values运行
helm install -f values.yaml bitnami/wordpress --generate-name
## 对指定chart进行语法检测
helm lint CHART_PATH
## 下载一个chart的release并解压
helm pull bitnami/wordpress --untar
```

helm install 命令可以从多个来源进行安装：

- chart 的仓库（如上所述）
- 本地 chart 压缩包（helm install foo foo-0.1.1.tgz）
- 解压后的 chart 目录（helm install foo path/to/foo）
- 完整的 URL（helm install foo https://example.com/charts/foo-1.2.3.tgz）

## helm upgrade 和 helm rollback

```bash
## happy-panda 这个 release 使用相同的 chart 进行升级，但是使用了一个新的 YAML 文件
$ helm upgrade -f panda.yaml happy-panda bitnami/wordpress
## 看配置值是否真的生效
$ hel get values happy-panda
## helm rollback [RELEASE] [REVISION] 命令回滚到之前的发布版本
$ helm rollback happy-panda 1
## 可以使用 helm history [RELEASE] 命令来查看一个特定 release 的修订版本号
```

## helm uninstall

```bash
## 从集群中卸载一个 release
$ helm uninstall happy-panda
## 当前部署的所有 release
$ helm list
## 保留删除记录的方式卸载
$ helm uninstall --keep-history
## 展示使用了 --keep-history 删除的 release
$ helm list --uninstalled
## 展示 Helm 保留的所有 release 记录
$ helm list --all
```

## helm repo

```bash
## 查看helm仓库列表
$ helm repo list
NAME      URL
stable    https://kubernetes-charts.storage.googleapis.com
mumoshu   https://mumoshu.github.io/charts
local     http://127.0.0.1:8879/charts


## 添加bitnami仓
helm repo add bitnami https://charts.bitnami.com/bitnami

## 更新仓库
$ helm repo update

## 删除仓库
helm repo remove stable

## helm 镜像
helm repo add stable https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

```

## 创建自己的charts

```bash
## 创建deis-workflow的charts
$ helm create deis-workflow
## 将 chart 打包分发
$ helm package deis-workflow
## 通过 helm install 命令安装
$ helm install deis-workflow ./deis-workflow-0.1.0.tgz
```

create：根据给定的name创建一个新chart
fetch：从仓库下载chart，并(可选项)将其解压缩到本地目录中
inspect：chart详情
package：打包chart目录到一个chart归档
lint：语法检测
verify：验证位于给定路径的chart已被签名且有效

## 参考

[helm使用](https://cloud.tencent.com/developer/article/1764065)
[helm常用命令详解](https://zhuanlan.zhihu.com/p/104234010)
[helm创建Chart入门](https://helm.sh/zh/docs/chart_template_guide/getting_started/)
