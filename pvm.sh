#!/bin/sh
# macos下多PHP版本管理工具，用于快速却换当前环境中的默认PHP版本。
# 使用方法 sh pvm.sh -v 版本号
# 使用帮助 sh pvm.sh -h
# 在mac系统中安装指定版本php：brew install php@8.2
# 给php安装扩展：pecl install redis
# 更多的扩展见 https://pecl.php.net/
# @author tekintian@gmail.com
# @link http://dev.tekin.cn
# 
# 注意：建议在使用本脚本时先在 ~/.bash_profile文件中增加环境变量输出配置， 配置项目如下：
# 放入~/.bash_profile时注意去除 #
############### ~/.bash_profile start ###################
#
# export PATH="/usr/local/opt/php/bin:$PATH"
# export PATH="/usr/local/opt/php/sbin:$PATH"
# export LDFLAGS="-L/usr/local/opt/php/lib"
# export CPPFLAGS="-I/usr/local/opt/php/include"
# 
# 分别为各个版本PHP设置命令别名
# alias php74="/usr/local/opt/php@7.4/bin/php"
# alias pecl74="/usr/local/opt/php@7.4/bin/pecl"
# 
###############~/.bash_profile end ###################
# 当前已经安装的PHP版本数组获取
php_vers=$(ls /usr/local/opt|grep "php@"|sed 's/php@//g')

# 脚本帮助信息
help () {
  echo "PHP版本却换帮助:"
  echo "使用方法：sh $0 参数 如：sh $0 -v 8.2 "
  echo "-h  显示此帮助"
  echo "-l  列出当前系统中已经安装的PHP版本"
  echo "-v 8.2  将当前系统中的默认PHP版本设置为8.2"
  echo "-d  重置为7.4版本 这里后面不需要加版本号"
  echo "注意版本号不需要输入小版本，且必须先安装"
  exit 1
}
# 显示当前已经安装的PHP版本
# 如：版本号：8.2  安装路径：/usr/local/opt/php@8.2
show_php_vers(){
	for v in $php_vers;do
		echo "版本号：${v}  安装路径：/usr/local/opt/php@${v}"
	done
	exit 1
}

# 获取用户输入
while getopts ":v:dhl" opt
do
    case $opt in
        v)
          DEFAULT_PHP_VER=$OPTARG;;
        d)
          DEFAULT_PHP_VER="7.4";;
        l)
          show_php_vers;;
        h)
          help;;
        ?)
        echo "Unknown parameter"
        exit 1;;
    esac
done
# 获取用户输入的DEFAULT_PHP_VER参数，默认 7.4
DEFAULT_PHP_VER=${DEFAULT_PHP_VER:-"7.4"}

# ${php_vers[@]} 获取数组中的所有值
# 数组模式替换 形式为：${数组名[@或*]/模式/新值}
# 将要判断的元素在数组中使用模式替换后再和要比较的 数组的值进行比较 如果不相等 说明元素存在数组中，如果相等说明元素不存在
if [[ ${php_vers[@]/${DEFAULT_PHP_VER}/} != ${php_vers[@]} ]];then
	# 用户输入的版本存在当前系统中，进行操作
	# 强制将当前的默认PHP版本修改为指定的PHP版本  软链接形式 -s 创建符号链接而不是硬链接 -f 强制模式
	# 注意这里的 -n , --no-dereference  如果目的地是一个链接至某目录的符号链接，会将该符号链接当作一般文件处理，先将该已存在的链接备份或删除
	# 如果ln不加 -n参数的话对于已经存在的链接是不会生效的
	ln -snf "/usr/local/opt/php@${DEFAULT_PHP_VER}" /usr/local/opt/php
	# 使修改生效
	source ~/.bash_profile
	echo "成功将当前系统的默认PHP版本修改为${DEFAULT_PHP_VER}"
else
	echo "你输入的PHP版本${DEFAULT_PHP_VER}在当前系统中不存在！\n请确认 /usr/local/opt/php@${DEFAULT_PHP_VER} 目录存在！"
fi

