#!/bin/sh
#
# Usage:
#   narou <narou-command>
#
# Example:
#   narou -h                    to see on-line help
#   narou ls                    to see the list of contents
#   narou download n4830bu      to download n4830bu narou-shousetsu
#   narou web                   to start web UI
#
# Notice:
#   "narou web" ignore all options and starts web UI at localip:8000

envs="http_proxy https_proxy ftp_proxy no_proxy"
data=$HOME/.narou

# check environment variables of particular names in $envs and pass them to container
for i in $envs; do
  v=`eval echo $"$i"`
  case x$v in
  x) ;;   # nothing to do
  *) opt="-e $i=$v $opt"
  esac
done

# initialize narou configuration directory
if [ ! -d $data ]; then
  mkdir $data
fi

CMD="narou"
TTY="-ti"

case x$1 in
xw|xweb)
  # retrieve external IP address of local machine to allow access from other machiens
  IP=`ip route get 1|grep src|sed -e 's:^.*src \([1-9][0-9.]*\).*$:\1:'`
  echo "connect $IP:8000 from web browser"
  opt="-p $IP:8000-8001:8000-8001 $opt"
  set -- web -p 8000 -n
  narou s server-ws-add-accepted-domains=$IP
  ;;
xsh|xbash)
  CMD=""
  TTY="-ti"
  ;;
xinit)
  case x$# in
  x1)
    set -- init -p /opt/narou/AozoraEpub3 --line-height 1.6
    ;;
  esac
  ;;
esac

if [ -d /mnt/Kindle/documents ]; then
  MNT_KINDLE_OPT="-v"
  MNT_KINDLE="/mnt/Kindle/documents:/mnt/Kindle/documents"
else
  MNT_KINDLE_OPT=""
  MNT_KINDLE=""
fi

# Need to mount docker.sock in order to use jam7/kindlegen docker image.
# Need to mount kindle device also.
#   '-v /mnt/Kindle:/mnt/Kindle' rarely works.
#   '-v /mnt/Kindle/documents:/mnt/Kindle/documents' works.
#   Related issue: https://github.com/docker/for-win/issues/2151
docker run $TTY --rm $opt \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $data:/opt/narou \
    $MNT_KINDLE_OPT $MNT_KINDLE \
    -e NAROU_UID="$( id -u )" \
    -e NAROU_GID="$( id -g )" \
    -e NAROU_USER="$( id -un )" \
    -e NAROU_GROUP="$( id -gn )" \
    jam7/narou $CMD "$@"
