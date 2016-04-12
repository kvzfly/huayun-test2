#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.0.35:80/python-redis-demo:${BUILD_NUMBER} .

docker push 192.168.0.35:80/python-redis-demo:${BUILD_NUMBER}
cd ${WORKSPACE}/test-build

sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
chmod 777 ./rancher-compose

./rancher-compose --access-key 3066B53A898844468011 --secret-key RiehfecdpYi7Jf8p3UNkimXSt8wR7DomZSZ98oyZ -p python-redis-demo-build${BUILD_NUMBER} up -d

