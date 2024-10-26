# jhipster 常见问题

## 产生jhipster模型json

jhipster import-jdl ./src/model/member.jdl --json-only

## 仅创建后端实体相关

jhipster entity UserExt --skip-client

## 生成查询条件语句

1. filter [entity name]

2. jhipster import-jdl ./model.jdl --json-only

3. 确认.jhipster中的对应的实体json中有"jpaMetamodelFiltering": true

4. jhipster entity UserExt --skip-client

## 添加字段修改字段升级

1. 先生成实体对象。
2. revert回滚掉自动生成的升级字段。
3. 使用 ./mvnw clean compile liquibase:diff用 mvn clean compile liquibase:diff也行
4. 把生成的***changelog.xml添加到master.xml。
5. 运行 ./mvnw 即完成升级。
