#!/bin/bash

# manage.sh: configure your binfiles
# usage:
# manage.sh init - initial deploy
# manage.sh rm - undeploy
# manage.sh up - upgrade with latest version

stow=$(which stow)
git=$(which git)

[ -x "$stow" ] || (echo "ERROR: stow missing"; exit 1; )
[ -x "$git" ] || (echo "ERROR: git missing"; exit 1; )

# get package name and stow directory from the script path
pushd $(dirname $0) > /dev/null
scriptpath=$(pwd -P)
popd > /dev/null

package=$(basename "$scriptpath")
stow_dir=$(dirname "$scriptpath")
bin_dir="$HOME/bin"

arg=${1:-"init"}

case "$arg" in
    init)
        $stow -v -d "$stow_dir" -t "$bin_dir" "$package"
        ;;
    rm)
        $stow -v -d "$stow_dir" -t "$bin_dir" -D "$package"
        ;;
    up)
        pushd "$scriptpath" > /dev/null
        "$git" pull
        "$git" submodule update --init --recursive
        popd > /dev/null
        $stow -v -d "$stow_dir" -t "$bin_dir" -R "$package"
        ;;
esac

exit 0
