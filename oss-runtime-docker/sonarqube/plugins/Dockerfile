
# see: https://github.com/MehrCurry/docker-sonar
# see: http://docs.sonarqube.org/display/PLUG/Plugin+Library
# install plugins, see: http://stackoverflow.com/questions/36376968/manually-installing-sonarqube-plugins-on-docker-image
# [Write SonarQube Plugin step by step](http://www.jianshu.com/p/4757cf99e661)

# Commercial Plugins
# http://www.contemplateltd.com/threadsafe
# http://structure101.com/help/java/build/#sonar/sonar.html

FROM alpine:3.4

ENV PLUGINS_DIR /opt/sonarqube/extensions/plugins

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.3/main" > /etc/apk/repositories && \
    echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.3/community" >> /etc/apk/repositories && \
    echo "https://mirror.tuna.tsinghua.edu.cn/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community bash wget aria2 ca-certificates && \
    rm -rf /tmp/* /var/cache/apk/*

# Copy the plugin (jar file) to $SONAR_INSTALL_DIR/extensions/plugins

WORKDIR $PLUGINS_DIR
COPY docker/plugins.sh /opt/sonarqube/extensions/plugins/plugins.sh
COPY docker/plugins.txt /opt/sonarqube/extensions/plugins/plugins.txt
RUN /opt/sonarqube/extensions/plugins/plugins.sh /opt/sonarqube/extensions/plugins/plugins.txt
VOLUME $PLUGINS_DIR

CMD ls -asl $PLUGINS_DIR
