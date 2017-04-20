#!/usr/bin/env bash

MAVEN_PACKAGE="apache-maven-3.3.9"
GRADLE_PACKAGE="gradle-3.3"

MAVEN_BALL="${MAVEN_PACKAGE}-bin.tar.gz"
GRADLE_BALL="${GRADLE_PACKAGE}-bin.zip"

wget -q -O ${MAVEN_BALL} ${build_fileserver}/apache/maven/maven-3/3.3.9/binaries/${MAVEN_BALL}
wget -q -O ${GRADLE_BALL} ${build_fileserver}/distributions/${GRADLE_BALL}

mkdir -p /opt
tar xf ${MAVEN_BALL} -C /opt && ln -sf /opt/${MAVEN_PACKAGE} /opt/maven && rm ${MAVEN_BALL}
unzip ${GRADLE_BALL} && mv ${GRADLE_PACKAGE} /opt && ln -sf /opt/${GRADLE_PACKAGE} /opt/gradle && rm ${GRADLE_BALL}
