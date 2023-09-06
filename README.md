# macos下的php多版本切换工具

## 介绍
用于在macos中使用brew安装了多个PHP版本时的快速默认php版本切换！

## 使用方法：

下载 pvm.sh 文件到本地，然后执行 
~~~sh
# 显示当前已经安装的可用PHP版本
pvm.sh -l
# 切换版本 为php 8.2
pvm.sh -v 8.2
~~~


## macos安装指定版本PHP

~~~sh
brew install php@8.2
~~~

## macos php默认环境变量、命令别名配置

在 ~/.bash_profile 文件中增加环境变量配置，内容如下
~~~sh
# 配置PHP环境，目的是可以在终端中直接执行php命令和让其他软件能够识别PHP的类库
export PATH="/usr/local/opt/php/bin:$PATH"
export PATH="/usr/local/opt/php/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/php/lib"
export CPPFLAGS="-I/usr/local/opt/php/include"

# 分别为各个版本PHP设置命令别名 设置后不受默认版本影响可以直接在终端中使用 php82 命令运行php 8.2版本
alias php82="/usr/local/opt/php@8.2/bin/php"
alias pecl82="/usr/local/opt/php@8.2/bin/pecl"

~~~

## 服务与支持
专业提供各种企业信息化软件开发和定制服务，服务热线/微信：13888011868
QQ:932256355


#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


