
#### 2.1 库文件   
库本身只是包含在单个文件中的一个函数集  


```bash
#!/bin/echo Warning: this library should be sourced!
# ostype(): Define OSTYPE variable to current operating system
ostype() {
	osname=`uname -s`
	# Assume we do not know what this is
	OSTYPE=UNKNOWN
	case $osname in
		"FreeBSD") OSTYPE="FREEBSD"
		;;
		"SunOS") OSTYPE="SOLARIS"
		;;
		"Linux") OSTYPE="LINUX"
		;;
	esac
	return 0
}
```
第一行用来保证该库的脚本不像常规脚本那样执行,而是以source命令的方式在当前shell中执行.有了这一行,如果某个程序员没有以source命令的方式执行该库文件,将
变量OSTYPE载入到环境中,而是试图直接运行该库,则会产生错误输出:  
Warning: this library should be sourced! /path_to_library  
另外一个避免直接运行库的方法就是将其设置成不可执行状态  


#### 2.2  一些有用的函数   

```bash
evenodd() {
# determine odd/even status by last digit 根据最后一位数字确定奇偶性
LAST_DIGIT=`echo $1 | sed 's/\(.*\)\(.\)$/\2/'` #用sed确定字符串最后一个字符
case $LAST_DIGIT in
0|2|4|6|8 )
return 1
;;
*)
return 0
;;
esac
}

# 判断一个远程系统是否运行,是否接入网络.
# 向特定机器ping3次,将运行结果输出到/dev/null中.
isalive() {
NODE=$1
$PING -c 3 $NODE >/dev/null 2>&1
if [ $? -eq 0 ]
then
return 1
else
return 0
fi
}

# 根据os类型设置可执行路径,将ping的路径存储在一个变量中,需要可执行文件时直接使用这个变量
# 也可使用此函数作为其他可执行路径保存的模板
setupenv() {
if [ "$OSTYPE" = "" ]
then
ostype
fi
NAME=`uname -n`
case $OSTYPE in
"LINUX" )
PING=/usr/sbin/ping
;;
"FREEBSD" )
PING=/sbin/ping
;;
"SOLARIS" )
PING=/usr/sbin/ping
;;
*)
;;
esac
}
```

#### 2.3 使用库   
1 source lib_file  
2 . lib_file  



