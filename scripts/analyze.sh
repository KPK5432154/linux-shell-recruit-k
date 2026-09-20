#!/usr/bin/env bash

# Task 07: complete this script.
# Usage: ./scripts/analyze.sh FILE

# TODO: validate arguments      //是否有参数
# TODO: validate file existence //文件是否存在
# TODO: print:                  //输出结果  
# Total ERROR: <number>         //输出错误结果
# Top Code: <code>               //首行代码
  
# 必须从命令行参数读取日志路径，不能写死；//什么是日志路径？什么是写死？
# 没有参数时显示 Usage，并以非零状态退出；  
if [[ $# -ne 1 ]];  #注意空格
then 
echo "Usage";
exit 1;

# 文件不存在时给出错误提示并以非零状态退出；
elif [[ ! -e $1 ]]; 
then 
echo "FILE cannot be found";
exit 1;
    #文件不存在时又该以什么函数来判断,题目中给了提示(...)命令替换，或许我该尝试一下find？
else  

total=$(grep -c "ERROR" $1)
top_code=$(grep "ERROR" $1 | grep -o "code=[0-9]*" | cut -d= -f2 |sort |uniq -c |sort -rn|head -1 |awk '{print $2}' )  
echo "Total ERROR: $total"
echo "Top Code: $top_code"
exit 0;
# 正常输入应正确分析并成功退出。                  # 什么是正确分析呢

fi
