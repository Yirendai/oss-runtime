# configserver 开发文档

## 构建docker镜像

    DOCKER_HOST=unix:///var/run/docker.sock mvn -Dmaven.test.skip=true clean package docker:build docker:push

## docker镜像debug

    docker run --rm -it \
        -e GIT_HOST=local-git \
        --network yrd-oss-network \
        --link yrdconfigserver_git_1:local-git \
        -v /root/data/configserver \
        -v ${HOME}/ws/architecture/common-config:/root/workspace/common-config \
        -v ${HOME}/ws/architecture/yrd-todomvc-app-config:/root/workspace/yrd-todomvc-app-config \
        -v ${HOME}/ws/architecture/yrd-todomvc-thymeleaf-config:/root/workspace/yrd-todomvc-thymeleaf-config \
        registry.docker.local/yrd-configserver \
        shell
