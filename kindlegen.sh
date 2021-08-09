#!/bin/sh

CMD="/opt/kindlegen/kindlegen"
TTY=""

case .$1 in
.*sh|.*bash) CMD=""; TTY="-ti";;
esac

# Need to specify host's mount point, so we use $HOME/.narou identical to
# narou.sh.
exec docker run $TTY --rm \
    -v "$HOME/.narou":/opt/narou \
    -e KINDLEGEN_UID="$( id -u )" \
    -e KINDLEGEN_GID="$( id -g )" \
    -e KINDLEGEN_USER="$( id -un )" \
    -e KINDLEGEN_GROUP="$( id -gn )" \
    jam7/kindlegen "$CMD" "$@"
