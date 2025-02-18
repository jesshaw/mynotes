# Sqoop

## Sqoop 是什么？

Sqoop（**SQL-to-Hadoop**）是一个用于在结构化数据存储（如关系型数据库）与 Hadoop 之间高效传输数据的工具。它可以帮助将数据从关系数据库（如 MySQL、PostgreSQL、Oracle 等）导入到 Hadoop 的 HDFS，或者将 HDFS 中的数据导出到关系数据库。

Sqoop 的核心功能：

1. **导入数据：** 从关系型数据库导入到 HDFS、Hive、HBase 等。
2. **导出数据：** 从 HDFS、Hive 导出到关系型数据库。
3. **支持增量导入：** 可以按时间或 ID 增量导入数据。
4. **并行操作：** 支持多线程加速数据传输。

---

## 使用 Sqoop 将 MySQL 数据写入到 Hadoop 的步骤

### 1. 准备工作

1. **安装 Sqoop**  
   Sqoop 通常作为 Hadoop 生态的一部分，可以通过以下方式安装：

   ```bash
   sudo apt install sqoop      # Ubuntu/Debian
   sudo yum install sqoop      # CentOS/RedHat
   ```

2. **配置 MySQL 驱动**  

   Sqoop 需要 JDBC 驱动连接 MySQL。将 MySQL JDBC 驱动（如 `mysql-connector-java.jar`）放到 `$SQOOP_HOME/lib` 目录下。

3. **确保 MySQL 和 Hadoop 可用**  

      - MySQL 数据库需要开放端口（通常为 3306）。
      - Hadoop 集群已启动并配置好 HDFS。

---

### 2. Sqoop 导入数据到 HDFS

以下是将 MySQL 表数据导入到 Hadoop 的 HDFS 的命令：

```bash
sqoop import \
  --connect "jdbc:mysql://<mysql_host>:3306/<database_name>" \
  --username <mysql_user> \
  --password <mysql_password> \
  --table <table_name> \
  --target-dir /path/to/hdfs/destination \
  --num-mappers 4
```

#### 参数说明

`--connect`：MySQL 的 JDBC 连接字符串。需替换 `<mysql_host>` 和 `<database_name>`。
- `--username` 和 `--password`：MySQL 的用户名和密码。
- `--table`：要导入的 MySQL 表名。
- `--target-dir`：HDFS 的目标目录。
- `--num-mappers`：并行导入的线程数，默认 4。

---

### 3. 导入数据到 Hive（可选）

如果需要直接将数据导入到 Hive 表中，可以使用以下命令：

```bash
sqoop import \
  --connect "jdbc:mysql://<mysql_host>:3306/<database_name>" \
  --username <mysql_user> \
  --password <mysql_password> \
  --table <table_name> \
  --hive-import \
  --hive-database <hive_database_name> \
  --hive-table <hive_table_name> \
  --num-mappers 4
```

#### 额外参数

`--hive-import`：直接将数据导入到 Hive 表中。
- `--hive-database` 和 `--hive-table`：指定 Hive 的数据库和表。

### 4. 增量导入（可选）

如果需要定期增量导入新数据，可以使用增量模式：

```bash
sqoop import \
  --connect "jdbc:mysql://<mysql_host>:3306/<database_name>" \
  --username <mysql_user> \
  --password <mysql_password> \
  --table <table_name> \
  --target-dir /path/to/hdfs/destination \
  --check-column <incremental_column> \
  --incremental append \
  --last-value <last_synced_value> \
  --num-mappers 4
```

#### 额外参数

`--check-column`：增量检查的列（如时间戳或自增 ID）。
- `--incremental`：增量模式（`append` 或 `lastmodified`）。
- `--last-value`：上次同步的最大值。

---

### 5. 确认导入的数据

在 HDFS 中检查导入的数据：

```bash
hdfs dfs -ls /path/to/hdfs/destination
```

查看文件内容：

```bash
hdfs dfs -cat /path/to/hdfs/destination/part-m-00000
```

---

## 总结

1. Sqoop 是一个桥梁工具，用于关系数据库与 Hadoop 之间的数据传输。
2. 通过简单的命令，数据可以从 MySQL 表高效导入到 HDFS 或 Hive。
3. 支持增量导入、多线程等特性，大幅提升数据同步效率。

你可以根据需求选择导入到 HDFS 或直接导入到 Hive，满足不同的分析场景。
