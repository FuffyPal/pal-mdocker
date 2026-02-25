FROM docker.io/library/eclipse-temurin:21-jre-noble

WORKDIR /data

RUN apt-get update && apt-get install -y tini && rm -rf /var/lib/apt/lists/*

RUN curl -o /purpur.jar https://api.purpurmc.org/v2/purpur/1.21.4/latest/download

COPY scripts/entrypoint_smp.sh /entrypoint_smp.sh
RUN chmod 755 /entrypoint_smp.sh

EXPOSE 25565

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint_smp.sh"]