
#### 比较的基本原理  

bash中,包括未引用,未定义的字符串变量的比较会返回错误信息"unary operator expected", 而ksh则会返回信息"argument expected".对包含空格
的未引用字符串的比较,bash会返回错误信息"too many arguments",
操作数和比较运算符之间的空格是可以任选的.  

test $debug -eq 1 && echo some_debug_output 只有test结果为真,测试条件逻辑与才会执行其他代码  
test $debug -eq 1 || echo some_debug_output 只有test结果为假,测试条件逻辑或才会执行其他代码  


 给单个命令加上花括号就可以组成符合命令.这样的组合可以包含任意数量的代码
[ $debug -eq 1 ] && {
	echo some_debug_output
	echo some_more_debug_output
}

判断字符串变量或数字变量是否已定义  
方法1  
if [ -n $string ];then...  

方法2  
if [ $any_variable ];then...     一旦变量被赋值,表达式就判定其为真


测试检查了一个命令的返回值  
if ping -c 3 node.mydomain.com > /dev/null 2>&1;then  
因为不需要根据命令的实际输出来确定系统是否应答,这也是要把所有输出重定向到/dev/null中的原因  