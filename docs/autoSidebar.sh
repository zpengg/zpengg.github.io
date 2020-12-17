set -euxo
makeSidebar() {
    target = "README.md"
    autoTag = "<!--auto-->"
    sidebarFile = $1"/"$base"/$target"
    if [ -e $sidebarFile ];then
        if [ cat $sidebarFile|sed -n '1p' !=  $autoTag];then
            return 
        fi
    fi
    echo $1
    echo "[{$sidebarFile}](\/$base\/$1)"
    # rm -f $target
    # touch $target
    # sed "$a/$autoTag" $target
    # for file in `ls -a`
    #     do
    #         if [ -f $1"/"$base"/"$file && $file != $target];then
    #             sed "$a/[{$file}](\/$base\/$file)" $target
    #         fi
    # done
}

auto() {
    for file in `ls -a $1`
    do
        # 目录存在
        if [ -d $1"/"$file ];then
            if [ $file:0:0 != "." ];then 
                cd $file
                makeSidebar $file
                cd ..
            fi      
        else    
            echo $1"/"$file
        fi      
    done    
    
}
auto .