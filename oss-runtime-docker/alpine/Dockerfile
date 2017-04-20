
FROM alpine:3.4

# see: http://wiki.alpinelinux.org/wiki/Setting_the_timezone
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main" > /etc/apk/repositories && \
    echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/community" >> /etc/apk/repositories && \
    echo "https://mirror.tuna.tsinghua.edu.cn/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk --update add tzdata && \
    apk add libstdc++ bash curl && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /tmp/* /var/cache/apk/* && \
    echo "UTC+8:00" > /etc/TZ
# 设置时区 中国的时区有多种表述 分别为: UTC+8:00 GMT+8
# 写/etc/TZ, 不要设置TZ环境变量 ENV TZ UTC+8:00

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
