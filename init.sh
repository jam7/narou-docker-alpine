#!/bin/sh

AOZORA_REL=v1.1.1b13Q
AOZORA_ZIP=AozoraEpub3-1.1.1b13Q.zip
AOZORA_DIR=/opt/narou/AozoraEpub3-1.1.1b13Q

# Extract the latest AozoraEpub3 to /opt/narou (host's $HOME/.narou).
if [ ! -d ${AOZORA_DIR} ]; then

  curl -L https://github.com/kyukyunyorituryo/AozoraEpub3/releases/download/${AOZORA_REL}/${AOZORA_ZIP} -o /tmp/${AOZORA_ZIP}
  unzip -q /tmp/${AOZORA_ZIP} -d /opt/narou
  ln -s /narou/kindlegen.sh ${AOZORA_DIR}/kindlegen

  # Create dummy directories
  mkdir -p ${AOZORA_DIR}/template/OPS/css_custom/

  # Initialize by narou
  narou init -p ${AOZORA_DIR} -l 1.6
fi

if [ ! -d "/opt/narou/.narousetting" ]; then
  narou setting device=kindle
  # Do not make .narousetting nor .narou directory at the beginning
  # since narou changes it's behavior of existance of them.
  # However, we need global setting directory under /opt/narou,
  # so moving it here.
  mv $HOME/.narousetting /opt/narou/
  echo -e "---\nalready-server-boot: true" > /opt/narou/.narousetting/server_setting.yaml
fi

exec "$@"
