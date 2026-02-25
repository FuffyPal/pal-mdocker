FROM docker.io/library/eclipse-temurin:21-jre-noble

WORKDIR /data

RUN apt-get update && apt-get install -y tini curl && rm -rf /var/lib/apt/lists/*

RUN curl -o /velocity.jar https://fill-data.papermc.io/v1/objects/1fd6eb76330a21cf8307b1517ce5edf8914669966f99148e5fec0b178ba77686/velocity-3.5.0-SNAPSHOT-576.jar

COPY scripts/entrypoint_velocity.sh /entrypoint_velocity.sh
RUN chmod 755 /entrypoint_velocity.sh

EXPOSE 25565

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint_velocity.sh"]