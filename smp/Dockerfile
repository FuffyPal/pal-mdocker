FROM docker.io/library/eclipse-temurin:21-jre-alpine

RUN addgroup -S minecraft && adduser -S minecraft -G minecraft

WORKDIR /data

RUN apk add --no-cache curl bash python3

ARG PURPUR_VERSION=1.21.1
RUN curl -o server.jar https://api.purpurmc.org/v2/purpur/${PURPUR_VERSION}/latest/download

COPY ./smp/plugins /data/plugins
COPY ./smp/config /data/config
COPY ./scripts/smp/start.sh /data/start.sh

RUN echo "eula=true" > /data/eula.txt
RUN chown -R minecraft:minecraft /data && chmod +x /data/start.sh && chown minecraft:minecraft /data/eula.txt

USER minecraft

EXPOSE 25565

ENTRYPOINT ["/bin/bash", "/data/start.sh"]
