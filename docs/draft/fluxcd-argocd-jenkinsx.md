[GitOps](http://dockone.io/topic/GitOps) [Git](http://dockone.io/topic/Git) [Jenkins X](http://dockone.io/topic/Jenkins+X) [Kubernetes](http://dockone.io/topic/Kubernetes)

FluxCD、ArgoCD或Jenkins X，哪个才是适合你的GitOps工具？
=========================================

GitOps是一种使用基于Git的工作流程来全面管理应用和基础设施的想法，其在最近获得了极大关注。新一代的部署工具更能说明这一点，它们将GitOps作为持续交付的主要组织原则。

本文中我们将研究的工具有FluxCD、ArgoCD和Jenkins X，它们都专注于将应用部署到Kubernetes集群中。

目前，业界对于选择哪种工具以及它们与通用的CI/CD工具（如Jenkins、GitLab CI或GitHub Actions）之间的关系有很多困惑。虽然这些其他工具在实现通用管道和工作流来构建、测试、发布和部署应用的过程中都做得很好，但在这次评估中，我们选择了以下三种工具，它们基于Git仓库中的更改，实现GitOps风格的应用程序部署，做到开箱即用。

### GitOps快速入门

GitOps这个术语是由Weaveworks的Alexis Richardson在一篇名为《[Operation by Pull Request](https://www.weave.works/blog/gitops-operations-by-pull-request)》的博文中创造的。其基本思想是通过向Git提交变更并使用Pull Request（以下简称PR）进行审批来管理Kubernetes上的资源。

如果听起来有点模糊，那么我们来定义一下GitOps的四条规则，让它更接地气。

1.  将所有Kubernetes资源配置存储在Git中。
2.  只使用PR来修改该Git仓库上的资源。
3.  一旦修改了Git，立即将更改应用到集群中，并且完全自动化。
4.  如果实际状态与所需的状态有偏差，要么纠正它，要么提醒操作人员。

当我们把这些结合起来，我们就会得到一个系统，在这个系统中，所有对应用环境的更改都会被记录下来，我们可以应用我们基于Git的工具来管理历史记录。我们还可以通过使用PR来进行审批。

在架构上，GitOps将允许我们将应用的持续集成（CI）流程与部署流程分开，因为部署流程将根据环境仓库的变化而不是作为CI流程的一部分来启动。[点击](https://blog.container-solutions.com/enterprise-grade-ci-cd-with-gitops)了解关于GitOps和CI/CD的更多信息。

### FluxCD

[Flux](https://fluxcd.io/)被描述为Kubernetes的GitOps运维工具，它可以将Git仓库中的清单状态与集群中运行的内容同步。在本次评测的三个工具中，它是最简单的一个。事实上，只需几步就可以设置好一个GitOps工作流，这一点让人惊叹不已。

这个工具运行在集群中，更新会被应用到集群中，它的主要功能是监视远程Git仓库来应用Kubernetes清单中的更改。它最初是由Weaveworks开发的，现在是在[GitHub](https://github.com/fluxcd/flux)上使用Apache 2.0许可的CNCF项目。

该工具专注于软件交付周期中的部署部分，专门针对Git仓库和容器注册表与集群中的工作负载的版本和状态同步，因此该工具易于安装和维护。

它可以在每个安装中只监视一个远程仓库，而且它只能在其底层服务账户（serviceaccount）有权限更改的命名空间中应用更改。虽然乍一看很有局限性，但更复杂的场景，如果有多个团队和自己的Git仓库和目标部署环境，则可以设置相应数量的Flux实例，每个实例都有自己特定的RBAC权限。
[![1.png](http://dockone.io/uploads/article/20200518/fc2f111bacbb92711a301829779864dc.png "1.png")](http://dockone.io/uploads/article/20200518/fc2f111bacbb92711a301829779864dc.png)

#### 安装

Flux安装跟在集群中部署任何其他典型Pod一样容易。它正式支持基于[Helm Charts](https://docs.fluxcd.io/en/1.19.0/tutorials/get-started-helm/)和[Kustomize](https://docs.fluxcd.io/en/1.19.0/tutorials/get-started-kustomize/)的安装。此外，还有一个`fluxctl`的命令行（CLI）工具，以二进制形式发布，可帮助安装过程并与集群中正在运行的Flux守护程序进行交互以执行一些管理任务。

在集群中安装Flux的最简单的方法是应用少量清单文件，可以使用`fluxctl install`命令并添加适当的参数生成，包括将被监视的Git仓库的URL。

#### GitOps部署

作为Flux的主要功能，它会定期拉取远程Git仓库，并以真正的GitOps方式将其清单文件（如果有新更改）应用于集群。这可以用于部署应用程序，也可以维护Kubernetes清单形式的任何种类的集群配置。同步也可以通过`fluxctl sync`命令手动触发。

#### 管理

从群集管理员的角度来看，考虑到Flux实际上是在Pod中部署的单个二进制文件，安装后几乎不需要管理。可以通过将相同的清单重新应用新的值来更改配置或升级到较新的版本，或者仅在安装时使用Kustomize或Helm进行更改。

除了安装之外，`fluxctl`命令行工具还可以帮助完成其他一些任务，例如立即触发同步或列出集群中部署的相关配置和工作负载。

#### 多租户

由于对远程Git仓库和目标命名空间的结构假设很少，所以Flux没有多租户模式。

作为一个简单的组件，我们可以在同一个集群中使用不同的Flux实例，每一个实例都可以监视不同的远程Git仓库，并在不同的目标命名空间中同步它们的变化。这种可能性可以让不同的团队拥有自己的Git仓库。

话虽如此，但要由团队来选择Git仓库的布局，以及如何在集群中用命名空间代表的应用程序和目标环境进行映射，这都是由团队来决定的。为了提供团队之间的隔离，可以使用不同的Git仓库，因此可以使用不同的Flux实例来监视每一个Git仓库。

虽然在集群中运行多个Flux实例可能会增加一些管理开销，但它可以让团队管理自己的环境仓库，并拥有适当的权限来提交更改和批准PR。此外它还可以在命名空间之间实现一定程度的隔离，为集群中不同的Flux实例使用的每个服务账户提供更具体的RBAC设置。

#### 多集群

基于同样的原因（简单性），Flux可以用于多集群场景。不同的集群会有自己的Flux实例来监视远程仓库中的变化。考虑到可以在一个仓库中指定一个要监视的目录，团队有同样的灵活性来选择多集群情况下的最佳版本库布局。一个单一的版本库可以由两个或多个来自不同集群的Flux实例来监视，每一个都监视一个特定的目录，也可以使用单独的版本库。

#### 附加功能

**自动部署新版本容器镜像**

当新版本的容器镜像可用时，Flux可以选择更新集群中的工作负载。如果启用，运行`fluxctl automate`或者在工作负载的部署清单中添加注释，它会轮询注册表中的镜像元数据，并且如果有指定镜像的新版本可用，它可以使用新的版本来更新部署。当这样做时，Flux会写一个提交回原始Git仓库，以更新清单中使用的镜像版本，因此Git仍然是集群中运行的内容的真实来源。

**重新应用偏移的资源**

不管来自Git仓库的新更该如何，Flux都会在一定间隔内同步重新应用其清单的工作负载状态。这在GitOps工作流之外的应用程序和配置状态发生变化时非常有用。

**垃圾回收**

当资源从环境仓库中被删除时，Flux可以将其从集群中删除。这种潜在的危险操作需要跟踪GitOps工作流程已创建了哪些资源。

当启用此功能后，Flux将根据源（仓库URL、分支和安装过程中指定的路径组合），在同步循环期间给集群中部署的所有资源贴上特定的标签。当涉及到垃圾回收循环时，Flux将查询APIServer，以检索所有标记为来自源的对象，并删除那些在上一阶段没有同步的对象。

#### 局限性

Flux最大的局限，可能是设计上的，也是它最大的优势。它只支持一个单一的仓库。这个特性使它成为一个相当简单的工具，易于理解和故障排除。考虑到它运行在轻量级部署上，这个限制可以通过集群中的多个实例来克服，正如前面的"多租户"部分所描述的那样。

#### 结论：我应该使用FluxCD吗？

根据设计，Flux仅专注于将清单部署到群集。因此，你仍然需要CI工具来构建和测试你的应用程序，并在最后将你的容器镜像推送到注册表。另一方面，CI工具不需要访问群集，因为Flux会从内部周期性地拉取变化，最大限度地减少了群集的暴露。

从团队组织的角度来看，没有内置的多租户支持。如果要使用单一的Flux守护进程，团队应该就如何组织单一的Git仓库达成一致。话虽如此，如果你正在寻找一个简单而轻量级的工具来自动化Kubernetes部署的解决方案，那么Flux是个不错的选择。

### ArgoCD

ArgoCD是用于Kubernetes的声明性GitOps持续交付（CD）工具。该功能集虽然侧重于应用程序部署的管理，但是却非常出色，涵盖了多个同步选项，用户访问控制，状态检查等。它自2018年以来由Intuit开发，并根据Apache 2.0许可证在[GithHub](https://github.com/argoproj/argo-cd)上开源。

在GitOps风格上，部署从ArgoCD跟踪的Git仓库中的应用程序清单更改开始，类似于Flux的工作方式。但是，让它大放异彩的是其具有通过精细控制来管理多租户和多集群部署的功能。它可以将不同团队的多个应用程序同步到一个或多个Kubernetes集群。此外，它具有漂亮的现代Web UI，用户可以在其中查看其应用程序部署的状态，管理员可以管理项目和用户访问权限。
[![2.png](http://dockone.io/uploads/article/20200518/c099b326cc317512fc8ad6d4d31783a8.png "2.png")](http://dockone.io/uploads/article/20200518/c099b326cc317512fc8ad6d4d31783a8.png)

#### 安装与管理

ArgoCD完全以Kubernetes原生方式安装和管理。它在Kubernetes上在自己的命名空间中运行，所有的配置都存储在ConfigMaps、Secrets和Custom Resources中。这使得我们可以使用GitOps工作流程来管理ArgoCD本身。

#### 支持的清单格式

ArgoCD在GitOps仓库中提供了对不同格式的最广泛支持。根据文档，它可以处理：

1.  Kustomize应用程序
2.  Helm Charts
3.  Ksonnet应用
4.  YAML/JSON清单目录，包含Jsonnet
5.  配置管理插件配置的任何自定义配置管理工具

#### 特性

当涉及诸如多租户的重要功能时，ArgoCD确实令人眼前一亮，但它也具有众多的自定义选项。

**多租户**

一个ArgoCD实例可以处理不同团队的许多应用程序。它使用项目的概念进行此操作。项目可以容纳多个应用程序，并映射到一个团队。团队成员将仅能看到分配给他们的项目，并且通过扩展仅看到那些项目中的应用程序。这种模式与Kubernetes中的命名空间中的资源非常相似。

**多集群**

ArgoCD可以在其运行的Kubernetes集群上同步应用程序，也可以管理外部集群。它也可以被配置为只访问一组受限的命名空间。

其他群集的API服务器的凭证会作为秘密存储在ArgoCD的命名空间中。只要你可以远程公开其他集群的API，这对于从一个地方管理所有部署都是非常有用的功能。内置的RBAC机制提供了一些选项，以控制仅特定用户对不同环境中的部署的访问。

**配置偏移检测**

当集群的操作员在不经过GitOps工作流程（即提交到Git）的情况下更改资源时，Kubernetes资源可能会偏离存储在Git中的配置。这在GitOps中是一个问题，因为很容易发生这些变化，使Git中的状态过期。ArgoCD可以检测到这些更改并将其还原，从而使状态恢复到Git中定义的状态。

**垃圾回收**

删除资源是GitOps的另一个问题。当从Git中删除诸如部署之类的资源时，`kubectl apply`将忽略它（除非使用实验性的`--prune`标志）。这使得开发人员无法删除他们创建的资源，因为它们与Kubernetes的接口是Git仓库。Helm确实解决了这个问题，但ArgoCD也是如此。它可以在自己的同步过程中删除过时的资源，所以你不必使用Helm来实现这个功能。

#### 局限性

尽管我们喜欢ArgoCD可以一站式管理所有团队的部署这一事实，但我们并不喜欢你如何配置项目与团队的映射。基本上，团队所属项目的整个配置都保存在存储ArgoCD配置的Git仓库中的单个文件中。这意味着，每次创建或修改新团队时，都必须更新此文件。在大公司里，开发团队的组建和解散都是在不断地进行，这种管理方式可能会变得很繁琐，也限制了ArgoCD提供的多租户设置。

#### 结论：我该使用ArgoCD吗？

ArgoCD给人的感觉就像Flux的老大哥。它是一个功能丰富的工具，与Kubernetes的集成完美无瑕。我们非常喜欢这样一个事实：尽管它有很多功能，但它的功能范围非常明确，就是它可以将Git仓库中的清单同步到集群中。

和Flux一样，ArgoCD不会帮助你测试你的应用程序或构建Docker镜像。你可以继续使用你现有的CI工具来实现。但是，如果你想部署到其他目标集群的话，ArgoCD需要访问权限。

在任何一家大公司里，多租户都是非常方便的。当你没有它的时候，你将不得不以某种形式或以某种形式自行滚动，所以ArgoCD的头等支持是非常受欢迎的。如果你想从多个应用程序中管理部署，并对用户的访问权限和清单同步设置进行精细控制，ArgoCD看起来是个不错的选择。

### Jenkins X

[Jenkins X](https://jenkins-x.io/)是一个围绕GitOps构建的完整的CI/CD解决方案，其底层使用了Tekton。首先，从名称来看，我们希望看到大家都了解到的Jenkins的下一代，包含其任务和插件功能。实际上，Jenkins X采取了不同的方向，与经典的Jenkins几乎没有共同点。

它抛开了Jenkins的master-worker节点架构，并以成为Kubernetes原生CI/CD引擎打造。它在GitHub上以Apache 2.0许可下开源，由Cloudbees开发，该公司还提供了商业发行版。

值得注意的是，除了基于GitOps的部署功能外，Jenkins X还涵盖了更广泛的开发周期，包括来自典型CI管道的构建和测试阶段，以及容器镜像的构建和存储。为此，它将一组令人印象深刻的云原生项目捆绑并配置在一起，从而实现了现代化的开发工作流程。

Jenkins X将设置[Skaffold](https://skaffold.dev/)和[Kaniko](https://cloud.google.com/blog/products/gcp/introducing-kaniko-build-container-images-in-kubernetes-and-google-container-builder-even-without-root-access)来构建容器图像，并使用[Helm](https://helm.sh/)图表来打包Kubernetes清单。在内部，它使用[Tekton](https://github.com/tektoncd/pipeline)运行管道，并使用[Lighthouse](https://github.com/jenkins-x/lighthouse)与你选择的Git提供程序集成（例如GitHub），并在PR线程中启用丰富的交互。
[![3.png](http://dockone.io/uploads/article/20200518/61f9fe8b1037e6d2582dccab90c85169.png "3.png")](http://dockone.io/uploads/article/20200518/61f9fe8b1037e6d2582dccab90c85169.png)

#### 安装

安装必须使用`jx boot`命令完成，并且假定用户具有对Kubernetes群集的广泛权限，足以创建名称空间，CRD，设置sa以及创建GCP资源（如Cloud Storage存储桶）。

在这个过程的开始，[启动配置库](https://github.com/jenkins-x/jenkins-x-boot-config)将被克隆，并提示用户接受或更改一些默认选项，并提供将在PR线程中用作机器人的GitHub用户的凭据。

默认情况下，在GitHub中提供了三个Git仓库以保持集群中环境的状态：dev、staging和production。dev环境（从引导配置仓库中克隆出来的）是工具运行的地方。staging环境和production环境是用户应用程序部署时运行的环境。每个环境在集群中都有自己的命名空间和Git仓库。

在我们评估Jenkins X的时候，这有一个[讨论](https://github.com/jenkins-x/enhancements/tree/73680a633427f31411886db4baa1f6cd0d1d466e/proposals/2/docs)关于如何让引导安装过程中使用Helm 3和[helmfile](https://github.com/roboll/helmfile)。

#### GitOps部署

鉴于应用仓库中合并到master后的应用构建成功后，会创建一个新的应用Helm图的发布版本。要将这个新版本部署到其中一个环境中，需要更新相应的环境仓库。例如，要部署到生产环境中，需要更新代表生产环境的Git仓库。

遵循GitOps原则，环境仓库中的这种变化会触发部署管道，使用Tekton将仓库中描述的内容与集群中正在运行的内容同步。部署过程也可以通过`jx promote`命令启动，该命令将更新环境仓库，从而触发同步。

#### 管理

安装完成后，可以通过更新dev环境仓库中的配置文件来调整内部的一些配置。当更改提交并推送后，会触发一个流水线，Jenkins X会在其中读取配置并自行更新。此外，Jenkins X本身就是由GitOps工作流来管理的。

#### 多租户

考虑到Jenkins X集群中来自不同团队的应用程序之间没有特别的隔离，因此不支持多租户。用户和应用程序都将共享相同的内部资源和组件，以及同一套环境。尽管存在团队的概念，并由`jx team`子命令支持，但这是一个半生不熟的解决方案，基本上是复制粘贴整个Jenkins X的部署。

#### 多集群

应用程序环境（例如staging和production）可以在其他集群中运行（点击查看[文档](https://jenkins-x.io/docs/reference/multi-cluster/)）。这是Jenkins X中的一个新功能，被忽视了太久了。这种忽视的后果是，现在有不同的解决方案，有不同的弊端，看来我们还得再等一段时间才能找到最终的解决方案。

#### 功能特性Features

Jenkins X自带了大量独特的功能，使得开发者的体验比其他两个工具更加流畅和完善。

**快速入门新项目**

对于新项目，`jx quickstart`命令可以帮助创建一个新的Git仓库，其中包含带有Helm图表的应用程序框架，以及使用[Skaffold](https://skaffold.dev/)构建Docker镜像的预定义构建管道。它还在GitHub中配置了Git仓库，在分支中的新提交和PR之后设置了一个Webhook来触发构建和其他操作。可以使用`jx import`命令配置现有项目，这将有助于创建Dockerfile和Helm图表（如果尚不存在），并设置适当的webhooks。

**配置Git仓库**

使用提供的GitHub用户凭据，在安装过程中，将在选定组织的GitHub中或作为用户仓库创建环境仓库（dev，staging和production）。同样，对于上面提到的新的快速入门项目，也会提供一个Git仓库与应用框架。

**构建流水线**

Jenkins X支持在应用程序仓库中发生事件后触发任务管道。例如，为新的分支或请求请求构建应用程序并运行测试。在所谓的构建包（buildpacks）中有针对不同编程语言和框架的默认构建管道。应用程序需有一个指向其父构建包的`jenkins-x.yaml`文件，并且可以自定义管道。

**ChatOps**

[ChatOps](https://www.pagerduty.com/blog/what-is-chatops/)是用于在聊天线程中管理开发和操作活动的术语，通常在机器人用户的支持下执行一些自动或请求的操作。在Jenkins X中，在应用程序或环境仓库中创建的新PR将触发运行管道。管道步骤的结果由bot（安装过程中配置的GitHub用户）发布到PR线程中。用户可以与机器人进行交互，以请求其他任务，例如重新运行测试，或批准并合并PR。

为了集成Webhook，触发器和事件，Jenkins X在内部使用[Prow](https://github.com/kubernetes/test-infra/tree/master/prow)，该工具最初是为GitHub中的Kubernetes项目运行构建的。另外，Jenkins X团队正在开发[Lighthouse](https://github.com/jenkins-x/lighthouse)，以提供类似的功能，但扩展了对不同的Git提供程序（如BitBucket和GitLab）的支持。

**预览环境**

成功构建后，例如在Jenkins X配置的应用程序仓库中新创建的PR中，将为当前构建创建临时预览部署。使用此预览，可以在合并到master之前手动检查作为PR提交的当前更改。

#### 局限性

虽然其他两个工具的范围比Jenkins X要小得多，但它们能完美地实现它们所说的功能。另一方面，Jenkins X是一个复杂的全方位解决方案，这就给人们设定了不同的期望。最显著的缺失的功能是多租户功能。当Jenkins X被安装到一个集群上时，我们会期望它能够服务于所有团队。遗憾的是，Jenkins X的多租户模式可以与Flux的多租户模式进行比较，虽然后者是一个简单的工具，但Jenkins X安装了大量的组件，我当然不希望每个团队都重复安装。

#### 结论：我应该使用Jenkins X吗？

Jenkins X是一个雄心勃勃的项目，涵盖了广泛的应用程序开发，将CI和CD放在一个软件包中。这是开箱即用的强大功能，因此不再需要其他CI工具。但是，现有项目可能必须适应新的工具链，才能利用在推送到分支和PR后触发任务（构建，测试和其他作业）。

该项目正在积极开发中，且发展速度令人印象深刻。我们很高兴看到jx CLI的可用性得到了改进，Web UI中的状态和项目概述有所改善，并且在如此短的时间内增加了新功能。另一方面，鉴于功能的范围很广，可能需要一些时间来理解所有概念并熟悉其内部组件，以防需要调整一些默认选项。

如果你想要一个基于Git的现代开发和部署工作流程，在PR中加入丰富的ChatOps交互，就像Kubernetes和GitHub中的其他开源项目一样，不需要自己拼凑出一整套独立的工具和配置，那么Jenkins X绝对是一个不错的选择。在云原生领域非常需要这种超级工具，因为并非每个公司都有时间和资源来利用整个范围广泛的不同工具来进行整合组装工作。

采用Jenkins X的最大挑战是，很难知道它是解决公司所有CI/CD需求的完美解决方案，还是一个过于复杂的怪兽，它最初会带来一些快速的胜利，但在未来的发展中会成为一个障碍。解决这个难题的唯一方法就是让Jenkins X完善其功能，以至于任何公司都可以采用Jenkins X，因为大家都知道它就是那个正确的工具。

### 结论

[![4.png](http://dockone.io/uploads/article/20200518/be35abbb0e5714927d7c408db8d68781.png "4.png")](http://dockone.io/uploads/article/20200518/be35abbb0e5714927d7c408db8d68781.png)

-   Flux可作为多用户设置中的一个构件使用。
-   Jenkins X正在努力实现在单个实例中支持多个团队。
-   ArgoCD可以将更新发送到Slack以及其他工具但是不能通过这些工具控制它（而且实际上也并非必要）。

我们相信，Flux、ArgoCD和Jenkins X这三个项目都有非常有趣和强大的功能来管理Kubernetes中的部署，但每个项目都有其优点和缺点，应该根据你的具体案例进行评估。这些工具其实并不是相互竞争，相反，它们的目的是为了实现不同的用例。

Flux是一个小型、轻量级的组件，可以实现基于GitOps的部署，可能会对你当前的设置进行互补。它只需要访问一个（也只有一个）Git仓库，并且可以在有限的RBAC权限下运行。

ArgoCD可以管理不同集群中多个应用程序的部署。它在集群内运行，但也可以管理团队和项目的访问权限和权限。它有一个流畅的Web界面来管理应用程序和项目，并提供了一套不错的功能来管理部署。

就像你在现代开源项目中所期望的那样，Jenkins X捆绑了一些有争议的工具来构建一个围绕GitHub仓库的开发工作流（很快就会支持其他供应商）。它运行CI管道来构建和运行应用程序的测试，在PR中提供丰富的交互，并根据Git仓库中的变化管理部署。

**原文链接：[FluxCD, ArgoCD or Jenkins X: Which Is the Right GitOps Tool for You?](https://blog.container-solutions.com/fluxcd-argocd-or-jenkins-x-which-is-the-right-gitops-tool-for-you)（翻译：冯旭松）**[**0**](javascript:;)<a class="text-color-999 dropdown-toggle" data-toggle="dropdown">分享</a>
