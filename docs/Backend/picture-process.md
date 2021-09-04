# 图像处理

## imagemagick

给图片增加标签，水印等

https://legacy.imagemagick.org/Usage/annotating/

## im4java

java 操作类库

http://im4java.sourceforge.net/docs/dev-guide.html

## 运行环境

Dockerfile

fonts/fz目录下为支持的字体

```bash
FROM openjdk:8-jre-alpine
MAINTAINER Jes Shaw

WORKDIR /opt

COPY fonts/fz /usr/share/fonts/fz

RUN apk --no-cache add mkfontscale && \
    cd /usr/share/fonts/fz && \
    mkfontscale  && \
    apk --update add imagemagick && \
    rm -rf /var/cache/apk/*
```
