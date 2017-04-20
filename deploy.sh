#!/usr/bin/env bash
#远程部署用户名
REMOTE_USER=root
YRD_OSS_VERSION=latest
SUB_MODULE_DIR=./

function deploySingleService(){
    # 临时变量特定机器环境文件
    COMMON_ENV=${SUB_MODULE_DIR}/environments/$ENVIRONMENT/common_env
    CONFIG_FILE=${SUB_MODULE_DIR}/environments/$ENVIRONMENT/${REMOTE_HOST}
    DOCKER_FILE=${SUB_MODULE_DIR}/${COMPOSE_FILE_NAME}

    echo '*. 准备部署服务'${REMOTE_USER}@${REMOTE_HOST}
    ssh ${REMOTE_USER}@${REMOTE_HOST} "if ! test -d /tmp/${SUB_MODULE_DIR}; then mkdir /tmp/${SUB_MODULE_DIR}; fi;"

    # 将compose文件scp到远程
    scp -r ./${SUB_MODULE_DIR}/*.yml ${REMOTE_USER}@${REMOTE_HOST}:/tmp/${SUB_MODULE_DIR}/

    # 将环境变量scp到远程

    scp -r ./${CONFIG_FILE} ${REMOTE_USER}@${REMOTE_HOST}:/tmp/${SUB_MODULE_DIR}

    if [ -f ./${COMMON_ENV} ];then
        echo '*. 复制公共配置'
        scp -r ./${COMMON_ENV} ${REMOTE_USER}@${REMOTE_HOST}:/tmp/${SUB_MODULE_DIR}
        ssh ${REMOTE_USER}@${REMOTE_HOST} "cat /tmp/${SUB_MODULE_DIR}/common_env  >> /tmp/${SUB_MODULE_DIR}/${REMOTE_HOST}"
    fi

    # 停止当前应用
    echo '*. 预停止当前应用'
    ssh ${REMOTE_USER}@${REMOTE_HOST} "echo -e '\n docker-compose -f /tmp/$DOCKER_FILE down --remove-orphans' >> /tmp/${SUB_MODULE_DIR}/${REMOTE_HOST}"
    # 等待服务停止
    # 拉取最新
    echo '*. 预拉取最新镜像'
    ssh ${REMOTE_USER}@${REMOTE_HOST} "echo -e '\n docker-compose -f /tmp/$DOCKER_FILE pull' >> /tmp/${SUB_MODULE_DIR}/${REMOTE_HOST}"
    # 启动新服务
    echo '*. 预启动服务'
    ssh ${REMOTE_USER}@${REMOTE_HOST} "echo -e '\n docker-compose -f /tmp/$DOCKER_FILE up -d' >>/tmp/${SUB_MODULE_DIR}/${REMOTE_HOST}"

    #执行
    echo '*. 开始执行'
    ssh ${REMOTE_USER}@${REMOTE_HOST} "cat /tmp/${SUB_MODULE_DIR}/${REMOTE_HOST} && sh /tmp/${SUB_MODULE_DIR}/${REMOTE_HOST}"


    # 找到container_name
    # 检查进程
    # ssh ${REMOTE_USER}@${REMOTE_HOST} docker ps | grep
    # 检查日志
    echo -e '5. 部署完成'${REMOTE_USER}@${REMOTE_HOST}'\n \n \n'
}
function deployAll(){
    case $ENVIRONMENT in
        "product")
            REMOTE_HOSTS=${PRODUCT_REMOTE_HOSTS[*]}
            ;;

        "dev")
            REMOTE_HOSTS=${DEV_REMOTE_HOSTS[*]}
            ;;
        *)
        echo -e "Usage: $0 param
        param are follows:
        export ENVIRONMENT=
            product
            dev
            "
            ;;
    esac

    echo ${REMOTE_HOSTS}

    # 遍历机器列表,执行部署
    for REMOTE_HOST in ${REMOTE_HOSTS[*]}
        do echo 'deploySingleService-----------------------------'${SUB_MODULE_DIR}'@'${REMOTE_HOST}
        deploySingleService
    done
}
function needDeploy() {
    echo 'start deploy: '$ENVIRONMENT:$YRD_OSS_VERSION
    for dir in *
    do
        if test -d $dir
        then
            if [ -f $dir/environments/"environment.sh" ];then
                echo '存在部署脚本脚本' $dir/environments/"environment.sh"
                source $dir/environments/environment.sh
                SUB_MODULE_DIR=$dir
                deployAll
            fi
        fi
    done
}


# 判断构建环境
#ENVIRONMENT=$1
#YRD_OSS_VERSION=$2
needDeploy






