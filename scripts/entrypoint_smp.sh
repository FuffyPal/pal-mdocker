#!/bin/bash

mkdir -p /data/plugins
cd /data

if [ ! -f "purpur.jar" ]; then
    cp /purpur.jar /data/purpur.jar
fi

if [ ! -f "eula.txt" ] || ! grep -q "eula=true" eula.txt; then
    echo "eula=true" > eula.txt
fi

if [ -d "/shared/plugins" ]; then
    ln -sf /shared/plugins/*.jar /data/plugins/
fi

if [ -d "/shared/configs" ]; then
    for dir in /shared/configs/*; do
        if [ -d "$dir" ]; then
            plugin_name=$(basename "$dir")
            echo "Linking config for $plugin_name..."
            ln -sfn "$dir" "/data/plugins/$plugin_name"
        fi
    done
fi

exec java -Xms400M -Xmx3000M \
    -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 \
    -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch \
    -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M \
    -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 \
    -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 \
    -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem \
    -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Dterminal.jline=false \
    -jar purpur.jar nogui