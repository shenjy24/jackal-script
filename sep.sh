#文件内容搜索函数sep
#参数1 必选 搜索内容
#参数2 可选 前缀-t 内容所在的文件类型（即文件后缀名，如java），缺省为所有文件类型
#参数3 可选 前缀-f 指定搜索的目录 缺省为当前目录及所有子目录
#用例 sep "ITelecomService.Stub"  -t  java aidl -f  packages/ frameworks/ 
#用例解析 在packages、frameworks目录中的所有java、aidl文件中搜索"ITelecomService.Stub"
function sep()
{
    #文件内容=第一个参数
    se_content=$1
    #文件类型和搜索目录暂时=空
    se_fileType=""
    se_folder=""
    #shift的作用是将第一个参数移除，即当前函数输入的第二个参数变成第一个参数，第三个变成第二个，以此类推
    shift
    #判断当前第一个参数是否为-t，即文件类型是否指定，如果指定就取出文件类型放入se_fileType变量中
    if [ "$1" = "-t" ];then
        #如果是-t就将这个参数移除
        shift
        while ( [ "$1" != "-f" ] && [ -n "$1" ] )
        do
            se_fileType="$se_fileType $1"
            shift
        done
    fi
    #判断当前第一个参数是否为-f，即搜索目录是否指定，如果指定就取出搜索目录放入se_folder变量中
    if [ "$1" = "-f" ];then
        #如果是-f就将这个参数移除
        shift
        while [ -n "$1" ]
        do
            se_folder="$se_folder $1"
            shift
        done
    fi
    #判断文件类型是否为空，不为空则建立循环分别搜索指定的文件类型
    if [ -z $se_fileType ];then
        #这里如果搜索目录为空find会自动搜索当前目录及子目录，因此不用再做判断
        #这里用到了egrep而不是grep，方便输入搜索内容时直接使用正则表达式
        find $se_folder -type f -print0 | xargs -0 egrep --with-filename -n --color "$se_content"
    else
        for ft in $se_fileType
        do
            find $se_folder -type f -name "*.$ft" -print0 | xargs -0 egrep --with-filename -n --color "$se_content"
        done
    fi
}
