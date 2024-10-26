# liquibase

**Liquibase** 是一个开源的数据库版本控制工具，专门设计用于管理和跟踪数据库的结构变更，类似于代码版本控制。它可以将数据库的变更管理自动化，使得数据库和应用程序的发布更加同步和一致。Liquibase 支持多种数据库系统，如 MySQL、PostgreSQL、Oracle 等，使用 YAML、XML、JSON 和 SQL 等格式定义数据库变更文件。

## 1. Liquibase 的核心概念

### 1.1. 变更集（ChangeSet）

变更集是 Liquibase 的基本操作单元，描述一个或多个数据库变更。每个变更集通常包含一个唯一的 ID、作者信息、具体的变更内容，如创建表、添加列等。Liquibase 会记录每个变更集的执行状态，防止重复执行。

### 1.2. Changelog 文件

Changelog 文件包含一组变更集，用于描述数据库的整体变更历史。Liquibase 根据 Changelog 文件按顺序执行变更集，并记录到数据库的 `DATABASECHANGELOG` 表中，以便跟踪每个变更集的状态。

### 1.3. DATABASECHANGELOG 和 DATABASECHANGELOGLOCK

- **DATABASECHANGELOG**：保存已执行的变更集信息，包括 ID、作者、执行时间等。
- **DATABASECHANGELOGLOCK**：用于避免多个 Liquibase 实例并发修改数据库。

## 2. Liquibase 的优点

- **数据库变更版本管理**：支持团队间的协作，能记录和追踪所有数据库的变更。
- **自动回滚**：支持回滚功能，可以在出错时还原数据库到先前状态。
- **多环境适应**：可以在不同数据库系统间迁移，提供多种格式的 Changelog 文件。
- **自动化集成**：能与 CI/CD 流程集成，自动应用变更。

## 3. 安装和配置

### 3.1. 安装 Liquibase

可以从官网下载，也可以通过包管理工具（如 Homebrew）安装：

```bash
# 使用 Homebrew 安装（MacOS）
brew install liquibase
```

### 3.2. 配置数据库连接

可以通过 `liquibase.properties` 文件来配置数据库连接和基本参数：

```properties
# liquibase.properties
url=jdbc:mysql://localhost:3306/your_database
username=db_user
password=db_password
changeLogFile=src/main/resources/db/changelog/db.changelog-master.xml
driver=com.mysql.cj.jdbc.Driver
```

## 4. 创建和执行变更集

### 4.1. 定义变更集

以下是一个简单的 XML 格式变更集，用于创建一个 `user` 表：

```xml
<!-- src/main/resources/db/changelog/db.changelog-master.xml -->
<databaseChangeLog
        xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
        http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.8.xsd">

    <changeSet id="1" author="author_name">
        <createTable tableName="user">
            <column name="id" type="INT" autoIncrement="true">
                <constraints primaryKey="true"/>
            </column>
            <column name="username" type="VARCHAR(50)">
                <constraints nullable="false"/>
            </column>
            <column name="email" type="VARCHAR(50)">
                <constraints nullable="false"/>
            </column>
        </createTable>
    </changeSet>
</databaseChangeLog>
```

### 4.2. 执行变更集

使用 Liquibase 命令行工具执行变更集：

```bash
# 执行 Changelog 文件
liquibase update
```

## 5. 回滚变更集

Liquibase 支持多种回滚方法，可以通过 Changelog ID、变更集数、时间戳等方式回滚。

```bash
# 按照变更集 ID 回滚
liquibase rollbackCount 1

# 回滚到特定的标签
liquibase rollbackToDate YYYY-MM-DD
```

## 6. 集成到 CI/CD 流程

可以在 CI/CD 管道中将 `liquibase update` 命令集成到发布流程中，确保数据库更新和应用程序的代码发布同步。Liquibase 提供了插件和 API，可以方便地与 Jenkins、GitLab CI 等工具集成。

## 7. 常见的 Changelog 格式

除了 XML，Liquibase 还支持 YAML、JSON 和直接编写 SQL 的方式。

### YAML 示例

```yaml
databaseChangeLog:
  - changeSet:
      id: 1
      author: author_name
      changes:
        - createTable:
            tableName: user
            columns:
              - column:
                  name: id
                  type: INT
                  autoIncrement: true
                  constraints:
                    primaryKey: true
              - column:
                  name: username
                  type: VARCHAR(50)
                  constraints:
                    nullable: false
```

## 总结

Liquibase 提供了一套完整的数据库版本控制工具，使得开发和运维团队能够对数据库的变更进行自动化管理和追踪。通过定义变更集和 Changelog 文件，不仅可以在项目开发中进行有效的数据库管理，还可以确保数据库发布的一致性和可靠性。

## 参考

[liquibase diff](http://www.liquibase.org/documentation/diff.html)

[jhipster db upgrade](http://www.jhipster.tech/development/)
