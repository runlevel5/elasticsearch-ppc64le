FROM adoptopenjdk/openjdk12:debian AS builder
COPY 0001-package-building-for-ppc64le.patch /tmp/
RUN apt-get update && apt-get install -y patch && \
    cd /tmp && curl -L -O https://github.com/elastic/elasticsearch/archive/v7.4.2.tar.gz && \
    tar xzvf v7.4.2.tar.gz && cd elasticsearch-7.4.2 && \
    patch -p1 < /tmp/0001-package-building-for-ppc64le.patch && \
    ./gradlew assemble --refresh-dependencies && \
    mv distribution/archives/oss-no-jdk-linux-tar/build/distributions/elasticsearch-oss-7.4.2-SNAPSHOT-no-jdk-linux-x86_64.tar.gz /opt && \
    rm -rf /tmp/* && rm -rf /var/lib/apt/lists/*

FROM adoptopenjdk/openjdk12:debian-jre
COPY --from=builder /opt/elasticsearch-oss-7.4.2-SNAPSHOT-no-jdk-linux-x86_64.tar.gz /tmp
RUN tar -C /usr/share/ -xf /tmp/elasticsearch-oss-7.4.2-SNAPSHOT-no-jdk-linux-x86_64.tar.gz && \
mv /usr/share/elasticsearch-7.4.2-SNAPSHOT /usr/share/elasticsearch && \
cd /usr/share/elasticsearch/lib && curl -O -L https://repo1.maven.org/maven2/net/java/dev/jna/jna/4.5.1/jna-4.5.1.jar && \
groupadd elasticsearch && useradd elasticsearch -g elasticsearch && \
chown -R elasticsearch:elasticsearch /usr/share/elasticsearch && \
rm /tmp/elasticsearch-oss-7.4.2-SNAPSHOT-no-jdk-linux-x86_64.tar.gz

USER elasticsearch
ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]
