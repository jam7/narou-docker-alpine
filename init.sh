#!/bin/sh

if [ ! -d "/opt/narou/.narou" ]; then
  unzip -q /opt/AozoraEpub3.zip -d /opt/narou/AozoraEpub3
  cp /opt/AozoraEpub3.jar /opt/narou/AozoraEpub3
  ln -s /opt/kindlegen/kindlegen /opt/AozoraEpub3
  narou init -p /opt/narou/AozoraEpub3
  narou setting device=kindle
  # Do not make .narousetting nor .narou directory at the beginning
  # since narou changes it's behavior of existance of them.
  # However, we need global setting directory under /opt/narou,
  # so moving it here.
  mv $HOME/.narousetting /opt/narou/
  echo -e "---\nalready-server-boot: true" > /opt/narou/.narousetting/server_setting.yaml
fi

exec "$@"
