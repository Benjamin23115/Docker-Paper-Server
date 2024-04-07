# original script by https://github.com/astorks/PaperMC.sh/blob/master/papermc.sh

# PAPERMC_VERSION=$1
# LATEST_BUILD=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/${PAPERMC_VERSION}" | jq '.builds[-1]')
# LATEST_DOWNLOAD=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/${PAPERMC_VERSION}/builds/${LATEST_BUILD}" | jq '.downloads.application.name' -r)
# echo -----------------
# echo $PAPERMC_VERSION#$LATEST_BUILD
# echo -----------------
# PAPERMC_DOWNLOAD_URL="https://papermc.io/api/v2/projects/paper/versions/${PAPERMC_VERSION}/builds/${LATEST_BUILD}/downloads/${LATEST_DOWNLOAD}"
# curl -s -o minecraftspigot.jar ${PAPERMC_DOWNLOAD_URL}
curl -s -o minecraftspigot.jar "https://api.papermc.io/v2/projects/paper/versions/1.20.4/builds/477/downloads/paper-1.20.4-477.jar"