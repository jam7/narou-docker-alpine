#!/bin/sh

if [ ! -d "/opt/narou/.narou" ]; then
  mkdir /opt/narou/.narousetting
  unzip /opt/AozoraEpub3.zip -d /opt/narou/AozoraEpub3
  ln -s /opt/kindlegen/kindlegen /opt/AozoraEpub3
  narou init -p /opt/narou/AozoraEpub3
  narou setting device=kindle
  echo -e "---\nalready-server-boot: true" > /opt/narou/.narousetting/server_setting.yaml
fi

exec "$@"
