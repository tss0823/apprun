#!/bin/bash
#git batch execute
#合并分支，可以用于开发分支合并到测试分支，测试分支合并的master,或者fixbug分支直接合并到master

#execute function
function exec_cmd(){
e_cmd=$@
echo "exec cmd=${e_cmd}";
eval ${e_cmd}
#if [ $? != 0 ]
#then
#echo "execute ${e_cmd} failed!"
#exit 0
#fi
}

#main start
paramNum=$#
if [ $paramNum -lt 2 ]
then
echo "usage merge from_branch to_branch1,to_branch2"
exit 0
fi


from_br=$1

toBrs=$2

cmd_co_dev="git checkout ${from_br}"

#check dev branch
exec_cmd ${cmd_co_dev}
git pull

#git add . & git commit -a
cmd_add_and_ci="git add . && git commit -a";
exec_cmd ${cmd_add_and_ci}
read -s -p "you want to push ${from_br}?(y/n):" ret
echo "input=$ret"
case $ret in
N | n)
      echo "$from_br not push";;
*)
exec_cmd "git push";;
esac

toBranchMap=`echo "${toBrs}" | sed "s/,/ /g"` 

for to_br in $toBranchMap; do

#merge to test
cmd_co_test="git checkout ${to_br}";
exec_cmd ${cmd_co_test}
exec_cmd "git pull"

cmd_merge_to_test="git merge ${from_br}"
exec_cmd ${cmd_merge_to_test}

#mvn deploy,for rpc call
read -s -p "you want to skip deploy for rpc ?(y/n):" ret
echo "input=$ret"
case $ret in
N | n)
# 判断version是否正常
if [ "${to_br}" == "beta" ] || [ "${to_br}" == "release" ]
then
sed -i '' 's#\<maven\.dependency\.env\>[^<]*\<\/maven\.dependency\.env\>$#<maven.dependency.env>-RELEASE-SNAPSHOT</maven.dependency.env>#' pom.xml
else
sed -i '' 's#\<maven\.dependency\.env\>[^<]*\<\/maven\.dependency\.env\>$#<maven.dependency.env>-SNAPSHOT</maven.dependency.env>#' pom.xml
fi
##echo 1;;
exec_cmd "mvn deploy -f pom.xml";;
*)
      echo "skipped deploy";;
esac

#push test
read -s -p "you want to push ${to_br}?(y/n):" ret
echo "input=$ret"
case $ret in
N | n)
echo "your input ${ret},then break!"
git checkout $from_br;;
*)
exec_cmd "git push";;
esac

done

git checkout $from_br
echo "all finished, execute success!";
