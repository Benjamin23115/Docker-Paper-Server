# Function to download plugin
download_plugin() {
    local plugin_name="$1"
    local download_url="$2"

    echo "-----------------"
    echo "Downloading $plugin_name from $download_url"
    echo "-----------------"

    curl -o "$plugin_name.jar" -L "$download_url"

    if [[ $? -eq 0 ]]; then
        echo "Download of $plugin_name successful."
    else
        echo "Failed to download $plugin_name."
    fi
}
# Make folder "plugins" to store all of the downloaded plugins
mkdir plugins
cd plugins
# EssentialsX for useful commands
ESSENTIALSX_VERSION="2.21.0-dev+76-71ca7ff"
PLUGIN_URL_PREFIX="https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/jars/"

for plugin_name in "EssentialsX" "EssentialsXChat" "EssentialsXSpawn"; do
    download_plugin "$plugin_name" "$PLUGIN_URL_PREFIX${plugin_name}-${ESSENTIALSX_VERSION}.jar"
done

# Geyser and Floodgate to allow Bedrock connections to the server
GEYSER_DOWNLOAD_URL="https://download.geysermc.org/v2/projects/"
for plugin_name in "geyser" "floodgate"; do
    download_plugin "$plugin_name" "$GEYSER_DOWNLOAD_URL${plugin_name}/versions/latest/builds/latest/downloads/spigot"
done

# ViaBackwards + Version to allow previous game versions to connect
VIA_BACKWARDS_VERSION="4.9.2"
for plugin_name in "ViaBackwards"; do
    VIA_DOWNLOAD_URL_PREFIX="https://github.com/ViaVersion/${plugin_name}/releases/download/${VIA_BACKWARDS_VERSION}/"
    download_plugin "$plugin_name" "$VIA_DOWNLOAD_URL_PREFIX${plugin_name}-${VIA_BACKWARDS_VERSION}.jar"
done

VIA_REGULAR_VERSION="4.9.3"
for plugin_name in "ViaVersion"; do
    VIA_DOWNLOAD_URL_PREFIX="https://github.com/ViaVersion/${plugin_name}/releases/download/${VIA_REGULAR_VERSION}/"
    download_plugin "$plugin_name" "$VIA_DOWNLOAD_URL_PREFIX${plugin_name}-${VIA_REGULAR_VERSION}.jar"
done

# LuckPerms to handle permissions
LUCK_PERMS_DOWNLOAD_URL="https://download.luckperms.net/1534/bukkit/loader/LuckPerms-Bukkit-5.4.121.jar"
download_plugin "luckPerms" "$LUCK_PERMS_DOWNLOAD_URL"

# Right Click Harvest for QOL farming
RIGHT_CLICK_HARVEST_DOWNLOAD_URL="https://dev.bukkit.org/projects/rightclickharvest/files/latest"
download_plugin "rightClickHarvest" "$RIGHT_CLICK_HARVEST_DOWNLOAD_URL"

# Sleep Most for QOL day-night cycles
SLEEP_MOST_DOWNLOAD_URL="https://www.spigotmc.org/resources/sleep-most-1-8-1-20-x-the-most-advanced-sleep-plugin-available-percentage-animations.60623/download?version=528694"
download_plugin "sleepMost" "$SLEEP_MOST_DOWNLOAD_URL"

# Cristichi's Tree Capitator for QOL Tree chopping
CRIS_TREE_CAPITATOR_DOWNLOAD_URL="https://dev.bukkit.org/projects/cristichis-tree-capitator/files/latest"
download_plugin "cris-tree-capitator" "$CRIS_TREE_CAPITATOR_DOWNLOAD_URL"

# Instant Restock for QOL Villager Trading
INSTANT_RESTOCK_DOWNLOAD_URL="https://github.com/spartacus04/InstantRestock/releases/download/2.4.2/instantrestock_2.4.2.jar"
download_plugin "instantRestock" "$INSTANT_RESTOCK_DOWNLOAD_URL"
