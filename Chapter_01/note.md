
#### 1.1 shell跟踪选项  
1 使用set命令,执行起来最简单  
set的一个功能是打开和关闭shell中的各种选项,在这里设置的选项就是-x或-xtrace  
这样在运行时,除了正常的输出外,还会显示代码运行前每一行代码的扩展命令和变量.  
在set -x后执行的每一条命令以及加在命令中的任何参数(包括变量)都会显示出来(+)  
在子shell中执行的shell跟踪命令会加上两个++ 即"++"  
shell的一些选项可以引发这个输出结果的稍许变动,他对错误检测也是有用的.例如:
shell的-v就可以打开verbose模式,将脚本代码输出到stderr(跟代码正在执行一样)


用-x可以确认代码是否按设计预期运行,如果只想看正在运行的脚本文件代码(相对于变量的扩展值),那么-v选项是很有用的.对于逻辑错误和语法错误的检测,-x和-v各有所长  
用set -xv可同时看到两种类型输出,只是不方便浏览  

关闭和打开shell选项的句法是相反的,除了如前所述,使用-x的减号来打开一个选项,也可以使用+x来关闭.这在只需要调试一小段代码时是非常有用的.


### 1.3 根据调试层次控制输出
```bash
#!/bin/sh
debug=1
test $debug -gt 0 && echo "debug is on"
...
```
可以在代码中包含更过调试扩展,这样在程序运行时,就可以提供多层次的详细输出  


### 1.4 用alert函数简化错误检查  
alert函数一旦定义之后,就可以在任何关键命令之后紧接着调用它.  
用法:确定想要检查的代码行,然后直接调用alert函数,将$?和描述所报告内容的字符串传给alert  
```bash
#!/bin/sh
alert() {
# usage: alert <$?> <object>
if [ "$1" -ne 0 ]; then
	echo "WARNING: $2 did not complete sucessfully." >&2
    exit $1
else
	echo "INFO: $2 completed successfully" >&2
fi
}

cat $LOG | mail -s "$FROM attempting to get $FILE" $TO
alert $? "Mail of $LOG to $TO"
```

下面的代码是alert函数的高级形式  
```bash
#!/bin/sh
alert() {
local RET_CODE=$?
if [ -z "$DEBUG" ] || [ "$DEBUG" -eq 0 ]; then
 return
fi
if [ "$RET_CODE" -ne 0 ]; then
  echo "Warn: $* failed with a return code of $RET_CODE." >&2
  [ "$DEBUG" -gt 9 ] && exit "RET_CODE"
  

```



