# mkdocs 插件

插件很多，以下为使用过的插件的注意事项

## PDF和站点转换

### WeasyPrint安装

导出pdf格式的插件大多依赖WeasyPrint, 因此正常安装WeasyPrint是关键。

**window 10 64**位环境下安装步骤如下：

python -> pip和setuptools更新到最新版 -> 安装WeasyPrint -> 单独下载安装GTK+

[gtk3下载](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases/download/2021-04-29/gtk3-runtime-3.24.29-2021-04-29-ts-win64.exe)

安装完成后自动配置好了环境变量，但**需要重启**。 **新版的gtk3安装完成后，并不需要独立安装cairo, Pango and GDK-PixBuf**，这一点跟官网不一样。

```bash
# 测试是否安装成功，因为服务器在国外，容易出现网络抖动，建议改用本地的mkdocs生成的文档测试。
python -m weasyprint http://weasyprint.org weasyprint.pdf
```

[官网的安装文档参考](https://weasyprint.readthedocs.io/en/latest/install.html#windows)

### mkdocs-with-pdf

仅适合在非多语言环境使用，所以可以通过指定文件的方式单独生成pdf文件 `mkdoc build -f test.yaml`

### mkpdfs bug

AttributeError: module 'mkdocs.utils' has no attribute 'string_types'

需要到1.1之后版本修改，所以要自行更改本地的源码

https://github.com/comwes/mkpdfs-mkdocs-plugin/pull/15/commits/c313b133f40afbcaf2a65bf0509f52822318dec6

### 仅生成目录

修改如下方法中的代码

generator.on_post_build

```python
# start 
## 找出文档内容部分删除后不进行接下来的输出到pdf的工作
for ar in soup.body.find_all("article", class_="md-typeset"):
    ar.extract()
## 删除二维码的生成
soup.body.find("article", id="doc-back_cover").extract()
# end
html_string = self._render_js(soup)

html_string = self._options.hook.pre_pdf_render(html_string)
```

替换非标题的内容为空

python 方法中可以嵌套方法

```python
# start 
def replace_content(content):
        includes = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6']
        for ch in content.children:
        if not(ch.name == 'section'  or  ch.name  in includes  or  ch.parent.name  in includes):
            ch.replace_with('***')
        if ch.name:
            replace_content(ch)
# end             

for page in self._nav:
        content = self._get_content(soup, page)
        # replace_content(content)
```

## mkdocs-material移除生产方

material对支持移除产生存在bug。即使已经配置，还是会生成生产方的信息。

```yaml
extra:
  generator: false
```

需要修复以下文件位置在Python39\Lib\site-packages\material\partials\footer.html

```html
 <div class="md-footer-meta md-typeset">
    <div class="md-footer-meta__inner md-grid">
      <div class="md-footer-copyright">
        {% if config.copyright %}
          <div class="md-footer-copyright__highlight">
            {{ config.copyright }}
          </div>
        {% endif %}
        <!-- 开始 -->
        {% if config.extra.generator %}
        Made with
        <a href="https://squidfunk.github.io/mkdocs-material/" target="_blank" rel="noopener">
          Material for MkDocs
        </a>
        {% endif %}
        <!-- 结束 -->
        {{ extracopyright }}
      </div>
      {% include "partials/social.html" %}
    </div>
  </div>
```

## 如何制定mkdocs-material的镜像

### 克隆mkdocs-material

```bash
git clone https://github.com/squidfunk/mkdocs-material.git
git checkout 7.3.0
```

### 增加需要安装的插件

requirements.txt

```bash

```
