#!/bin/sh

# If anything fails then immediately exit with a non-zero status
set -e

DOCKER_USER='dockeruser'
DOCKER_GROUP='dockergroup'

# If "dockeruser" doesn't exist then do the initialization process
if ! id "$DOCKER_USER" >/dev/null 2>&1; then
    echo "First start of the docker container, start initialization process."

    # Sets the user and group id accordingly otherwise defaults to 9001
    USER_ID=${PUID:-9001}
    GROUP_ID=${PGID:-9001}
    echo "Starting with $USER_ID:$GROUP_ID (UID:GID)"

    addgroup --gid $GROUP_ID $DOCKER_GROUP
    adduser $DOCKER_USER --shell /bin/sh --uid $USER_ID --ingroup $DOCKER_GROUP --disabled-password --gecos ""

    chown -vR $USER_ID:$GROUP_ID /opt/minecraft
    chmod -vR ug+rwx /opt/minecraft
    # if eula skip is not set then sets permissions for the data volume accordingly
    if [ "$SKIP_PERM_CHECK" != "true" ]; then
        chown -vR $USER_ID:$GROUP_ID /data
    fi
fi
# sets the home directory to the home directory of the docker use
export HOME=/home/$DOCKER_USER
# using gosu runs the minecraft server with the preset memory size, java flags and paper flags
exec $DOCKER_USER:$DOCKER_GROUP java -jar -Xms$MEMORYSIZE -Xmx$MEMORYSIZE $JAVAFLAGS /opt/minecraft/paperspigot.jar $PAPERMC_FLAGS nogui
