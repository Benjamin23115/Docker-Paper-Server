########################################################
############## We use a java base image ################
########################################################
FROM eclipse-temurin:21-jre AS build
RUN apt-get update -y && apt-get install -y curl jq bash

ARG version=1.20.4

########################################################
############## Download Paper with API #################
########################################################
WORKDIR /opt/minecraft
COPY ./getpaperserver.sh /
RUN chmod +x /getpaperserver.sh
RUN /getpaperserver.sh ${version}

########################################################
################## Download Plugins ####################
########################################################
WORKDIR /opt/minecraft
COPY ./getPlugins.sh /
RUN chmod +x /getPlugins.sh
RUN bash /getPlugins.sh

########################################################
############## Running environment #####################
########################################################
FROM eclipse-temurin:21-jre AS runtime
ARG TARGETARCH

# Add gosu
RUN set -eux; \
    apt-get update; \
    apt-get install -y gosu; \
    rm -rf /var/lib/apt/lists/*; \
    # verify that the binary works
    gosu nobody true

# Working directory
WORKDIR /data

# Obtain runable jar from build stage
COPY --from=build /opt/minecraft/minecraftspigot.jar /opt/minecraft/paperspigot.jar

#Obtain plugin jars from build stage
COPY --from=build /opt/minecraft/plugins/*.jar /data/plugins/

# Volumes for the external data (Server, World, Config...)
VOLUME "/data"

# Expose minecraft port
EXPOSE 25565/tcp
EXPOSE 25565/udp
EXPOSE 19132/tcp
EXPOSE 19132/udp

# Set memory size
ARG memory_size=4G
ENV MEMORYSIZE=$memory_size

# Set Java Flags
ARG java_flags="-Dlog4j2.formatMsgNoLookups=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=mcflags.emc.gs -Dcom.mojang.eula.agree=true"
ENV JAVAFLAGS=$java_flags

# Set PaperMC Flags
ARG papermc_flags="--nojline"
ENV PAPERMC_FLAGS=$papermc_flags

WORKDIR /data

COPY ./docker-entrypoint.sh /opt/minecraft
RUN chmod +x /opt/minecraft/docker-entrypoint.sh

ENTRYPOINT ["/opt/minecraft/docker-entrypoint.sh"]

