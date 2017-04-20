#!/bin/sh

# Java Version
JAVA_VERSION_MAJOR=8
JAVA_VERSION_MINOR=101
JAVA_VERSION_BUILD=13
JAVA_PACKAGE=jdk

# Download and unarchive Java
mkdir /opt && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
  ${build_fileserver}/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    | tar -xzf - -C /opt &&\
    ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk &&\
    rm -rf /opt/jdk/*src.zip \
           /opt/jdk/lib/missioncontrol \
           /opt/jdk/lib/visualvm \
           /opt/jdk/lib/*javafx* \
           /opt/jdk/jre/lib/plugin.jar \
           /opt/jdk/jre/lib/ext/jfxrt.jar \
           /opt/jdk/jre/bin/javaws \
           /opt/jdk/jre/lib/javaws.jar \
           /opt/jdk/jre/lib/desktop \
           /opt/jdk/jre/plugin \
           /opt/jdk/jre/lib/deploy* \
           /opt/jdk/jre/lib/*javafx* \
           /opt/jdk/jre/lib/*jfx* \
           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/jdk/jre/lib/amd64/libprism_*.so \
           /opt/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/jdk/jre/lib/amd64/libglass.so \
           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/jdk/jre/lib/amd64/libjfx*.so

POLICY_DIR="UnlimitedJCEPolicyJDK${JAVA_VERSION_MAJOR}" \
 && curl -s -k -L -C - -b "oraclelicense=accept-securebackup-cookie" \
 ${build_fileserver}/otn-pub/java/jce/${JAVA_VERSION_MAJOR}/jce_policy-${JAVA_VERSION_MAJOR}.zip > policy.zip \
 && unzip policy.zip \
 && cp -f ${POLICY_DIR}/US_export_policy.jar /opt/jdk/jre/lib/security/US_export_policy.jar \
 && cp -f ${POLICY_DIR}/local_policy.jar /opt/jdk/jre/lib/security/local_policy.jar \
 && rm -rf ${POLICY_DIR} \
 && rm -f policy.zip
