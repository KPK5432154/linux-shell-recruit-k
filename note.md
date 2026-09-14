
# 这是关于做本题时的记录
一开始没看到，我还自己建了一个work_log_k.md（(lll￢ω￢)

## 2026.9.13  
关于指令
```
第一次进入仓库后，先执行：

chmod +x check.sh tools/check-project scripts/start-workers.sh scripts/worker.sh  
```  
这是一个改变文件权限的命令
```
chmod ->change mode  //改变文件能被使用的权限
+ x  ->execute  //加上可运行权限  
ps: 
+ r ->read  //读取
+ w ->write  //写  

check.sh 
tools/check-project 
scripts/start-workers.sh 
scripts/worker.sh
  //给这四个文件改变权限
```
是的，写完这段记录，我就忘记使用chmod了.....  ~~（鱼的记忆~~
所以我知道不写会发生什么：“权限不够”

关于  
```  
ls
```  
这是一个用于查看文件夹目录的指令
```  
ls ->list //打印列表
``` 
## 关于01任务
我看见题目提示的“可能不是默认可见文件”，所以我直接去/workspace中发现了.project,并且找到了metadata,但我又想起题目是教会怎么探索一个陌生项目，一个陌生项目文件肯定没有这个例子这么少，所以应该是有相应的 **指令**。（只能说还是图形界面和用鼠标习惯了(´～`)  

所以我去询问了ai关于
```
pwd、ls、cd、find、grep、cat、隐藏文件、相对路径与绝对路径。
```
得出结论，原来是使用grep来根据文件内容找文件。（对比find是根据文件名
  
  ```
grep "关键词" 文件//grep 根据关键词 在哪里找
  ```
```
-r	recursive	递归搜目录下所有文件
-l	files with matches	只输出文件名，不输出匹配行
-n	line number	显示行号
-i	ignore case	忽略大小写
-c	count	只输出匹配行数
```
一开始输入
```
grep -r "PROJECT_ID" /workspace
grep: /workspace: 没有那个文件或目录
```

因为/放在前面强调根目录下，放后面强调这是个目录，本题是从当前目录开始，所以不用前面加/或者前面加./
|写法|路径|含义|
|---|---|---|
|workspace/	|相对路径	|当前目录下的 workspace|
|./workspace/	|相对路径	|同上，./ 更明确|
|~/C_learning/.../workspace/	|绝对路径|（用 ~）从你家目录算起|
|/home/kpk001/C_learning/.../workspace/	|绝对路径	|从根目录算起|
|/workspace	|绝对路径	|根目录下的 workspace（通常不存在）|  
```
grep -r "PROJECT_ID" workspace/
workspace/.project/metadata:PROJECT_ID=LSR-2026-0831
```


既然是shell，所以我查找到两种指令来输入  
```
echo "EXAMPLE-123" > output/01_project_id.txt//使用>>就是追加，>是覆盖

cat > output/01_project_id.txt
# 输入 EXAMPLE-123，回车，Ctrl+D
```
并且因为我事先看过那个文件夹，所以我知道没有这个文件，我输入前很好奇会返回什么：  
是找不到？还是error？结果都不是。。。  
它自己建了一个文件。。。

## 关于02任务   
`ls -l`可以打印该文件不同使用者的权限，
`./`是在当前目录下
`command -v`  用于查找某个命令是不是别名，shell内置命令，函数，是否在PATH中
`export`    可以添加某个文件夹到PATH（临时或者永久，永久必须.bashrc

```
export PATH="$PATH:$PWD/XXX" //意思是新路径=旧路径+某个文件夹绝对路径（：意思是分隔开的不同段）
```

## 关于03任务  9.14
``` 
find   //根据文件名找文件  
grep  //根据文件内容找文件  
sort  //根据字典顺序或者变形排序  
uniq  //去除相邻的相同内容  
``` 
我最开始用的  
```
grep -rlE  "TODO|FIXME" ./workspace/project/ |sort -u >output/03_code_search.txt  
输出是：  
[FAIL] 03 Code Search
./workspace/project/main.py
./workspace/project/utils/helper.py
```
这个无法通过,但是下面这个通过了：   
```  
grep -rlE  "TODO|FIXME" workspace/project/ |sort -u >output/03_code_search.txt
 ./check.sh 03
[PASS] 03 Code Search    
cat output/03_code_search.txt
workspace/project/main.py
workspace/project/utils/helper.py
```
区别就在有没有"./"  
./的意识是当前目录，如果grep等输出前用了./输出结果也会有  
## 关于04任务  9.14
```
wc 是 word count 的缩写，在 Unix/Linux 系统中用于统计行数、单词数、字节数或字符数。它既能处理文件，也能处理来自标准输入或管道的数据，非常适合日志分析、数据统计等场景。

基本语法：

wc [选项] [文件...]  
-l //行数  line
-w  //单词数  word
-c  //字节数  charactors
```
1. 尝试通过grep先找到在哪，再根据wc计算条数最后输出到txt文件  
``` 
grep "ERROR"  logs/server.log | wc -l
7
grep -c "ERROR"  logs/server.log  
7  
```    
2. 说是去重再按字典序实际上应该先按字典序再去重，因为uniq只去相邻  
需要用户名，题目中没有，我打算使用cat去文件中找，但ai推荐我用head只找前几行。  
```   
2026-08-31 10:00:01 INFO user=alice action=login
2026-08-31 10:00:05 INFO user=bob action=login
2026-08-31 10:01:11 ERROR user=bob code=500
2026-08-31 10:01:35 WARN user=carol code=401
2026-08-31 10:02:03 ERROR user=alice code=404  
``` 
我尝试使用  
`grep  "ERROR"  logs/server.log| grep -o "user=[^ ]*"|sort |uniq `
但是输出`user=alice` ,根据一开始的提示我将尝试 `cut`  
```  
cut 命令是一个强大的文本处理工具，用于从文件或标准输入中剪切字节、字符和字段，并将结果输出到标准输出。它可以根据指定的分隔符、字节位置或字符位置来剪切文本。

基本语法

cut [选项] [文件]
复制
常用选项包括：

-b：按字节剪切。

-c：按字符剪切。

-d：指定分隔符，默认为制表符。
```
所以我将试试` cut -d= -f2  //从“=”处分开，取第二部分-d = delimiter，分隔符-f = field，字段（第几段）

