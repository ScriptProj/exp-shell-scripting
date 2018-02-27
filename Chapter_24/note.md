


```bash
#!/bin/bash
VAR="The quick brown fox jumped over the lazy dog."

# 显示特殊域
echo $VAR | awk '{print $1, $8, $4, $5, $6, $7, $3, $9}'
# The lazy fox jumped over the brown dog.

# 指定域分隔符  
echo $VAR | awk -Fo '{print $4}'  
# ver the lazy d

# 简单的模式匹配
# grep能很容易地返回与给定串匹配的行,但awk能返回在特定域中与特定的值相匹配的行
# 查找并显示/etc/hosts文件中第二个域等于casper串的所有行
awk '$2 == "casper" {print $0}' /etc/hosts
# 172.16.5.4 casper casper.mydomain.com

# 几个值的域匹配
# 在/etc/host中查找以127或者172开始的ip地址(在域1中),斜线间的每一个选择项用管道符号(|)分开  
awk '$1 ~ /^127|^172/ {print $0}' /etc/hosts
# 127.0.0.1 localhost
# 172.16.5.2 phred phred.mydomain.com
# 172.16.5.4 casper casper.mydomain.com









```