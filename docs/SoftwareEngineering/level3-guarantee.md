# 三级等保

三级等保认证十分严格，根据《信息系统安全等级保护基本要求》，三级等保的测评内容涵盖等级保护安全技术要求的5个层面和安全管理要求的5个层面，包含信息保护、安全审计、通信保密等在内的近300项要求，共涉及测评分类73类。通过"三级等保"认证，表明企业的信息安全管理能力达到国内最高标准。

为了通过三级等保测评，成功拿证，等级保护申办单位必须根据三级等保的安全技术要求和安全管理要求做好网络安全防护。**那么，三级等保的安全技术要求和安全管理要求是什么呢？如下所示：**

## 一、三级等保的技术要求包括物理、网络、主机、应用、数据5个方面

### 1.物理安全部分*

①机房应区域划分至少分为主机房和监控区两个部分；

②机房应配备电子门禁系统、防盗报警系统、监控系统；

③机房不应该有窗户，应配备专用的气体灭火、ups供电系统。

### 2.网络安全部分*

①应绘制与当前运行情况相符合的拓扑图；

②交换机、防火墙等设备配置应符合要求，例如应进行Vlan划分并各Vlan逻辑隔离，应配置Qos流量控制策略，应配备访问控制策略，重要网络设备和服务器应进行IP/MAC绑定等；

③应配备网络审计设备、入侵检测或防御设备。

④交换机和防火墙的身份鉴别机制要满足等保要求，例如用户名密码复杂度策略，登录访问失败处理机制、用户角色和权限控制等；

⑤网络链路、核心网络设备和安全设备，需要提供冗余性设计。

### 3.主机安全部分*

①服务器的自身配置应符合要求，例如身份鉴别机制、访问控制机制、安全审计机制、防病毒等，必要时可购买第三方的主机和数据库审计设备；

②服务器（应用和数据库服务器）应具有冗余性，例如需要双机热备或集群部署等；

③服务器和重要网络设备需要在上线前进行漏洞扫描评估，不应有中高级别以上的漏洞（例如windows系统漏洞、apache等中间件漏洞、数据库软件漏洞、其他系统软件及端口漏洞等）；

④应配备专用的日志服务器保存主机、数据库的审计日志。
![](/uploads/201113/1-20111311404AW.jpg)

### 4.应用安全部分*

①应用自身的功能应符合等保要求，例如身份鉴别机制、审计日志、通信和存储加密等；

②应用处应考虑部署网页防篡改设备；

③应用的安全评估（包括应用安全扫描、渗透测试及风险评估），应不存在中高级风险以上的漏洞（例如SQL注入、跨站脚本、网站挂马、网页篡改、敏感信息泄露、弱口令和口令猜测、管理后台漏洞等）；

④应用系统产生的日志应保存至专用的日志服务器。

### 5.数据安全备份*

①应提供数据的本地备份机制，每天备份至本地，且场外存放；

②如系统中存在核心关键数据，应提供异地数据备份功能，通过网络等将数据传输至异地进行备份；

## 二、三级等保在管理制度方面的要求，包括5方面的制度和记录

1、安全管理制度

2、安全管理机构

3、人员安全管理

4、系统建设管理

5、系统运维管理