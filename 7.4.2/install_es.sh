#!/bin/bash

if [ -z "$JAVA_HOME" ]
then
  echo "JAVA_HOME is not set. Please ensure JDK 12 is installed."
  # curl -L -O https://github.com/AdoptOpenJDK/openjdk12-binaries/releases/download/jdk-12.0.2%2B10/OpenJDK12U-jdk_ppc64le_linux_hotspot_12.0.2_10.tar.gz
  exit 1
fi

echo "Fetching Elasticsearch 7.4.2"
cp ./0001-package-building-for-ppc64le.patch /tmp
cd /tmp && curl -L -O https://github.com/elastic/elasticsearch/archive/v7.4.2.tar.gz
tar xzvf v7.4.2.tar.gz && cd elasticsearch-7.4.2
patch -p1 < /tmp/0001-package-building-for-ppc64le.patch

echo "Building Elasticsearch"
./gradlew assemble --refresh-dependencies

echo "Installing Elasticsearch"
tar -C /usr/share/ -xf ./distribution/archives/oss-no-jdk-linux-tar/build/distributions/elasticsearch-oss-7.4.2-SNAPSHOT-no-jdk-linux-x86_64.tar.gz
mv /usr/share/elasticsearch-7.4.2-SNAPSHOT /usr/share/elasticsearch
cd /usr/share/elasticsearch/lib && curl -O -L https://repo1.maven.org/maven2/net/java/dev/jna/jna/4.5.1/jna-4.5.1.jar

groupadd elasticsearch && useradd elasticsearch -g elasticsearch
chown -R elasticsearch:elasticsearch /usr/share/elasticsearch

echo "You now can start Elasticsearch by running /usr/share/elasticsearch/bin/elasticsearch"
