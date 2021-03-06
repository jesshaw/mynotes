# CTO职责

CTO 是企业内技术最高负责人，对企业的发展起到至关重要的作用。但随着公司的不断发展，CTO 的工作重心也会不断变化。只有在正确的阶段做正确的事，才能更好地为公司做出贡献。
假设一个公司发展有以下几个阶段：

- 0 ：创始阶段；
- 0.5 ：有产品但无管理阶段；
- 1 ：经过几年的发展初步稳定的阶段；
- 1+ ：稳步发展阶段。

初创公司 CTO 或者技术负责人，最重要的目标是在最短时间内用有限的预算打造合适的团队把项目做起来。

## 从 0 开始的情况

从 0 开始指的是：你是公司第一个技术人员，你需要从 0 开始搭团队。最初，你需要做如下几项工作：

### 预算和组织

评估项目第一版在规定时间内上线需要多少人的技术团队，是否需要分产品线，规划出不同岗位的人数。比如，项目经理 1 人、前端 2 人、后端 5 人、客户端 2 人、UI 设计 2 人、产品经理 2 人、测试 3 人、运维 2 人等等。然后根据技术团队的规模预估人员成本，以及做服务器、软硬件的预算，把这些预算和整个公司的预算放到一起评估，看是否可行。如果可行，立即全面开启人员招聘。如果初期人数不超过 20 人，不需要特别复杂的组织架构，所有人直接向你一人汇报也可以。在项目执行过程中，项目经理甚至是产品经理可以帮你负责一部分管理工作。在初期，虽然彻底扁平化的架构会很累，但有助于提高效率和执行力。

### 人员和招聘

对于一般做产品的初创公司而言，业务量不大，不需要高端人才，需要的是踏实肯干、愿意拼搏、愿意与公司一起成长的具有相同价值观的人才。公司初创阶段各岗位需要大量招人，选择合适的面试方式和面试难度非常重要。我会通过笔试初筛，以节省时间，避免和不合适的面试者礼节性聊天。
我的笔试有两个特点：
1、可以开卷
我不反对现场拿手机查资料，但是因为笔试时间固定，现场查资料往往意义不大。第一，我的笔试题不是网上搜的，没有现成的答案；第二，大部分内容考察的都是技术细节或对技术的整体理解。如果面试者之前不理解或是没有经验，临时抱佛脚用处不大。
2、笔试考察的知识面是比较全面的
比如，后端的面试题涉及到语言基础、算法、SQL 、虚拟机、Linux 、架构设计、设计模式、框架等分类，难度比较高。30% 的面试者在看到笔试题后会选择放弃，其实只要是认真回答问题的，哪怕只答出 40% ，我也会安排面聊。我只是希望通过难度较高的面试题刷去一些心里不那么强大的面试者。
在招聘淡季，我会要求人事广撒网进行笔试，因为确实遇到过一些工作经历不那么出色，但技术基础特别扎实的面试者，如果简历初筛淘汰了这样的面试者是比较可惜的。笔试之后的面聊会针对笔试的问题展开讨论，并且要求面试者介绍之前的项目经验、学习方式以及对技术的追求。
面试是搭团队最重要的一个环节，搭团队是技术管理者最重要的事情之一，怎么强调面试的重要性都不过分。最好在最初能招到几个优秀的人作为核心成员，这样可以让他们来分担一些面试工作，让自己有时间做其他的事情。初创团队的人员必须个个是精英，比如，一个只有 3 个人的前端团队，其中 1 个人很平庸，那么你的前端团队就有 33% 的人是很平庸的。如果因此前端成了短板，那么 1 人的问题就极大限制了整个技术团队的效率和产品质量。

### 项目和产品

在招聘的同时应该抽时间来制定项目计划，如果技术管理者不熟悉业务，需要先做功课熟悉产品的业务形态，这样才可以评估产品的技术难度和工作量，以便做出合适的计划。有了明确的研发计划，公司的运营、业务部门才能根据这个计划做相应的推广运营计划。
除了计划，需要先用脑图把核心业务的领域、模块、功能梳理出来，和管理层一起把产品形态讨论清楚，然后在产品研发内部宣讲，让大家对产品的目标达成共识。在初期，产品可以根据这个方向来细化形成产品文档，技术可以根据这个方向来调研需要的技术。

### 技术和架构

技术架构方面有几点非常重要：

#### 语言

开发语言是招聘之前就应该确定的。一般而言，技术管理者会选择自己熟悉的语言作为项目最初的核心语言。对于业务型项目，采用 Java 或 Python 这种普适性语言；对于纯高并发的服务端项目考虑 Go ；对于 Windows 项目或企业级项目考虑 .Net ，按照这个方向来做不会出大错。我不太建议在初期融入太多语言，或许不同语言的结合可以发挥出性能和开发效率的优势。但在初期就混用会增加管理成本，提高基础框架的开发难度，而且每一种语言的开发都需要学习和成长路线，得不偿失。

#### 框架

确定了语言之后，围绕语言我们要确定开发框架。一般而言就是前端的 JS 、CSS 框架、后端的 MVC 、SOA 、ORM 框架的选型。如果没有一定积累，不建议选择自研，可以先选用成熟稳定的开源技术作为开始。项目发展到一定阶段，如果开源技术不能满足需要，在选择自研合适的框架或中间件来进行逐一替换。

#### 架构

包含几个方面的不同类型的架构，这些事情虽然不可能在很短的时间内都想清楚，但这是领导者必须考虑的。很多公司很多项目在运行了几年之后，核心系统总体上还是维持了第一版的架构，虽然遇到各种问题想要推翻重来，但都因为代价实在太大而搁置或放弃：
	• 产品架构：战略是怎么样的，是否需要进行产品化抽象，扩展性是怎么样的；
	• 系统架构：网络怎么接入，哪些环节做高可用，涉及到哪些中间件，存储是什么，容量评估；
	• 业务架构：多少领域，多少子系统，对内还是对外，怎么相互支持；
	• 应用架构：层怎么分，逻辑层还是物理层，模块或服务怎么分，模块和模块之间怎么通讯，同步还是异步；
	• 工程化：我们是需要考虑可持续、可迭代的，一个良好的工程结构和工程方式也是初期需要确定的。比如，确定项目结构、源码管理方式、分支管理方式等等。

#### 核心业务

在几个创业公司工作时，我都会自己来实现最底层的技术框架或核心业务代码。一方面自己可以完全把控最难的核心系统，另一方面可以顺便把技术架构搭建起来。接下去，团队成员就可以在这个骨架上填肉，这样即便一开始没有很好的标准和指导原则，也可以把控住整个项目的代码。

#### 技术难点

除了核心业务，我会在最初就分析项目的技术难点，这些技术难点我们会选择三方技术来实现。但是一开始我们就要去考虑以后要脱离三方技术自己实现核心技术的可能性和代价，把这些问题摆在桌面上，让所有管理层都认识到。
除了这些，技术管理者需要做到的非常重要的一点就是以身作则，给大家做榜样。团队的规则和规矩一视同仁，这样，团队成员在执行你定的这规则的时候才没有任何理由拒绝和做不到。
从 0 开始确实需要做大量的工作，研究讨论产品方向，做产品计划，大量面试和新人培训，自己参与部分代码编写，还要凝聚初始的团队和团队磨合。这些事情往往会让你觉得分身乏术，但这段时间熬过去后，你就会体会到，这些工作都非常有意义。相反，如果一开始缺失这些工作，让技术野蛮生长，之后的工作就会很混乱。

## 从 0.5 开始的情况

从 0.5 开始的情况是，公司已经有一支团队，产品也已经上线。由于前期缺乏管理，技术方面处于一个烂摊子的状态。开发效率低、问题多，无法满足公司高速发展的需要。这个时候进入公司和从 0 开始的情况略有不同（但这其实又不同于成熟公司空降管理层），对内，我会在最短的时间做下面的工作：

### 熟悉产品

熟悉这个行业或领域，熟悉公司既有的产品，评估产品的技术难度，心里对期望的团队形态有一个底。同时可以花一点时间过一遍现有项目的技术架构和代码，对于现有的技术债也有一个预期。

### 熟悉团队

对现有团队成员进行 1 对 1 沟通（或者直接点说就是面试），了解每一个人的技术水平，当前的心态和状态以及对公司的期望。

### 开展救火

根据对产品的理解和已经与各需求方沟通的结果，按照轻重缓急整理出目前技术上需要调整的部分，挑选最重要的任务进行突击救火。可以进行小黑屋形式的集中开发，给予团队一定的压力，把工作分配到具体的人。一方面考察每个人的能力，一方面也考察成员的抗压能力和拼搏精神，追求安逸的人不适合在创业公司工作。如果业务在高速发展，不太建议一开始就停滞业务的迭代，把老项目推翻重来。最好的方式，是先进行必要的重构，等以后每一块业务进行大调整的时候进行逐一推翻。
调整团队
根据 1 - 3 的结果，快速进行团队调整，劝退不合适的人，招聘需要的人才。这些调整是基于一段时间对于产品和团队熟悉后的结论来的。并不建议所谓的新官上任三把火，在不了解团队的情况下直接调整。有的时候可能会心软，认为不合适的人可以去干一些没有那么大技术含量的工作，我也这么做过，但最后都付出了代价。

### 彻底融入

我个人的习惯是挑选比较重要的某个痛点自己上阵，对代码或架构开刀，只有这样才能真正了解大家目前遇到的问题，并且能尽快熟悉业务，大家融入到一起。如果时间有限，就把工作放到晚上或者周末进行。只有自己走到了最前线，才能在做出更有利于团队实际情况的决策。

### 建立信任

作为管理者进入新团队，团队的成员会担心新上级做出的团队调整会对自己有影响，会造成军心不稳。所以，在进行团队调整时，一定要对核心成员进行肯定和鼓励，另外，信任的建立不能仅靠权势，更重要的是，在日常工作中和大家一起拼搏，给予大家帮助，和大家建立平等的信任关系。
对部门外，需要同时和其他部门的负责人进行逐一沟通，了解大家对产品和技术的期望。另外，需要和 CEO 进行密切沟通，使自己的决策得到上级的支持。一般而言，我还会接手对公司外部的沟通工作，让团队成员可以更专注于项目。

## 0.5到1的阶段

公司经过了初创阶段，产品也已经上线运行。接下来产品需要高速、高质量迭代，作为技术管理者需要把各方面都规范起来。

### 管理需要标准化

#### 建立项目管理流程：

	• 是否要使用一些项目任务管理工具，比如 Jira 或 Tower 等；
	• 是否要使用一些文档知识管理工具，比如 Confluence 等；
	• 选择什么样的开发模式，是敏捷开发还是传统瀑布开发；
	• 制定各种会议制度，比如固定的晨会、周会、总结会等；
	• 规划分支使用的流程，代码审核的流程；
	• 测试如何进行，选用什么样的 Bug 管理平台，Bug 的分级等；
	• 和公司其他部门定期同步并讨论项目总体计划流程。

#### 建立沟通汇报流程：

	• 规划日常对内、对外 IM 沟通工具和邮件使用的规则；
	• 确定日常工作流程（评审、提测、发布、上线）；
	• 制定每一个团队成员的日报或周报的模板。

### 绩效管理OKR

绩效管理如何来做，选择 OKR 还是 KPI ？大家有太多讨论和不同意见。在 TGO 鲲鹏会的小组活动中，我们组员也经常会针对这个话题讨论，每一个公司都有不同的做法，这和公司层面的文化、背景、项目属性、甚至是管理层的性格都有关系，无法完全照搬别人的做法。
我认为一个相对成熟的公司，适合公司的绩效管理方式必不可少，需要不断探索。一般而言，考核是用来激励那些不太优秀的人，特别优秀的人才无论如何考核，他们永远都是是冲在最前面的一批人。但是，任何公司都不可能做到 100% 的员工都有合伙人的心态和冲劲，也不可能 100% 的员工都是世界一流人才。所以，帮助所有员工建立清晰的目标并且进行回顾和考核非常重要，要让所有人的目标都是清晰、具体且正确的。

### 技术需要标准化

#### 各个环境标准化：

	• 定义明确 Dev 、QA 、Staging 、Live 环境的作用、每个人的权限，以及每一个环境的使用方式；
	• 建立一套统一的发布系统来处理日常发布。比如，可以封装 Shell 脚本或 Jenkins ，并且明确在线上发布事中事后，包括：运维、开发、测试、产品等每一个应该负责的点。

#### 建立技术标准规范：

	• PRD 产品需求文档和 UI 标注的标准；
	• 开发标准，比如，可以在阿里的 Java 开发规范基础上和大家一起讨论，总结出符合自己公司需求的开发标准，并且通过代码规范插件来约束；
	• 概要设计文档的标准，文档必须包含哪些点，什么时候提交评审；
	• 概要设计时表结构和服务定义的标准，各种中间件使用方式的标准和最佳实践；
	• 自测标准，单元测试的要求，自测不完善测试打回的惩罚等；
	• CMDB 的建立、服务器配置，操作系统基础配置，程序安装方式的运维标准化。随着时间的推移可以总结出适合自己团队标准或最佳实践，所有的标准应该是所有团队成员共同认可和遵循的，可以定期就这些标准进行回顾和讨论。

#### 建立监控管理制度：

	• 搭建日志、监控报警基础设施。比如，可以使用 ELK 、Grafana 、InfluxDb 等来搭建；
	• 统一公司的日志、打点框架，规范明确项目的日志和打点标准；
	• 为各个业务建立监控面板和报警规则，明确报警处理标准；
	• 定义事故分级流程，复盘方法以及追责方式；
	• 定义运维日常监控容量巡检方式以及应急响应预案。

## 1+ 的高速发展阶段

随着业务规模的扩大，很可能有了多条产品线；随着团队规模的扩大，彻底扁平化的组织架构可能无法满足需要；随着访问量的增大，对技术和架构的要求也越来越多。这种情况，不管是对技术的要求还是对管理的要求都更上一层楼，这个时候需要在标准的基础上再做一些管理和组织结构的演进，站在更高的角度管理去思考。（这个时候做一些细枝末节的工作对于整体的意义就不大了）。

### 技术方面的升华

随着公司的发展，产品要么形态丰富，各种产品和业务衍生出来，要么产品形态不变，访问量急剧增大。对于前者，管理方面很容易犯的一个错误就是简单的进行业务线的拆分和招人、招人、招人，形成 N*20 个这样的团队，每一个团队之间相对独立，技术没有沉淀。对于后者，很容易犯的错误是通过堆服务器和堆运维来抵挡压力的上升，导致技术架构老旧问题增多。这种粗旷风格的团队扩张是不太健康的，更好的方法还是多折腾：
	1. 我的建议是通过进行技术和组织架构的调整，形成专才，形成纵向技术线，把通用技术提炼出来，让整个公司都可以积累统一的、能够向前发展的技术平台；
	2. 强制通过自动化手段把人解放出来，人应该去做创造性的工作；
	3. 消除团队安逸的状态，让团队或业务线之间形成竞争，保持冲劲。

### 组织架构调整

随着业务规模的扩大，团队规模也在扩大，仅仅对业务线的技术团队进行横向拆分（ X 维度拆分 ）还不够，还需要有专门的垂直团队服务于横向的业务团队。通过建立架构、中间件、运维等垂直团队服务于所有业务团队，确保技术和架构的统一（ Y 维度拆分 ）。
如果团队人数超过 20 不足 50 ，我们需要增加经理层来管理一线员工，变为三层架构，如果人数超过 50 不足 100 ，我们需要增加高级经理来管理经理，变为四层架构（ Z 维度拆分 ）。当然，可能还会形成一些虚拟的或实际的技术或项目管理委员会，对技术人员的发展、技术的标准化、公司层面的技术大任务进行定义和协调。
补充以下几点：
	1. 随着层级的增多，管理者对于一线员工的触达会越来越难，可能导致执行效率降低。这个时候，对下属主管的任用和管理非常重要。与管理一线员工相同的是，主管也需要绩效考核和标准，不同的是，主管们承担了管理职务，一线员工是由他们直接管理和影响的，此时对于主管的培养非常重要。不仅仅要让他们使用 CTO 原先定的标准和套路来管理，更多的是让主管明确意识到自己的管理职责，激发出他们自己的管理风格；
	2. 在确保主管被充分授权，并且有团队管理自治性的同时，最好提供一个通道，让一线员工有机会表现和表达自己的想法，让高层管理者可以了解到任何一名员工的想法，保持公正透明；
	3. 在公司这个阶段，可以和人事一起把人员的职级要求和薪资标准进行统一定义，要和绩效考核结合起来，形成固定周期的职级调整方案，形成明确的上升通道。让每一位成员意识到只要通过自己的努力，在公司内部同样可以走的很远；
	4. 业务团队和平台架构团队的目标使命不同，会存在一些矛盾存在。作为 CTO 要做好引导，让业务团队认识到架构统一的重要性，让架构团队认识到业务团队的压力。也可以鼓励团队之间的人员换岗以及做一些技术团队的培训，让架构团队理解业务，让业务团队深挖技术。

### 建立文化

人毕竟是社会动物，是有感情的，如果公司所有的管理手段都是硬手段，员工很难从内心认可。我们可以和 HRBP 配合，打造有团队特色的技术文化。比如，分享文化、开源文化、学习文化、鼓励自动化的文化等。
我们可以建立技术团队的微信公众号，让所有人一起来发文和运营。可以把自研的项目开源出去贡献给社区，让社区一起来完善，可以组织定期的公司内部或公司与公司之间的技术培训或交流，组织一年一度的技术之星、产品之星评选等等。初期可以通过使用一定的奖励激励手段来传播固定技术文化，形成文化后，每一位团队成员会觉得工作不仅仅是完成个人的任务，而是在一个集体中成长，在团队中生活，有归属感价值感。

### 建立价值观

一般而言公司层面会提炼出 3 - 5 项重要的价值观，技术团队也可以在此基础上细化、提炼技术方面的价值观，并纳入考核。
个人认为价值观一方面可以给我们定一个大方向，比如，我们需要怎么样的人；另一方面又类似于心理暗示，潜移默化的影响每一位员工。慢慢地，员工会演变为符合公司价值观的人（变得和公司有“夫妻相”），或者意识到无法适应价值观而主动离职。比如，如果可以定义一专多能、主动承担、勇于创新、言出必行作为技术团队的价值观，并且展开列出一些子项纳入考核。即使员工的业务能力没问题，但日常的表现不符合价值观，那么他只能是一个过客，无法和公司一起发展，这也是为什么很多大公司如此强调价值观的原因。
团队规模小的时候，我们只要自己冲在前线就可以很好的管理团队，在规模中等的时候我们可以利用一些标准和制度进行管理，在规模更大了以后，我们需要更高维度的文化价值观等手段来感染到每一个员工，让员工认同公司，这比约束命令式管理更有效。
处于这个阶段的公司，CTO 不仅要做好对内的管理工作，还要抽出时间做一些对外的工作，来帮助公司做品牌宣传，并且用技术争取更好的资源，比如，定期和同行以及投资人交流，组织参与一些技术讨论，跟进行业趋势等。

## 最后，想聊聊技术如何服务于公司战略？

就我个人而言，我觉得两点很重要，一是坚持，二是应变，三是要思考。围绕这几点，我列了一些技术服务公司战略的要点。

### 产品技术部门最基础的职责

作为产品技术团队，最本职的工作还是持续高效输出高质量、高可靠的产品，满足公司的业务需要。并且在不断提高可用性的同时，通过自动化、标准化提高效率，节省人力成本。在组织规模变大了以后，还能通过管理手段来保持团队的高效。随着业务和团队规模扩大，做到这几点并不容易，但这只是技术服务于公司战略的基本要求。

### 以技术创新把不可能变为可能

举个例子，有一次，业务给我提了一个需求，因为受到底层外部接口的限制，这个需求无法实现。但是业务表示，为什么别的公司可以实现，我们就不行。这时候，我才花时间去认真思考是否有一些突破的办法，尝试找到别人的实现方式，最后想到了可以绕开限制的方式，把这个项目实现了。我没想到的是，项目上线后业务告知当时问错了，其实别人也无法实现这个东西，因为只有我们实现了这个技术，所以很多人都愿意来找我们合作。
很多时候，我会认为自己有十几年的技术研发经验，我对公司既有技术足够理解，我以为我可以对一件事情是否可以实现很快下结论。其实这是不对的，在收到外部需求的时候，应该反过来思考，先假设这个需求是必须实现的，或者竞品已经实现了的，在拒绝别人之前，给自己几天时间，给团队几天时间来想一下怎么去实现，如果你做到了别人做不到的，那么你的技术就是核心竞争力。

### 建立一支可以打快战的铁军技术团队

随着公司技术的标准化和成熟，团队应该 具有打快战的能力，但是稳定的业务往往会让老兵们进入温水煮青蛙的状态。作为技术管理者，应该用各种手段来激励大家的斗志（比如搞阶段性的重构、黑客马拉松比赛），保持团队的活力。这样，如果有新开辟的项目，可以在公司内部轻松找到并形成一支敢死队来参与战斗，超高的执行力使得新业务可以尽快进行低成本试错或抢占市场，这也是技术产品团队成熟于否的体现。

### 根据战略及时调整团队架构和技术架构

不管是团队架构还是技术架构应该有一定时间的先行，一般而言对于线性发展的项目，公司目前如果处于 A 量级的 PV ，就应该开始储备十倍 A 量级 PV 的架构。根据业务的发展估算技术架构的挑战，提前半年或者一年进行新一代架构方案的确立，确保技术不拖业务后腿。团队架构也是同样需要先定义骨架，再在每一个可能的职位上进行填坑招聘。技术管理者需要对公司的战略敏感，根据公司的发展和战略，提前做好这两个架构调整的准备，并在需要的时候及时应用调整。

### 提炼核心技术，产品化产品，探索进行产品输出的可能

如果做的是 2C 的产品，在一个领域做了多年或许就有能力把核心技术或产品提炼出一套 2B 或 SaaS 的产品来卖，如果成功，这就不仅仅是一个 2C 的产品，很可能又多出一套 2B 的产品甚至是一套 2C 的平台。如果做的是 2B 的产品，或许就要思考一下，现在的产品是复制粘贴的定制化产品还是完全配置的产品化产品，如果不是，怎么让他更通用地进行产品化，减少人力成本。产品化平台化的过程是一个痛苦的抽象过程，对技术的要求更高，不过一旦实现就可以让公司的用户和规模得到爆发式发展，真正的技术改变战略。

### 关注前沿技术，思考前沿技术和公司业务的结合

目前正处在技术变革的一个关键阶段，在未来 5 年内，垂直细分的 AI 将会变得成熟，区块链也可能会出现大量的实际应用，技术管理者应该时刻关注这些技术，不断思考可能的结合场景。这个世上不缺爱思考的人，但很多懂业务的人不懂技术，懂技术的人又不能理解业务痛点，只要积极关注前沿技术并和业务专家保持讨论沟通，说不定哪天就会碰撞出具有革命性的产品。