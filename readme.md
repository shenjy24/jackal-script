#### 一. 搜索脚本

`sep.sh` 结合 `find` 和 `egrep` 指令，在目录中检索包含搜索关键词的文件信息。

使用方式如下:

```
#加载函数脚本，只需加载一次
source sep.sh
#在当前路径下的packages、frameworks目录中的所有.java和.aidl文件中搜索ITelecomService.Stub
sep "ITelecomService.Stub" -t java aidl -f packages/ frameworks/ 
```

参考链接：[Linux搜索命令find和grep使用总结](https://www.jianshu.com/p/b30a8aa4d1f1)
