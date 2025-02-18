# A big data test environment

基于 Docker 搭建一个简单的大数据架构（Hadoop），可以快速试验数据同步、分析和统计。以下是具体步骤：

## 1. **准备工作**

- 安装 [Docker](https://www.docker.com/) 和 [Docker Compose](https://docs.docker.com/compose/)。
- 确保本地资源充足（至少 8GB 内存和 4 核 CPU）。

---

## 2. **选择镜像**

推荐使用官方或社区维护良好的 Hadoop 镜像，例如：
- **bde2020/hadoop-docker**: 社区常用的 Hadoop 环境镜像。
- **sequenceiq/hadoop-docker**: 提供快速部署单节点 Hadoop 的镜像。

---

## 3. **设置 Docker Compose 文件**

创建 `docker-compose.yml` 文件，定义 Hadoop 集群组件（例如：NameNode、DataNode、ResourceManager）。

### 示例 Compose 文件

镜像地址

https://docker.1ms.run

```bash
docker pull bde2020/hadoop-namenode:2.0.0-hadoop2.7.4-java8 && \
docker pull bde2020/hadoop-datanode:2.0.0-hadoop2.7.4-java8 && \
docker pull bde2020/hadoop-resourcemanager:2.0.0-hadoop2.7.4-java8 && \
docker pull bde2020/hadoop-nodemanager:2.0.0-hadoop2.7.4-java8 && \
docker pull bde2020/hadoop-historyserver:2.0.0-hadoop2.7.4-java8 
```

```yaml
version: '3.8'
services:
  namenode:
    image: bde2020/hadoop-namenode:2.0.0-hadoop2.7.4-java8
    container_name: namenode
    environment:
      - CLUSTER_NAME=test_cluster
      - CORE_CONF_fs_defaultFS=hdfs://namenode:9000
    ports:
      - "9870:50070" # NameNode Web UI
      - "9000:9000" # NameNode RPC
    volumes:
      - namenode-data:/hadoop/dfs/name
    networks:
      - hadoop-net

  datanode:
    image: bde2020/hadoop-datanode:2.0.0-hadoop2.7.4-java8
    container_name: datanode
    environment:
      - CLUSTER_NAME=test_cluster
      - CORE_CONF_fs_defaultFS=hdfs://namenode:9000
    ports:
      - "9864:9864" # DataNode Web UI
    volumes:
      - datanode-data:/hadoop/dfs/data
    networks:
      - hadoop-net
    depends_on:
      - namenode

  resourcemanager:
    image: bde2020/hadoop-resourcemanager:2.0.0-hadoop2.7.4-java8
    container_name: resourcemanager
    environment:
      - YARN_CONF_yarn_resourcemanager_hostname=resourcemanager
    ports:
      - "8088:8088" # ResourceManager Web UI
    networks:
      - hadoop-net
    depends_on:
      - namenode

  nodemanager:
    image: bde2020/hadoop-nodemanager:2.0.0-hadoop2.7.4-java8
    container_name: nodemanager
    networks:
      - hadoop-net
    depends_on:
      - resourcemanager

  historyserver:
    image: bde2020/hadoop-historyserver:2.0.0-hadoop2.7.4-java8
    container_name: historyserver
    environment:
      - HDFS_CONF_dfs_namenode_http-address=namenode:9870
    ports:
      - "8188:8188" # HistoryServer Web UI
    networks:
      - hadoop-net
    depends_on:
      - namenode

volumes:
  namenode-data:
  datanode-data:

networks:
  hadoop-net:
```

## 4. **启动集群**

运行以下命令启动 Hadoop 环境：

```bash
docker-compose up -d
```

验证服务是否运行：

- NameNode Web UI: `http://localhost:9870`
- ResourceManager Web UI: `http://localhost:8088`

---

运行一下MySql数据库

```yaml  
version: '3.8'
services:
mysql:
  image: bitnami/mysql:8.4
  ports:
    - '3306:3306'
  volumes:
    - 'mysql_data:/bitnami/mysql/data'
  environment:
    # ALLOW_EMPTY_PASSWORD is recommended only for development.
    # - ALLOW_EMPTY_PASSWORD=yes
    - MYSQL_ROOT_PASSWORD=password123
    - MYSQL_DATABASE=test_db
    - MYSQL_USER=user
    - MYSQL_PASSWORD=pass
  healthcheck:
    test: ['CMD', '/opt/bitnami/scripts/mysql/healthcheck.sh']
    interval: 15s
    timeout: 5s
    retries: 6

volumes:
  mysql_data:
```

## 5. **测试异构数据同步和分析**

使用以下工具在 Hadoop 上完成数据同步和分析任务：

### (1) **数据同步**

- **Sqoop**: 用于将关系型数据库（如 MySQL）中的数据导入 HDFS。

  ```bash
  docker run --rm -it --network hadoop_hadoop-net \
  -v /mnt/c/Users/xiaomouzhi/.m2/repository/mysql/mysql-connector-java/8.0.19/mysql-connector-java-8.0.19.jar:/usr/local/sqoop/lib/mysql-connector-java.jar \
  dvoros/sqoop  bash


  sqoop list-databases \
  --connect jdbc:mysql://172.27.243.72:3306/test_db \
  --username user --password pass

  sqoop import \
  -fs hdfs://172.27.243.72:9000 \
  -jt 172.27.243.72:8032 \
  --connect "jdbc:mysql://172.27.243.72:3306/test_db?allowPublicKeyRetrieval=true&useSSL=false" \
  --username user \
  --password pass \
  --table test_table \
  --target-dir /hadoop/dfs/data/test_db__test_table \
  -m 1

  ```

- **Flume**: 实时收集日志数据并写入 HDFS。
- **Kafka + Spark Streaming**: 处理流数据。

### (2) **数据分析**

- **Hive**: 在 HDFS 上进行 SQL 查询。

  ```bash
  hive -e "SELECT * FROM test_table WHERE col1 = 'value';"
  ```

- **Spark**: 执行更复杂的分布式计算。

  ```bash
  spark-submit --class org.example.MyApp my-spark-app.jar
  ```

### (3) **统计和可视化**

- 将分析结果保存到 HDFS 后，可以用以下工具展示：
  - **Tableau / Power BI**: 连接 Hive 或 Spark SQL。
  - **Zeppelin / Jupyter Notebook**: 在笔记本中直接分析并可视化。

---

## 6. **清理环境**

完成实验后，删除 Docker 容器和网络：

```bash
docker-compose down -v
```

---

## 7. **扩展选项**

- **添加外部数据库**: 将 MySQL、PostgreSQL 数据库镜像加入 `docker-compose.yml`，实现多源数据同步。
- **添加机器学习功能**: 在集群上运行 MLlib 或 PySpark。
- **容器监控**: 使用 Prometheus + Grafana 监控集群性能。

这样一个本地 Hadoop 环境可以帮助快速试验和验证大数据方案，资源占用小，便于扩展！
