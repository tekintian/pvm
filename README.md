# macos下的php多版本切换工具

## 介绍
用于在macos中使用brew安装了多个PHP版本时的快速默认php版本切换！ 

自动检测当前系统中安装的PHP版本，防止错误更改。 自动更新当前系统PHP环境变量配置。

变更PHP版本更改快捷高效！


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

### brew安装的PHP的几个常用的路径

#### pecl扩展.so文件路径  /usr/local/lib/php/pecl
	这个里面包含了所有PHP版本的pecl扩展安装后的.so文件
~~~sh
├── 20190902 这个对应的是 php7.4版本的pecl的so编译路径
│   ├── igbinary.so
│   ├── json_post.so
│   ├── mcrypt.so
│   ├── msgpack.so
│   ├── redis.so
│   ├── xdebug.so
│   └── yaml.so
└── 20220829 这个对应的是 php8.2版本的pecl的so编译路径
    ├── igbinary.so
    ├── json_post.so
    ├── mcrypt.so
    ├── msgpack.so
    ├── redis.so
    └── xdebug.so
~~~

#### php配置信息路径
/usr/local/etc/php/  所有的php版本对应的配置信息全部在这里

~~~sh
├── conf.d 扩展配置目录，建议将所有的php扩展配置信息全部按照扩展名放到这里，php会自动加载
│   ├── ext-igbinary.ini
│   ├── ext-json_post.ini
│   ├── ext-mcrypt.ini
│   ├── ext-msgpack.ini
│   ├── ext-opcache.ini
│   ├── ext-redis.ini
│   └── ext-xdebug.ini
├── pear.conf
├── php-fpm.conf
├── php-fpm.d 
│   └── www.conf
├── php.ini  PHP的主配置文件 pecl安装的扩展会自动在这个文件的顶部增加对应的扩展加载，建议将这些扩展都移动到 conf.d文件夹中
└── php.ini-production
~~~

注意：通过pecl安装的扩展 自动在php.ini文件中增加的扩展配置类似这样的 extension="redis.so" 移动到conf.d后最好修改为绝对路径，
如php8.2的redis扩展：
ext-redis.ini
~~~ini
[redis]
extension="/usr/local/lib/php/pecl/20220829/redis.so"
~~~


### ext-xdebug.ini 配置示例
~~~ini
; Xdebug3 config 
; See https://xdebug.org/docs/all_settings
[xdebug]
zend_extension=/usr/local/lib/php/pecl/20220829/xdebug.so
; 设置为off 表示关闭xdebug,也可以设置多个值 
xdebug.mode = develop,debug,trace
xdebug.start_with_request = default
xdebug.start_upon_error = default
xdebug.client_host = localhost
xdebug.client_port = 9003
xdebug.connect_timeout_ms = 200
xdebug.dump_globals = true
;xdebug.log=/var/log/php/ll3.log
;xdebug.log_level = 3
;xdebug.max_nesting_level = 700
;xdebug.output_dir = /var/log/php/xdebug
;xdebug.trace_output_name = trace.%H.%c
xdebug.idekey = "vsc"
xdebug.collect_assignments = true
xdebug.collect_return = true
xdebug.trigger_value = ""
xdebug.discover_client_host = false 
xdebug.client_discovery_header = "HTTP_X_FORWARDED_FOR,REMOTE_ADDR"
~~~

## 服务与支持
专业提供各种企业信息化软件开发和定制服务，包括各种信息化软件的定制开发，手机APP开发（安卓/ios）, windows桌面应用软件开发，微信小程序，公众号开发，企业网站定制开发服务，免费咨询热线：13888011868
QQ:932256355


#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


