#!/bin/sh

# This is the entrypoint script for the dockerfile. Executed in the
# container at runtime.  Based on dockcross.

if [[ $# == 0 ]]; then
    # Presumably the image has been run directly, so help the user get
    # started by outputting the dockcross script
    cat /narou/narou.sh
    exit 0
fi

# If we are running docker natively, we want to create a user in the container
# with the same UID and GID as the user on the host machine, so that any files
# created are owned by that user. Without this they are all owned by root.
# The dockcross script sets the NAROU_UID and NAROU_GID vars.
if [[ -n "$NAROU_UID" ]] && [[ -n "$NAROU_GID" ]] && [[ -n "$NAROU_GROUP" ]]; then

    addgroup -g $NAROU_GID $NAROU_GROUP
    adduser -g "" -D -G $NAROU_GROUP -u $NAROU_UID $NAROU_USER
    export HOME=/home/${NAROU_USER}
    chown -R $NAROU_UID:$NAROU_GID $HOME

    addgroup docker
    addgroup $NAROU_USER docker
    # Cannot find a way to specify multiple groups in su-exec.
    # So, adding g+s to kindlegen
    chgrp docker /narou/kindlegen.sh
    chmod g+s /narou/kindlegen.sh

    # Enable passwordless sudo capabilities for the user
    chown root:$NAROU_GID $(which su-exec)
    chmod +s $(which su-exec); sync

    # Run the command as the specified user/group.
    exec su-exec $NAROU_USER /narou/init.sh "$@"
else
    # Just run the command as root.
    exec "$@"
fi
