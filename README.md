# 乐享喵

![lx](docs/assets/lx.ico)

## Push after check

```bash
# 显示含有project或Print的文件行号
git grep -n -e 'project' -e 'Print'
```

## Build images

```bash
# 克隆mkdocs-materia并跳转分支到7.3.0
git clone https://github.com.cnpmjs.org/squidfunk/mkdocs-material.git && cd ./mkdocs-material && git checkout 7.3.0

# 复制Dockerfile和requirements.txt到mkdocs-materia目录下
cp ../Dockerfile ../requirements.txt ./

# 切换到mkdocs-materia目录，执行镜像构建
docker build -t jesshaw/markdocs-matertial-plantuml-pdf:1.0 .
```

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

### Docker方式编译和部署

注意：以下3命令可能在git bash运行报Error: Config file 'mkdocs.yml' does not exist. 改用power shell或linux即可

```bash
# 启动开发服务器 http://localhost:8000

docker run  --rm -it -p 8000:8000 -v ${PWD}:/docs ghcr.io/jesshaw/mynotes bash

mkdocs serve --dev-addr=0.0.0.0:8000

# 查看详情
mkdocs serve -v 

# 不生成离线文档方式运行mkdocker material

docker run --rm -it -p 8000:8000 -v ${PWD}:/docs ghcr.io/jesshaw/mynotes bash -c "mkdocs serve --dev-addr=0.0.0.0:8000"


# 按需生成离线文档
# 通过指定gen-doc.yml来进行

docker run --rm -it -p 8000:8000 -v ${PWD}:/docs jesshaw/markdocs-matertial-plantuml-pdf:1.0 sh -c "ENABLE_PDF_EXPORT=1 mkdocs serve -f gen-doc.yml --dev-addr=0.0.0.0:8000"

# 编译

docker run --rm -it -v ${PWD}:/docs jesshaw/mkdocs-material:2.0.5 build

# 部署到GitHub Pages

docker run --rm -it -v ~/.ssh:/root/.ssh -v ${PWD}:/docs jesshaw/mkdocs-material:2.0.5 gh-deploy 
```

## 使用的是PDF生成工具

pip install mkdocs-with-pdf

## Project layout

mkdocs.yml    # The configuration file.
docs/
    index.md  # The documentation homepage.
    ...       # Other markdown pages, images and other files.

## 打包和发布

采用mike打包到gh-page分支，通过nginx来部署在线文档

## 部署新版本，且为默认分支版本

```bash
cd contents
mike deploy -u  0.1.1 latest
```

### latest设为默认分支版本

```bash
mike set-default latest
```

### 查看现有的版本

```bash
mike list
```

### 本机查看

```bash
mike serve
```
