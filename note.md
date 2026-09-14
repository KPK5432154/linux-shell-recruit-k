
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


