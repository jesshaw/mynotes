VS code 打造 shell脚本 IDE
======================

近期多了些开发shell脚本的需求，便做了些研究，于是发现：

1、shell没有专用的IDE

2、老手们习惯了vim的开发方式，干起活来非常黑客。但对新人，不太友好

既然没有现成的，那就用插件组一套，软件依然是vscode。

1、shellman

说起IDE，第一时间想到的必然是智能提示和自动补全，shellman全部搞定

<figure data-size="normal">

<noscript><img src="https://pic4.zhimg.com/v2-3f47f9189cf5d3f1684d00ebea2de5b7_b.png" data-caption="" data-size="normal" data-rawwidth="385" data-rawheight="62" class="content_image" width="385"/></noscript>

![](https://pic4.zhimg.com/80/v2-3f47f9189cf5d3f1684d00ebea2de5b7_1440w.png)</figure>

下载后，新建test.bash文件，输入case，可见如下结果：

<figure data-size="normal">

<noscript><img src="https://pic2.zhimg.com/v2-f5ffbf38e704b447aaba6a91c0be7a75_b.jpg" data-caption="" data-size="normal" data-rawwidth="479" data-rawheight="119" class="origin_image zh-lightbox-thumb" width="479" data-original="https://pic2.zhimg.com/v2-f5ffbf38e704b447aaba6a91c0be7a75_r.jpg"/></noscript>

![](https://pic2.zhimg.com/80/v2-f5ffbf38e704b447aaba6a91c0be7a75_1440w.jpg)</figure>

选中提示中的第一个，然后就获得了if全家桶：

<figure data-size="normal">

<noscript><img src="https://pic3.zhimg.com/v2-9f794b6bc6304a3b8b2fb23d03468dce_b.jpg" data-caption="" data-size="normal" data-rawwidth="221" data-rawheight="209" class="content_image" width="221"/></noscript>

![](https://pic3.zhimg.com/80/v2-9f794b6bc6304a3b8b2fb23d03468dce_1440w.jpg)</figure>

由上面两张图可见shellman的提示是比较系统的。

2、shellcheck

有了自动补全，然后就是语法错误检查了

<figure data-size="normal">

<noscript><img src="https://pic4.zhimg.com/v2-f77e0c9647164ebe06e897675e1c415b_b.jpg" data-caption="" data-size="normal" data-rawwidth="392" data-rawheight="66" class="content_image" width="392"/></noscript>

![](https://pic4.zhimg.com/80/v2-f77e0c9647164ebe06e897675e1c415b_1440w.jpg)</figure>

安装成功后，再写代码就会出现如下的错误提示：

<figure data-size="normal">

<noscript><img src="https://pic3.zhimg.com/v2-591bd52c41f48e6d51accfedabdf425a_b.png" data-caption="" data-size="normal" data-rawwidth="780" data-rawheight="75" class="origin_image zh-lightbox-thumb" width="780" data-original="https://pic3.zhimg.com/v2-591bd52c41f48e6d51accfedabdf425a_r.jpg"/></noscript>

![](https://pic3.zhimg.com/80/v2-591bd52c41f48e6d51accfedabdf425a_1440w.png)</figure>

3、shell-format

脚本写好了，当然要格式化一下

<figure data-size="normal">

<noscript><img src="https://pic4.zhimg.com/v2-cd9a106e1828edf0df810c0166d5d13b_b.jpg" data-caption="" data-size="normal" data-rawwidth="383" data-rawheight="73" class="content_image" width="383"/></noscript>

![](https://pic4.zhimg.com/80/v2-cd9a106e1828edf0df810c0166d5d13b_1440w.jpg)</figure>

快捷键：Alt+Shift+F

4、Code Runner

在vs code里开发，在vs code里纠错，又在vs code里格式化，到了调试不会要去命令行吧！

<figure data-size="normal">

<noscript><img src="https://pic1.zhimg.com/v2-c655e51a39dd8b27e284c44c99ce4cb4_b.jpg" data-caption="" data-size="normal" data-rawwidth="388" data-rawheight="66" class="content_image" width="388"/></noscript>

![](https://pic1.zhimg.com/80/v2-c655e51a39dd8b27e284c44c99ce4cb4_1440w.jpg)</figure>

安装完后，如果出现require reload的字样，请重启vs code。然后对刚才创建的test.bash右键，（或者在文件里右键）：

<figure data-size="normal">

<noscript><img src="https://pic3.zhimg.com/v2-072b4be03f6651a7091a724a1fb65442_b.jpg" data-caption="" data-size="normal" data-rawwidth="434" data-rawheight="130" class="origin_image zh-lightbox-thumb" width="434" data-original="https://pic3.zhimg.com/v2-072b4be03f6651a7091a724a1fb65442_r.jpg"/></noscript>

![](https://pic3.zhimg.com/80/v2-072b4be03f6651a7091a724a1fb65442_1440w.jpg)</figure>

到这里，刀就已经磨好了，去劈柴吧少年~
