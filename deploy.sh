#!/usr/local/Cellar/bash/4.4.23/bin/bash
#
export LANG=en_US.UTF-8
paramNum=$#
if [ $paramNum -lt 2 ]
then
echo "usage deploy.sh appName env"
exit 0
fi

appName=$1
appEnv=$2
if [ "${appEnv}" != "daily" ]; then
echo "deploy ${appEnv}.${appName}"
curl -i -s -k  -X "POST" -H "Host: jenkins.meitu-int.com" -H "Cache-Control: max-age=0" -H "Origin: http://jenkins.meitu-int.com" -H "Upgrade-Insecure-Requests: 1" -H "Content-Type: application/x-www-form-urlencoded" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" -H "Referer: http://jenkins.meitu-int.com/job/mtmz/job/${appName}-k8s/build?delay=0sec" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: zh-CN,zh;q=0.9,en;q=0.8" -H "Cookie: screenResolution=1440x900; screenResolution=1440x900; _ga=GA1.2.1947137775.1529412615; hudson_auto_refresh=false; ACEGI_SECURITY_HASHED_REMEMBER_ME_COOKIE=dHNzQG1laXR1LmNvbToxNTMyOTIzMTMwODcxOjZjZjZkYTRiY2RjNzVkODZmZTcwMzk4MjBkNjM4ODUxNDc3ZmM2MjQzNGE2YzIyYjg3YzUyNDJmYmUyMWZiNmE=; JSESSIONID.395c9935=mguguq8vhuly14gf4srwtworc" -H "Connection: close" --data-binary "name=env&value=${appEnv}&name=branch&value=${appEnv}&name=version&value=1.0.0&statusCode=303&redirectTo=.&json=%7B%22parameter%22%3A+%5B%7B%22name%22%3A+%22env%22%2C+%22value%22%3A+%22${appEnv}%22%7D%2C+%7B%22name%22%3A+%22branch%22%2C+%22value%22%3A+%22${appEnv}%22%7D%2C+%7B%22name%22%3A+%22version%22%2C+%22value%22%3A+%221.0.0%22%7D%5D%2C+%22statusCode%22%3A+%22303%22%2C+%22redirectTo%22%3A+%22.%22%7D&Submit=%E5%BC%80%E5%A7%8B%E6%9E%84%E5%BB%BA" "http://jenkins.meitu-int.com/job/mtmz/job/${appName}-k8s/build?delay=0sec"
else
declare -A map=(["darwin"]="8116" ["crawler"]="8107" ["itemcenter"]="8095"  ["cms"]="8082")
httpPort=${map[${appName}]}
echo "deploy ${httpPort}..${appName}"
curl -i -s -k  -X "POST" -H "Host: daily.jenkins.meipu.cn" -H "Cache-Control: max-age=0" -H "Origin: http://daily.jenkins.meipu.cn" -H "Upgrade-Insecure-Requests: 1" -H "Content-Type: application/x-www-form-urlencoded" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" -H "Referer: http://daily.jenkins.meipu.cn/job/${appName}/build?delay=0sec" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: zh-CN,zh;q=0.9,en;q=0.8" -H "Cookie: screenResolution=1440x900; jenkins-timestamper-offset=-28800000; hudson_auto_refresh=false; ACEGI_SECURITY_HASHED_REMEMBER_ME_COOKIE=dHNzOjE1MzMwMDYzODUzODc6ZWU3ZGU0N2I1ZDM1OTcyMWM2NzdjNjRlZjg4NGY3OGM3ZjlmMDZmZWU0ZDU2ZDFmNjhmMmRkZGU4OTI0NmVmZg==; JSESSIONID.ee80da7d=node01jeq0hdxgbtf0pb6kx5zbn23m2089.node0" -H "Connection: close" --data-binary "name=env&value=dev&name=branch&value=daily&name=port&value=${httpPort}&name=dubboPort&value=9115&statusCode=303&redirectTo=.&Jenkins-Crumb=1580ed89ea4713af6e0aa019141fb67d&json=%7B%22parameter%22%3A+%5B%7B%22name%22%3A+%22env%22%2C+%22value%22%3A+%22dev%22%7D%2C+%7B%22name%22%3A+%22branch%22%2C+%22value%22%3A+%22daily%22%7D%2C+%7B%22name%22%3A+%22port%22%2C+%22value%22%3A+%22${httpPort}%22%7D%2C+%7B%22name%22%3A+%22dubboPort%22%2C+%22value%22%3A+%229115%22%7D%5D%2C+%22statusCode%22%3A+%22303%22%2C+%22redirectTo%22%3A+%22.%22%2C+%22Jenkins-Crumb%22%3A+%221580ed89ea4713af6e0aa019141fb67d%22%7D&Submit=%E5%BC%80%E5%A7%8B%E6%9E%84%E5%BB%BA" "http://daily.jenkins.meipu.cn/job/${appName}/build?delay=0sec"
fi

#while [[ ${result} != "ok" ]]
#do
#    result=`curl ${cms_url}/serviceStatus`
#    sleep 1
#done