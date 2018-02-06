
#### 3.1.1  自从纪元以来天数  
```bash
# 只执行一次date调用,可得到以空格分开的值,然后把这些值填充到数组中
declare -a DATE=( `date +"%S %M %k %d %m %Y"` )
# 访问数组中第3个元素 
echo ${DATE[2]} 
```