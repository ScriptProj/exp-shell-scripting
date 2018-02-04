
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



