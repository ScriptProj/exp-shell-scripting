#### 8.1 用数组实现进程树  

```bash
#!/bin/bash
#用数组实现进程树

if [ "$1" = "" ]
then
	proc=1
else
	proc=$1
fi

main () {
  #脚本先创建了一个包含当前进程表信息的变量
  PSOUT=`ps -ef | grep -v "^UID" | sort -n -k2`
  # This technique will work in ksh, but since there are going to be array
  # subscripts larger than 1024, bash is the way to go.
  #ps -ef | grep -v "^UID" | while read line
  while read line
  do
    # 进程表中的一些条目可能在显示运行命令的输出中包含大于号(>).必须对
    # 这个字符(它表示重定向到shell)进行转义处理,否则可能会导致脚本运行失常.
    line=`echo "$line" | sed -e s/\>/\\\\\\>/g`
    #echo $line
    # works in ksh/pdksh as long as the subscript is below 1024.. here it is not
    # bash works fine though.
    #set -A process $line for a ksh script
    declare -a process=( $line ) #定义数组,保存ps命令输出行的元素  
    pid=${process[1]} # 这是数组保存进程信息的地方,这些数组使用pid来索引
    owner[$pid]=${process[0]}
    ppid[$pid]=${process[2]}
    # command保存每一个运行进程执行的命令
    # 因为事先无法预知命令会占用多少个用空格分开的域,它使用NF控制循环
    command[$pid]="`echo $line | awk '{for(i=8;i<=NF;i++) {printf "%s ",$i}}'`"
    # child数组是使用pid来索引的,它的每一个元素包含了一组相应进程的子进程的pid
    3 这个赋值在它的父进程的孩子列表中增加了当前进程的pid,因此可以用pid作为下标访问其子进程
    children[${ppid[$pid]}]="${children[${ppid[$pid]}]} $pid"
  done <<EOF #进程表的文件处理被重定向到来自后端的循环
  $PSOUT
  EOF

# something about the arrays is that the values seem to be only good in the
# above loop.  This is a known issue with bash that all the piped elements
# are in subshells and their variables aren't available to the parent shell.
# Take the pipe out of the equation and send it to a file, then redirect
# the file into the end of the while loop.
  print_tree $proc ""

}

print_tree () {

id=$1

echo "$2$id" ${owner[$id]} ${command[$id]}

if [ "${children[$id]}" = "" ]
then # 如果当前进程没有子进程,函数将终止,返回到调用进程,处理下一个树分支
  return 
else # 如果当前进程有子进程,则遍历子进程列表
  for child in ${children[$id]}
  do
    # 确定当前子进程是否是子进程数组中最后一个.
    if [ "$child" = "`echo ${children[${ppid[$child]}]} | awk '{print $NF}'`" ]
    then # 如果是.则在屏幕上打印出一个终止分支字符(\)
      echo "$2 \\"
      temp="$2  "
    else
      echo "$2|\\"
      temp="$2|  "
    fi
    # 使用当前子进程pid和新的前缀字符串作为参数来递归调用该函数
    print_tree $child "$temp"
  done
fi

}

main
```