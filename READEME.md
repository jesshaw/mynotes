# Welcome to MkDocs

For full documentation visit [mkdocs.org](https://www.mkdocs.org).

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

![](assets/lx.png)
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
