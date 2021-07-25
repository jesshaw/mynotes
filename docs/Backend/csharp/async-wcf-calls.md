---
title: 客户端异步wcf调用
tags: asynchronous,wcf, castle, WcfFacility,异步.
categories: 
  - csharp

thumbnail: /gallery/blue-water2.jpg
---
一个无需svcUtil产生异步代码的、客户端异步调用同步wcf服务端的实现方法
<!-- more -->

## 问题

要想异步实现调用wcf，有两种方式。方式一：服务端增加异步契约，在客户端是使用专用的异步调用；方式二：是在客户端生成异步调用代码。

方式一增加了契约接口，前后端都增加了维护成本。方式二契约接口统一，代码维护量减少，但是微软的做法是svcUtil生成异步代码（同步代码可以使用ChannelFactory实现，也不需要生成代码）。这样一来，其缺点是一旦契约变动，就需要重新生生成，可维护性不是太友好。

所以若能不生成异步代码，实现异步功能，即解决了我们的问题。

## 解决方案

使用Windsor container and WCF Facility执行异步wcf调用已有同步契约接口即可，示例如下。

目录结构

```
|--Async.Wcf.Calls
   |--Client
      |--app.config
      |--CategoryServiceClient.cs
      |--Program.cs
   |--Contracts
      |--DataContracts
         |--Category.cs
      |--ServiceContracts
         |--ICategoryService.cs
   |--Services
      |--CategoryServices
         |--CategoryService.cs
      |--ServiceHosts
         |--CategoryServiceHost.svc
      |--App.config
```

契约项目客户端和服务端公用

```csharp
    [ServiceContract(Name = "CategoryService", Namespace = "http://northwind.com/categoryservice")]
    public interface ICategoryService
    {
        [OperationContract]
        string GetCategoryName(int categoryId);

        [OperationContract]
        Category GetCategoryDetails(int categoryId);
    }

    [DataContract]
    public class Category
    {
        [DataMember]
        public int CategoryId { get; set; }

        [DataMember]
        public string CategoryName { get; set; }

        [DataMember]
        public string CategoryDescription { get; set; }

        [DataMember]
        public string CategoryUrl { get; set; }
    }    
```

注意这是同步版本的服务端契约。

服务端实现如下。

```csharp
    [ServiceBehavior(Name = "CategoryService", Namespace = "http://northwind.com/categoryservice")]
    public class CategoryService : ICategoryService
    {
        public string GetCategoryName(int categoryId)
        {
            Thread.Sleep(5000);
            return "Beverages";
        }

        public Category GetCategoryDetails(int categoryId)
        {
            var category = new Category
            {
                CategoryId = 1,
                CategoryName = "Beverages",
                CategoryDescription = "Soft drinks, coffees, teas, beers, and ales",
                CategoryUrl = "http://northwind.com/Beverages"
            };

            return category;
        }
    }
```

我们使用svc实现自启动服务,服务端的app.config配置如下。

```xml
<?xml version="1.0"?>
<configuration>
  <system.web>
    <compilation debug="true"/>
  </system.web>  
  <system.serviceModel>
    <services>
      <service name="Services.CategoryServices.CategoryService">
        <host>
          <baseAddresses>
            <add baseAddress="http://localhost:7741/NorthwindServices/CategoryServices/CategoryService"/>
          </baseAddresses>
        </host>
        <endpoint address="" binding="wsHttpBinding" contract="Contracts.ServiceContracts.ICategoryService" bindingNamespace="http://northwind.com/categoryservice">
        </endpoint>
        <endpoint address="mex" binding="mexHttpBinding" contract="IMetadataExchange"/>
      </service>
    </services>
    <behaviors>
      <serviceBehaviors>
        <behavior>          
          <serviceMetadata httpGetEnabled="True"/>          
          <serviceDebug includeExceptionDetailInFaults="False"/>
        </behavior>
      </serviceBehaviors>
    </behaviors>
  </system.serviceModel>
<startup><supportedRuntime version="v4.0" sku=".NETFramework,Version=v4.0"/></startup></configuration>
```

客户端实现更加简单，app.config无需配置，其他代码实现如下。

``` csharp
public static class CategoryServiceClient
    {
        // Windsor 异步版
        public static Task<string> GetCategoryNameAsync(int categoryId)
        {
            WindsorContainer container = ConfigureContainer();

            var service = container.Resolve<ICategoryService>("categegory");

            Task<string> taskResult =
                Task.Factory.FromAsync<string>(service.BeginWcfCall(p => p.GetCategoryName(categoryId)),
                    service.EndWcfCall<string>);

            return taskResult;
        }

        // Windsor  同步版
        public static string GetCategoryName(int categoryId)
        {
            WindsorContainer container = ConfigureContainer();

            var instance = container.Resolve<ICategoryService>("categegory");

            string categoryName = instance.GetCategoryName(categoryId);

            return categoryName;
        }

        //ChannelFactory  同步版
        public static Category GetCategoryDetails(int categoryID)
        {
            var category = new Category();

            var myBinding = new WSHttpBinding();
            var myEndpoint =
                new EndpointAddress("http://localhost:7741/NorthwindServices/CategoryServices/CategoryService");
            var myChannelFactory = new ChannelFactory<ICategoryService>(myBinding, myEndpoint);

            ICategoryService instance = myChannelFactory.CreateChannel();

            category = instance.GetCategoryDetails(categoryID);

            myChannelFactory.Close();

            return category;
        }


        private static WindsorContainer ConfigureContainer()
        {
            var container = new WindsorContainer();
            container.AddFacility<WcfFacility>().Register(
                Component.For<ICategoryService>()
                    .Named("categegory")
                    .AsWcfClient(new DefaultClientModel
                    {
                        Endpoint =
                            WcfEndpoint.BoundTo(new WSHttpBinding())
                                .At("http://localhost:7741/NorthwindServices/CategoryServices/CategoryService")
                    }));
            return container;
        }
    }
 ```   

 启动程序

 ```csharp
 class Program
    {
        private static void Main(string[] args)
        {
            var p = new Program();
            p.ExeSync();
            Console.Read();
        }

        private async void ExeSync()
        {
            Task<string> taskResult = CategoryServiceClient.GetCategoryNameAsync(10);
            DoIndependentWork();
            string result = await taskResult;
            Console.WriteLine(result);
        }

        private void DoIndependentWork()
        {
            Console.WriteLine("loding...");
        }
    }
 ```

 在配置好Windsor container和WCF Facility后，我们就实现了一个客户端代理。使用WCF Facility就可以奇迹般的异步调用啦。



