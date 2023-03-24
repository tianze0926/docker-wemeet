usermod --non-unique --uid $PUID abc
groupmod --non-unique --gid $PGID abc
if [ -n "$VIDEO_GID" ]; then
    if [ $(getent group video) ]; then
        groupmod --non-unique --gid $VIDEO_GID video
    else
        groupadd --non-unique --gid $VIDEO_GID video
    fi
    usermod -aG video abc
fi

chown --quiet -R $PUID:$PGID /home/abc

runuser -u abc /opt/wemeet/wemeetapp.sh