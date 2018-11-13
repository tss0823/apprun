#!/usr/local/Cellar/bash/4.4.23/bin/bash
#
export LANG=en_US.UTF-8
paramNum=$#
if [ $paramNum -lt 2 ]
then
echo "usage deploy.sh appName env [branch]"
exit 0
fi

appName=$1
appEnv=$2
branch=$2
if [ "$3" != "" ]
then
branch=$3
fi
jsessionId="1k2ex2go802jq14i4mxyj3bsst"
if [ "${appEnv}" != "daily" ]; then
## 获取cookie
cookieFile="/tmp/cookie.txt"

curl -c "${cookieFile}" -I 'http://jenkins.meitu-int.com/j_acegi_security_check' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Origin: http://jenkins.meitu-int.com' -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: http://jenkins.meitu-int.com/login?from=%2F' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8' -H 'Cookie: _ga=GA1.2.1246920482.1536062097; screenResolution=1440x900; JSESSIONID.395c9935=1gdggnkwf5unt7ouqva46cctt; JSESSIONID.9172d379=kdbd10u0epnc7mtxh6zkt6l3; JSESSIONID.6260918c=1ikhli10860izivy2tzevcu1m; JSESSIONID.4cff748d=xloumxf8mvb87m7oydigqm23; JSESSIONID.68d1c8ae=1bee5yerxpnn6o6u9sh8iic17; JSESSIONID.b145fce4=15jrer2a0e0moetcbs8r3w5sj; hudson_auto_refresh=false; jenkins-timestamper-offset=-28800000; JSESSIONID.1e061871=1nw2vs1nz8oj6xbczx0okfm2c' --data 'j_username=tss%40meitu.com&j_password=XmmIGkXHD9sYpKT&from=%2F&json=%7B%22j_username%22%3A+%22tss%40meitu.com%22%2C+%22j_password%22%3A+%22XmmIGkXHD9sYpKT%22%2C+%22remember_me%22%3A+false%2C+%22from%22%3A+%22%2F%22%7D&Submit=%E7%99%BB%E5%BD%95' --compressed

if [ "${appEnv}" == "release" ]; then
branch="master"
fi
echo "deploy ${appEnv}.${appName}.${branch}"
#curl -b "${cookieFile}" -i -s -k "http://jenkins.meitu-int.com/job/mtmz/job/${appName}-k8s/build?delay=0sec" -H "Connection: keep-alive" -H "Pragma: no-cache" -H "Cache-Control: no-cache" -H "Origin: http://jenkins.meitu-int.com" -H "Upgrade-Insecure-Requests: 1" -H "Content-Type: application/x-www-form-urlencoded" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" -H "Referer: http://jenkins.meitu-int.com/job/mtmz/job/${appName}-k8s/build?delay=0sec" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: zh-CN,zh;q=0.9,en;q=0.8" -H "Cookie: screenResolution=1440x900; _ga=GA1.2.1246920482.1536062097; screenResolution=1440x900; ACEGI_SECURITY_HASHED_REMEMBER_ME_COOKIE=dHNzQG1laXR1LmNvbToxNTM5ODI4NDMwNzg3OjViZjUzMTdmOWMyNjNjMWMyNWVkMDllZDJkM2M3NmMxZTc3OGRkYzUyNWYxMzFkODgxNGU1ZDBmNzkxNDhmZTI=; JSESSIONID.395c9935=${jsessionId}" --data "name=env&value=${appEnv}&name=branch&value=${branch}&name=version&value=1.0.0&statusCode=303&redirectTo=.&json=%7B%22parameter%22%3A+%5B%7B%22name%22%3A+%22env%22%2C+%22value%22%3A+%22${appEnv}%22%7D%2C+%7B%22name%22%3A+%22branch%22%2C+%22value%22%3A+%22${branch}%22%7D%2C+%7B%22name%22%3A+%22version%22%2C+%22value%22%3A+%221.0.0%22%7D%5D%2C+%22statusCode%22%3A+%22303%22%2C+%22redirectTo%22%3A+%22.%22%7D&Submit=%E5%BC%80%E5%A7%8B%E6%9E%84%E5%BB%BA" --compressed

curl -b "${cookieFile}" "http://jenkins.meitu-int.com/job/mtmz/job/${appName}/build?delay=0sec" -H "Connection: keep-alive" -H "Pragma: no-cache" -H "Cache-Control: no-cache" -H "Origin: http://jenkins.meitu-int.com" -H "Upgrade-Insecure-Requests: 1" -H "Content-Type: application/x-www-form-urlencoded" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" -H "Referer: http://jenkins.meitu-int.com/job/mtmz/job/${appName}/build?delay=0sec" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: zh-CN,zh;q=0.9,en;q=0.8" -H "Cookie: screenResolution=1440x900; _ga=GA1.2.1246920482.1536062097; screenResolution=1440x900; JSESSIONID.395c9935=1gdggnkwf5unt7ouqva46cctt; JSESSIONID.9172d379=kdbd10u0epnc7mtxh6zkt6l3; JSESSIONID.6260918c=1ikhli10860izivy2tzevcu1m; JSESSIONID.4cff748d=xloumxf8mvb87m7oydigqm23; JSESSIONID.68d1c8ae=1bee5yerxpnn6o6u9sh8iic17; JSESSIONID.b145fce4=15jrer2a0e0moetcbs8r3w5sj; hudson_auto_refresh=false; JSESSIONID.1e061871=${jessionId}; ACEGI_SECURITY_HASHED_REMEMBER_ME_COOKIE=dHNzQG1laXR1LmNvbToxNTQyMDk1NDQ4OTkzOmIzMjAyMzYxY2FhMzNkZDFjMTMzYzNjZDVhMWZmOGM0Y2Y2YzZhOGQwZTcyNzljY2E1MjNjYzQ1MTE1M2ZlMWM=" --data "name=env&value=${appEnv}&name=branch&value=${branch}&name=version&value=1.0.2&statusCode=303&redirectTo=.&json=%7B%22parameter%22%3A+%5B%7B%22name%22%3A+%22env%22%2C+%22value%22%3A+%22${appEnv}%22%7D%2C+%7B%22name%22%3A+%22branch%22%2C+%22value%22%3A+%22${branch}%22%7D%2C+%7B%22name%22%3A+%22version%22%2C+%22value%22%3A+%221.0.2%22%7D%5D%2C+%22statusCode%22%3A+%22303%22%2C+%22redirectTo%22%3A+%22.%22%7D&Submit=%E5%BC%80%E5%A7%8B%E6%9E%84%E5%BB%BA" --compressed
else
#declare -A map=(["darwin"]="8116" ["crawler"]="8107" ["itemcenter"]="8095"  ["cms"]="8082")
#httpPort=${map[${appName}]}

declare -A map=(["darwin"]="8116" ["crawler"]="8107" ["itemcenter"]="8095" ["cms"]="8082" ["darwin-query"]="8117")
httpPort=${map[${appName}]}
echo "deploy daily ${httpPort}..${appName}"
#curl -i -s -k  -X "POST" -H "Host: daily.jenkins.meipu.cn" -H "Cache-Control: max-age=0" -H "Origin: http://daily.jenkins.meipu.cn" -H "Upgrade-Insecure-Requests: 1" -H "Content-Type: application/x-www-form-urlencoded" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" -H "Referer: http://daily.jenkins.meipu.cn/job/${appName}/build?delay=0sec" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: zh-CN,zh;q=0.9,en;q=0.8" -H "Cookie: screenResolution=1440x900; jenkins-timestamper-offset=-28800000; hudson_auto_refresh=false; UM_distinctid=164d66aac282cc-0f498c19f7a34-163e6952-13c680-164d66aac291ca; JSESSIONID.ee80da7d=node0awguw5qtnueo1ko3xj1v8vxt82262.node0" -H "Connection: close" --data-binary "name=env&value=dev&name=branch&value=daily&name=port&value=${httpPort}&name=dubboPort&value=9115&statusCode=303&redirectTo=.&Jenkins-Crumb=1580ed89ea4713af6e0aa019141fb67d&json=%7B%22parameter%22%3A+%5B%7B%22name%22%3A+%22env%22%2C+%22value%22%3A+%22dev%22%7D%2C+%7B%22name%22%3A+%22branch%22%2C+%22value%22%3A+%22daily%22%7D%2C+%7B%22name%22%3A+%22port%22%2C+%22value%22%3A+%22${httpPort}%22%7D%2C+%7B%22name%22%3A+%22dubboPort%22%2C+%22value%22%3A+%229115%22%7D%5D%2C+%22statusCode%22%3A+%22303%22%2C+%22redirectTo%22%3A+%22.%22%2C+%22Jenkins-Crumb%22%3A+%221580ed89ea4713af6e0aa019141fb67d%22%7D&Submit=%E5%BC%80%E5%A7%8B%E6%9E%84%E5%BB%BA" "http://daily.jenkins.meipu.cn/job/${appName}/build?delay=0sec"
curl -i -s -k  -X 'POST' -H 'Host: daily.jenkins.meipu.cn'  -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Origin: http://daily.jenkins.meipu.cn' -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.75 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: http://daily.jenkins.meipu.cn/job/darwin/build?delay=0sec' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8' -H 'Cookie: screenResolution=1440x900; jenkins-timestamper-offset=-28800000; hudson_auto_refresh=false; UM_distinctid=164d66aac282cc-0f498c19f7a34-163e6952-13c680-164d66aac291ca; JSESSIONID.ee80da7d=node0awguw5qtnueo1ko3xj1v8vxt82262.node0' -H 'Connection: close' --data-binary "name=env&value=dev&name=branch&value=daily&name=port&value=${httpPort}&name=dubboPort&value=9115&statusCode=303&redirectTo=.&Jenkins-Crumb=1580ed89ea4713af6e0aa019141fb67d&json=%7B%22parameter%22%3A+%5B%7B%22name%22%3A+%22env%22%2C+%22value%22%3A+%22dev%22%7D%2C+%7B%22name%22%3A+%22branch%22%2C+%22value%22%3A+%22daily%22%7D%2C+%7B%22name%22%3A+%22port%22%2C+%22value%22%3A+%22${httpPort}%22%7D%2C+%7B%22name%22%3A+%22dubboPort%22%2C+%22value%22%3A+%229115%22%7D%5D%2C+%22statusCode%22%3A+%22303%22%2C+%22redirectTo%22%3A+%22.%22%2C+%22Jenkins-Crumb%22%3A+%221580ed89ea4713af6e0aa019141fb67d%22%7D&Submit=%E5%BC%80%E5%A7%8B%E6%9E%84%E5%BB%BA" 'http://daily.jenkins.meipu.cn/job/darwin/build?delay=0sec'
fi

#while [[ ${result} != "ok" ]]
#do
#    result=`curl ${cms_url}/serviceStatus`
#    sleep 1
#done
