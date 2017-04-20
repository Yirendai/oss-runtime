export EUREKA_INSTANCE_NONSECUREPORT=8989
export LOCAL_EUREKA_STANDALONE=yrd-eureka-peer1
export EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://yrd-eureka-peer1.oss.yixinonline.org:8761/eureka,http://yrd-eureka-peer2.oss.yixinonline.org:8761/eureka,http://yrd-eureka-peer3.oss.yixinonline.org:8761/eureka
export EUREKA_INSTANCE_HOSTNAME=yrd-turbine.oss.yixinonline.org
docker-compose up -d
