#!/bin/bash

# install.sh: initial package deployment (clone from git and init)
# usage:
# bash install.sh
# bash install.sh INSTALL_PATH
# bash install.sh INSTALL_PATH PACKAGE

git=$(which git)
[ -x "$git" ] || { echo "ERROR: git missing"; exit 1; }

# get script path
pushd $(dirname $0) > /dev/null
scriptpath=$(pwd -P)
popd > /dev/null

if [ -x "$scriptpath/manage.sh" ]; then
    echo "ERROR: package installed, use manage.sh"
    exit 1
fi


install_path=${1:-"$HOME/stow"}
package=${2:-"binfiles"}
url="https://github.com/rdezavalia/binfiles.git"

[ ! -d "$install_path/$package" ] || { echo "ERROR: package exists"; exit 1; }
mkdir -p "$install_path"
pushd "$install_path" > /dev/null
"$git" clone --recursive "$url" "$package"
"./$package/manage.sh"
popd > /dev/null
