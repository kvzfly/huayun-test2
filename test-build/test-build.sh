#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.0.35:80/python-redis-demo:${BUILD_NUMBER} .

docker push 192.168.0.35:80/python-redis-demo:${BUILD_NUMBER}
cd ${WORKSPACE}/test-build

sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
chmod 777 ./rancher-compose

./rancher-compose --access-key A334716B54CF92223F44 --secret-key hpxZC5qU5aJzpA8j3uAFHbKByvBr9hgcnQ17DQzp -p python-redis-demo-build${BUILD_NUMBER} up -d

